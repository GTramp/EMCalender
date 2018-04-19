//
//  EMCalenderMonth.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderMonth.h"

@implementation EMCalenderMonth


-(NSString *)description {
    NSArray * keys = @[@"date",@"year",@"month"];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
