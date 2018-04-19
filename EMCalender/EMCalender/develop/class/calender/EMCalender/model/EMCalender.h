//
//  EMCalender.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMCalenderMonth,EMCalenderDay;
@interface EMCalender : NSObject

/// current EMCalenderDay
@property(nonatomic,strong) EMCalenderDay * currentDay;


/**
 异步获取年份数据

 @param year 指定年份
 @param completionHandler 完成回调
 */
-(void)asynchronousLoadDataForYear:(NSInteger) year
                 completionHandler:(void(^)(NSArray<EMCalenderMonth *> * array)) completionHandler;

/**
 获取年份数据

 @param year 指定年份
 @return 年份数据
 */
-(NSArray<EMCalenderMonth *> *)dataForYear:(NSInteger) year;

@end
