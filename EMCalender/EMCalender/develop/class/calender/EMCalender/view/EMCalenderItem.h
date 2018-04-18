//
//  EMCalenderItem.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EMCalenderMarkTypeEvent,
    EMCalenderMarkTypeRemind,
    EMCalenderMarkTypeNone,
} EMCalenderMarkType;

@class EMIndexPath,EMCalenderDay;
@interface EMCalenderItem : UIControl

/// border color
@property(nonatomic,strong) UIColor * borderColor;
/// indexPath
@property(nonatomic,strong) EMIndexPath * indexPath;
/// EMCalenderDay
@property(nonatomic,strong) EMCalenderDay * day;
// mark
@property(nonatomic,assign) EMCalenderMarkType markType;

@end
