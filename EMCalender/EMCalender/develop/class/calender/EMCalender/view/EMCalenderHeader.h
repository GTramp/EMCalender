//
//  EMCalenderHeader.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMCalenderHeader : UIView
/// titles 
@property(nonatomic,strong) NSArray<NSString *> * titles;
/// border color
@property(nonatomic,strong) UIColor * borderColor;

/**
 选中title

 @param isSelected BOOL
 @param index 下标
 */
-(void)selected:(BOOL) isSelected index:(NSInteger) index;

@end
