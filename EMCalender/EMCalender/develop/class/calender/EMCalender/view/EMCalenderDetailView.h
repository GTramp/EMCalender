//
//  EMCalenderDetailView.h
//  EMCalender
//
//  Created by tramp on 2018/4/18.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMCalenderDetailView;
@protocol EMCalenderDetailViewDelegate<NSObject>
@optional
-(void)detailView:(EMCalenderDetailView *)detailView addButtonActionHandler:(UIButton *) addButton;

@end

@interface EMCalenderDetailView : UIView

/// delegate
@property(nonatomic,weak) id<EMCalenderDetailViewDelegate> delegate;

/**
 展示

 @param location 起始点
 @param information 携带信息
 */
-(void)showInLocation:(CGPoint) location info:(id)information;

@end
