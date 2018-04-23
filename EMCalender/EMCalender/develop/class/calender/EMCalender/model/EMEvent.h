//
//  EMEvent.h
//  EMCalender
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <EventKit/EventKit.h>


@class EKAlarm;
@interface EMEvent : NSObject

/// title
@property(nonatomic,copy) NSString * title;
/// location
@property(nonatomic,copy) NSString * location;
/// start date (yyyy-MM-dd HH:mm:ss)
@property(nonatomic,copy) NSString * start;
/// end date (yyyy-MM-dd HH:mm:ss)
@property(nonatomic,copy) NSString * end;
/// all day
@property(nonatomic,assign) BOOL allDay;
/// EKAlarm array
@property(nonatomic,strong) NSArray<EKAlarm *> * alarms;

@end
