//
//  EMCalenderEditView.h
//  EMCalender
//
//  Created by tramp on 2018/4/18.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    EM_CALENDER_EDIT_TYPE_SCHEDULE,
    EM_CALENDER_EDIT_TYPE_TASK,
    EM_CALENDER_EDIT_TYPE_NONE,
} EM_CALENDER_EDIT_TYPE;

@class EMCalenderEditView,EMEvent;
@protocol EMCalenderEditViewDelegate<NSObject>

@optional
-(void)calenderEditView:(EMCalenderEditView *)editView commitAction:(EMEvent *) event eidtType:(EM_CALENDER_EDIT_TYPE) eidtType;

@end

@interface EMCalenderEditView : UIView

/// delegate
@property(nonatomic,weak) id<EMCalenderEditViewDelegate> delegate;

-(void)showWidthStartDate:(NSDate *) start endDate:(NSDate *) endDate;
/**
 show
 */
//-(void)show;

/**
 dismiss
 */
-(void)dismiss;

@end
