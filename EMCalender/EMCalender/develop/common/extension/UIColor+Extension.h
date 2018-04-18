//
//  UIColor+Extension.h
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/// 随即色
+(UIColor *)randomColor;

/**
 hex color

 @param hex hex string
 @param alpha 透明度
 @return UIColor
 */
+(UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat) alpha;

/**
 hex color

 @param hex hex string
 @return UIColor
 */
+(UIColor *)colorWithHex:(NSString *)hex;

@end
