//
//  EMCalenderMonth.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMCalenderDay;
@interface EMCalenderMonth : NSObject

/// NSDate
@property(nonatomic,strong) NSDate * date;
/// year
@property(nonatomic,assign) NSInteger year;
/// month
@property(nonatomic,assign) NSInteger month;
/// EMCalenderDay array;
@property(nonatomic,strong) NSArray<EMCalenderDay *> * days;
@end
