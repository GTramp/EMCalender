//
//  AppDelegate+Extension.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "EMMainController.h"

@implementation AppDelegate (Extension)

/// 初始化
-(void)initialization {
    // 初始化窗口
    [self initWindow];
}

/// 初始化窗口
-(void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    EMMainController * calenderVC = [[EMMainController alloc] init];
    UINavigationController * navigationVC = [[UINavigationController alloc] initWithRootViewController:calenderVC];
    self.window.rootViewController = navigationVC;
    [self.window makeKeyAndVisible];
}

@end
