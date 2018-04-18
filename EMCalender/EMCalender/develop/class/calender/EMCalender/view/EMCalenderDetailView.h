//
//  EMCalenderDetailView.h
//  EMCalender
//
//  Created by tramp on 2018/4/18.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMCalenderDetailView : UIView


/**
 展示

 @param location 起始点
 @param information 携带信息
 */
-(void)showInLocation:(CGPoint) location info:(id)information;

@end
