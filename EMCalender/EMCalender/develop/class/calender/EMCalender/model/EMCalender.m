//
//  EMCalender.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalender.h"
#import "EMCalenderMonth.h"
#import "EMCalenderDay.h"
#import <EventKit/EventKit.h>

@interface EMCalender ()

/// calender
@property(nonatomic,strong) NSCalendar * calender;
/// date formatter
@property(nonatomic,strong) NSDateFormatter * dateFormatter;
/// event store
@property(nonatomic,strong) EKEventStore * eventStore;

@end

@implementation EMCalender

// MARK: - 生命周期 -
-(instancetype)init {
    if (self = [super init]) {
        // initialzation
        [self initialzation];
    }
    return self;
}

// MARK: - 自定义方法 -

/// 异步获取年份数组
-(void)asynchronousLoadDataForYear:(NSInteger) year completionHandler:(void(^)(NSArray<EMCalenderMonth *> * array)) completionHandler {
    
    // default month count
    NSInteger monthCount = 12;
    // EMCalenderMonth array
    NSMutableArray<EMCalenderMonth *> * monthArr = [NSMutableArray arrayWithCapacity:monthCount + 2];
    // GCD 队列组
    dispatch_group_t group = dispatch_group_create();
    // 加入队列组
    for (NSInteger i = 0; i < monthCount; i++) {
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self synchronizeLoadDataForMonth:i+1 inYear:year completionHanlder:^(EMCalenderMonth *caldnderMonth) {
                [monthArr addObject:caldnderMonth];
                dispatch_group_leave(group);
            }];
        });
    }
    
    // last year last month
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self synchronizeLoadDataForMonth:12 inYear:year-1 completionHanlder:^(EMCalenderMonth *caldnderMonth) {
            [monthArr addObject:caldnderMonth];
            dispatch_group_leave(group);
        }];
    });
    
    // next year first month
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self synchronizeLoadDataForMonth:1 inYear:year+1 completionHanlder:^(EMCalenderMonth *caldnderMonth) {
            [monthArr addObject:caldnderMonth];
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 排序
        [monthArr sortUsingComparator:^NSComparisonResult(EMCalenderMonth * obj1,EMCalenderMonth * obj2) {
            return [obj1.date compare:obj2.date];
        }];
        
        // invoke completion block in mian queue
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(monthArr);
            }
        });
    });
}


/// 获取月份数据(同步)
-(void)synchronizeLoadDataForMonth:(NSInteger) month
                            inYear:(NSInteger) year
                 completionHanlder:(void(^)(EMCalenderMonth * caldnderMonth)) completionHanlder {
    
    // length
    NSInteger length = 35;
    // day count
    NSInteger dayCount = [self numberOfMonth:month inYear:year];
    // first week day
    NSInteger first = [self firstWeekDayOfMonth:month inYear:year];
    /// ----------------------- start / end date ----------------------------------------------
    // start date
    NSDate * startDate = nil;
    if (first) {
        if (month == 1) {
            // 上个月的dayCount
            NSInteger lastDayCount = [self numberOfMonth:12 inYear:year-1];
            // start date
            NSString * dateString = [NSString stringWithFormat:@"%ld-12-%02ld 00:00:00",year-1, lastDayCount - first + 1];
            startDate = [_dateFormatter dateFromString:dateString];
        } else {
            // 上个月的dayCount
            NSInteger lastDayCount = [self numberOfMonth:month-1 inYear:year];
            // start date
            NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld 00:00:00",year,month-1, lastDayCount - first + 1];
            startDate = [_dateFormatter dateFromString:dateString];
        }
    } else {
        // start date
        NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01 00:00:00",year,month];
        startDate = [_dateFormatter dateFromString:dateString];
    }
    
    // end date
    NSDate * endDate = nil;
    NSInteger next = length - dayCount - first;
    if (next > 0) {
        if (month == 12) {
            // date string
            NSString * dateString = [NSString stringWithFormat:@"%ld-01-%02ld 23:59:59",year+1,next];
            // end date
            endDate = [_dateFormatter dateFromString:dateString];
        } else {
            // date string
            NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld 23:59:59",year, month+1, next];
            // end date
            endDate = [_dateFormatter dateFromString:dateString];
        }
        
    } else if (next == 0) {
        // date string
        NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld 23:59:59",year,month,dayCount];
        // end date
        endDate = [_dateFormatter dateFromString:dateString];
    } else {
        // date string
        NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld 23:59:59",year,month,length-first];
        // end date
        endDate = [_dateFormatter dateFromString:dateString];
    }
    
    
    /// ------------------------ EventKit -------------------------------------------------------
    // 获取授权
    __weak typeof(self) weakSelf = self;
    [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"%@",error);
            return ;
        }
        
        // 谓词
        NSPredicate * predicate = [weakSelf.eventStore predicateForEventsWithStartDate:startDate
                                                                               endDate:endDate
                                                                             calendars:nil];
        // 获取 EKEvent
        
        NSArray<EKEvent*> * events = [weakSelf.eventStore eventsMatchingPredicate:predicate];
        
        // NSMutableArray<EMCalenderDay*>
        NSMutableArray<EMCalenderDay *> * dayArr = [NSMutableArray arrayWithCapacity:length];
        for (NSInteger i = 0; i < length; i ++) {
            // date
            NSDate * date = [startDate dateByAddingTimeInterval:(60*60*24) * i];
            // date components
            NSDateComponents * components = [weakSelf.calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                 fromDate:date];
            // EMCalenderDay
            EMCalenderDay * calenderDay = [[EMCalenderDay alloc] init];
            // 赋值
            calenderDay.date = date;
            calenderDay.year = components.year;
            calenderDay.month = components.month;
            calenderDay.day = components.day;
            components.month == month ? (calenderDay.inMonth = YES) : (calenderDay.inMonth = NO);
            
            // EKEvent
            for (EKEvent * event in events) {
                NSComparisonResult result1 = [event.startDate compare:date];
                NSComparisonResult result2 = [event.endDate compare:date];
                if (result1 == NSOrderedSame  || result2 == NSOrderedSame || (result1 == NSOrderedAscending && result2 == NSOrderedDescending)) {
                    calenderDay.event = event;
                }
            }
            // 加入 array
            [dayArr addObject:calenderDay];
        }
        
        // date
        NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01 00:00:00",year,month];
        NSDate * date = [weakSelf.dateFormatter dateFromString:dateString];
        // EMCalenderMonth
        EMCalenderMonth * calenderMonth = [[EMCalenderMonth alloc] init];
        calenderMonth.date = date;
        calenderMonth.year = year;
        calenderMonth.month = month;
        calenderMonth.days = dayArr;
        
        // invoke completion block in main queue
        if (completionHanlder) {
            completionHanlder(calenderMonth);
        }
    }];
}


/// 获取每月的第一天为周几 0. Sunday 1. Monday 2. Tuesday 3. Wednesday 4. Thursday 5. Friday 6. Saturday
-(NSInteger)firstWeekDayOfMonth:(NSInteger) month inYear:(NSInteger) year {
    // date string
    NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01 00:00:00",year,month];
    // date
    NSDate * date = [_dateFormatter dateFromString:dateString];
    NSInteger weekDay = [_calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    // 返回
    return weekDay - 1;
}

/// 获取每月的天数
-(NSInteger)numberOfMonth:(NSInteger)month inYear:(NSInteger) year {
    // date string
    NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01 00:00:00",year,month];
    // date
    NSDate * date = [_dateFormatter dateFromString:dateString];
    // NSRange
    NSRange range = [_calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    // 返回天数
    return range.length;
}

// MAR: - getter -
-(EMCalenderDay *)currentDay {
    // date
    NSDate * date = [NSDate date];
    // NSDateComponents
    NSDateComponents * components = [_calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    // EMCalenderDay
    EMCalenderDay * day = [[EMCalenderDay alloc] init];
    day.date = date;
    day.year = components.year;
    day.month = components.month;
    day.day = components.day;
    day.inMonth = NO;
    return day;
}

// MARK: - 初始化 -

/// initialzation
-(void)initialzation {
    // calender
    _calender = [NSCalendar autoupdatingCurrentCalendar];
    // date formatter
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // event store
    _eventStore = [[EKEventStore alloc] init];
}


@end
