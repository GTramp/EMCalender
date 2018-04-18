//
//  EMIndexPath.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMIndexPath : NSObject

/// row
@property(nonatomic,assign) NSInteger row;
/// column
@property(nonatomic,assign) NSInteger column;

+(EMIndexPath *)indexPathWithRow:(NSInteger)row column:(NSInteger)column;
-(EMIndexPath *)initWithRow:(NSInteger)row column:(NSInteger)column;

@end
