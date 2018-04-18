//
//  EMCalenderCell.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

/// EMCalenderCell 复用ID
#define EM_CALENDER_CELL_ID @"EM_CALENDER_CELL_ID"

@class EMCalenderMonth,EMCalenderItem;
@interface EMCalenderCell : UICollectionViewCell

/// EMCalenderMonth
@property(nonatomic,strong) EMCalenderMonth * month;
/// EMCalenderItems
@property(nonatomic,strong,readonly) NSArray<EMCalenderItem *> * items;

-(EMCalenderItem *)itemInLocation:(CGPoint)location;

@end
