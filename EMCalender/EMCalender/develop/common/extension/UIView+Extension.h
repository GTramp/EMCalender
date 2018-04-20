//
//  UIView+Extension.h
//  EMCalender
//
//  Created by tramp on 2018/4/20.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 获取当前控制器 :: 需要存在直接或者间接关系

 @return UIViewController
 */
-(UIViewController *)currentVC;

@end
