//
//  UIView+Extension.m
//  EMCalender
//
//  Created by tramp on 2018/4/20.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/// current UIViewController
-(UIViewController *)currentVC {
    UIResponder * next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


@end
