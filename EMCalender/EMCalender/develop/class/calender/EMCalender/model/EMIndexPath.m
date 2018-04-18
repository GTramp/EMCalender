//
//  EMIndexPath.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMIndexPath.h"

@implementation EMIndexPath

+(EMIndexPath *)indexPathWithRow:(NSInteger)row column:(NSInteger)column {
    return [[self alloc] initWithRow:row column:column];
}

-(EMIndexPath *)initWithRow:(NSInteger)row column:(NSInteger)column {
    if (self = [super init]) {
        _row = row;
        _column = column;
    }
    return self;
}

@end
