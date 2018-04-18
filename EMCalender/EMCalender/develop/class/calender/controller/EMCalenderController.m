//
//  EMCalenderController.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderController.h"
#import "EMCalenderView.h"
#import <Masonry.h>
#import "EMCalenderDay.h"

@interface EMCalenderController ()<EMCalenderViewDelegate>

/// calender view
@property(nonatomic,strong) EMCalenderView * calenderView;

@end

@implementation EMCalenderController

// MARK: - 生命周期 -

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化Ui
    [self initUi];
}

// MARK: - EMCalenderViewDelegate -
-(void)calenderView:(EMCalenderView *)calenderView changeValue:(EMCalenderDay *)value {
    // update title
    self.navigationItem.title = [NSString stringWithFormat:@"%ld-%ld",value.year, value.month];
}

// MARK: - 初始化 -

/// 初始化UI
-(void)initUi {
    // 预设
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    // calender view
    [self.view addSubview:self.calenderView];
    [_calenderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


// MAKR: - 懒加载 -
-(EMCalenderView *)calenderView {
    if (!_calenderView) {
        _calenderView = [[EMCalenderView alloc] init];
        _calenderView.delegate = self;
    }
    return _calenderView;
}

@end
