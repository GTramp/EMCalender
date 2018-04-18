//
//  EMCalenderView.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMCalenderView,EMCalenderDay;
@protocol EMCalenderViewDelegate <NSObject>

@optional
-(void)calenderView:(EMCalenderView *) calenderView changeValue:(EMCalenderDay *) value;

@end

@interface EMCalenderView : UIView

/// delegate
@property(nonatomic,weak) id<EMCalenderViewDelegate> delegate;

@end
