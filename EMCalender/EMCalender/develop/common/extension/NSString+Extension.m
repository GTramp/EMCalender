//
//  NSString+Extension.m
//  EMCalender
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/// 查询参数
-(NSString *)queryValueForKey:(NSString *)key {
    
    // 获取 query
    NSString * query = self;
    if ([self containsString:@"?"]) {
        query = [query componentsSeparatedByString:@"?"].lastObject;
    }
    
    if ([query containsString:@"&"]) { // 多个参数
        NSArray * paramsArr = [query componentsSeparatedByString:@"&"];
        for (NSString * item in paramsArr) {
            if ([item containsString:@"="]) {
                NSArray * itemArr = [item componentsSeparatedByString:@"="];
                if ([itemArr.firstObject isEqualToString:key]) {
                    return itemArr.lastObject;
                }
            }
        }
        return nil;
    } else { // 单个参数
        if ([query containsString:@"="]) {
            NSArray * itemArr = [query componentsSeparatedByString:@"="];
            if ([itemArr.firstObject isEqualToString:key]) {
                return itemArr.lastObject;
            }
        } else {
            return nil;
        }
    }
    
    return nil;
}

@end
