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
        
        // FIXME: - 测试 -
        [self loadEvents];
    }
    return self;
}

// MARK: - 自定义方法 -

/// 获取 EKEvent
-(void)loadEvents {
    // 获取授权
    __weak typeof(self) weakSelf = self;
    [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"用户授权失败-> error: %@",error);
            return;
        }
        //  谓词
        NSDateComponents * components = [[NSDateComponents alloc] init];
        components.year = -1;
        
        NSDate * start = [weakSelf.calender dateByAddingComponents:components
                                                            toDate:[NSDate date]
                                                           options:0];
        NSDate * end = [NSDate date];
        
        NSPredicate * prediceate = [weakSelf.eventStore predicateForEventsWithStartDate:start
                                                                                endDate:end
                                                                              calendars:nil];
        NSArray<EKEvent * >* events = [weakSelf.eventStore eventsMatchingPredicate:prediceate];
        
        for (EKEvent * event in events) {
            NSLog(@"%@",event);
        }
    }];
}

/// 获取年份数据
-(NSArray<EMCalenderMonth *> *)dataForYear:(NSInteger) year {
    // month count
    NSInteger monthCount = 12;
    // EMCalenderMonth array
    NSMutableArray<EMCalenderMonth *> * monthArray = [NSMutableArray arrayWithCapacity:monthCount + 2];
    
    for (NSUInteger i = 1; i <= monthCount; i ++) {
        
        // EMCalenderMonth
        EMCalenderMonth *month = [self dataForMonth:i inYear:year];
        // add into array
        [monthArray addObject:month];
    }
    
    // next year
    [monthArray addObject:[self dataForMonth:1 inYear:year+1]];
    // last year
    [monthArray insertObject:[self dataForMonth:12 inYear:year-1] atIndex:0];
    
    return monthArray.copy;
}

/// 获取月份数据
-(EMCalenderMonth *)dataForMonth:(NSInteger) month inYear:(NSInteger) year {
    // EMCalenderMonth
    EMCalenderMonth *calenderMonth = [[EMCalenderMonth alloc] init];
    // 赋值
    calenderMonth.year = year;
    calenderMonth.month = month;
    
    // 获取天数
    NSInteger dayCount = [self numberOfMonth:month inYear:year];
    // 获取本月第一天星期几
    NSInteger first = [self firstWeekDayOfMonth:month inYear:year];
    
    // days array
    NSInteger capacity = 35;
    NSMutableArray<EMCalenderDay *> * dayArray = [NSMutableArray arrayWithCapacity: capacity];
    
    // start index
    NSInteger startIndex = 0;
    
    // 设置数据
    for (NSInteger i = 1; i <= capacity; i ++) {
        // EMCalenderDay
        EMCalenderDay * calenderDay = [[EMCalenderDay alloc] init];
        
        
        if (i <= first) {
            NSInteger _year = year;
            NSInteger _month = month;
            
            if (_month == 1) {
                _year --;
                _month = 12;
            } else {
                _month --;
            }
            // update day count
            NSInteger  _dayCount = [self numberOfMonth:_month inYear:_year];
            
            // year
            calenderDay.year = _year;
            // month
            calenderDay.month = _month;
            // day
            calenderDay.day = _dayCount - first + i;
            // date
            _dateFormatter.dateFormat = @"yyyy-MM-dd";
            NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",calenderDay.year,calenderDay.month,calenderDay.day];
            calenderDay.date = [_dateFormatter dateFromString:dateString];
            
            // in month
            calenderDay.inMonth = NO;
            
        } else if (i > dayCount + first) {
            NSInteger _year = year;
            NSInteger _month = month;
            
            if (month == 12) {
                _year ++;
                _month = 1;
            } else {
                _month ++;
            }
            
            // year
            calenderDay.year = _year;
            // month
            calenderDay.month = _month;
            // day
            calenderDay.day = (++ startIndex);
            // date
            _dateFormatter.dateFormat = @"yyyy-MM-dd";
            NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",calenderDay.year,calenderDay.month,calenderDay.day];
            calenderDay.date = [_dateFormatter dateFromString:dateString];
            
            // in month
            calenderDay.inMonth = NO;
            
        } else {
            // year
            calenderDay.year = year;
            // month
            calenderDay.month = month;
            // day
            calenderDay.day = i - first;
            // date
            _dateFormatter.dateFormat = @"yyyy-MM-dd";
            NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",calenderDay.year,calenderDay.month,calenderDay.day];
            calenderDay.date = [_dateFormatter dateFromString:dateString];
            
            // in month
            calenderDay.inMonth = YES;
        }
        
        [dayArray addObject:calenderDay];
    }
    calenderMonth.days = dayArray.copy;
    
    return calenderMonth;
}

/// 获取每月的第一天为周几 0. Sunday 1. Monday 2. Tuesday 3. Wednesday 4. Thursday 5. Friday 6. Saturday
-(NSInteger)firstWeekDayOfMonth:(NSInteger) month inYear:(NSInteger) year {
    // date formatter
    _dateFormatter.dateFormat = @"yyyy-MM-dd";
    // date string
    NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01",year,month];
    // date
    NSDate * date = [_dateFormatter dateFromString:dateString];
    NSInteger weekDay = [_calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    // 返回
    return weekDay - 1;
}

/// 获取每月的天数
-(NSInteger)numberOfMonth:(NSInteger)month inYear:(NSInteger) year {
    // date formatter
    _dateFormatter.dateFormat = @"yyyy-MM-dd";
    // date string
    NSString * dateString = [NSString stringWithFormat:@"%ld-%02ld-01",year,month];
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
    _calender = [NSCalendar currentCalendar];
    // date formatter
    _dateFormatter = [[NSDateFormatter alloc] init];
    // event store
    _eventStore = [[EKEventStore alloc] init];
}


@end
