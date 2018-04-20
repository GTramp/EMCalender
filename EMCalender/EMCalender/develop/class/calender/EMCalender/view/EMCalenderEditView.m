//
//  EMCalenderEditView.m
//  EMCalender
//
//  Created by tramp on 2018/4/18.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderEditView.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface EMCalenderEditView ()<UIScrollViewDelegate>

/// detail button
@property(nonatomic,strong) UIButton * detailButton;
/// sure button
@property(nonatomic,strong) UIButton * sureButton;
/// schedule view
@property(nonatomic,strong) UIView * scheduleView;
/// task view
@property(nonatomic,strong) UIView * taskView;
/// sort button
@property(nonatomic,strong) UIButton * sortButton;
/// sort view
@property(nonatomic,strong) UIView * sortView;

@end

@implementation EMCalenderEditView
// MARK: - 生命周期 -
-(instancetype)init {
    if (self = [super init]) {
        // init ui
        [self initUi];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    
    if ([touch.view isMemberOfClass:[EMCalenderEditView class]]) {
        // dismiss
        [self dismiss];
    }
}

// MARK: - 自定义方法 -

/// show sort view
-(void)showSortView {
    [UIView animateWithDuration:0.25f animations:^{
        self.sortView.transform = CGAffineTransformIdentity;
    }];
}

/// sort button handler
-(void)sortButtonAtionHanler:(UIButton *) sender {
    // show sort view
    [self showSortView];
}

/// swipe gesture
-(void)swipeGestureHandler:(UISwipeGestureRecognizer *) gesture {
    
    CGAffineTransform  transform;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        transform = CGAffineTransformMakeTranslation( 48.f - [UIScreen mainScreen].bounds.size.width , 0);
    } else {
        transform = CGAffineTransformIdentity;
    }
    
    // update tramform
    [UIView animateWithDuration:0.25 animations:^{
        self.scheduleView.transform = transform;
        self.taskView.transform = transform;
    }];
}

/// show
-(void)show {
    // UIWindow
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    // frame
    self.frame = window.frame;
    // add
    [window addSubview:self];
    // alpha
    self.alpha = 1.0f;
}

/// dismiss
-(void)dismiss {
    
    [UIView animateWithDuration:0.25f animations:^{
        self.sortView.transform = CGAffineTransformMakeTranslation(0, 240.f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        // update to original transform
        self.scheduleView.transform = CGAffineTransformIdentity;
        self.taskView.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];
}

// MAKR: - 初始化-

/// init Ui
-(void)initUi {
    // background color
    self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.6];
    
    // schedule view
    [self addSubview:self.scheduleView];
    [_scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(98.f);
        make.left.mas_equalTo(self).offset(32.f);
        make.right.mas_equalTo(self).offset(-32.f);
        make.height.mas_equalTo(120.f);
    }];
    
    // task view
    [self addSubview:self.taskView];
    [_taskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scheduleView.mas_right).offset(16.f);
        make.size.top.mas_equalTo(self.scheduleView);
    }];
    
    // detail button
    [self addSubview:self.detailButton];
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scheduleView);
        make.height.mas_equalTo(64.f);
        make.right.mas_equalTo(self.scheduleView.mas_centerX).offset(-0.5f);
        make.top.mas_equalTo(self.scheduleView.mas_bottom).offset(16.f);
    }];
    
    // sure button
    [self addSubview:self.sureButton];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.mas_equalTo(self.detailButton);
        make.right.mas_equalTo(self.scheduleView);
    }];
    
    // sort button
    [_scheduleView addSubview:self.sortButton];
    [_sortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.scheduleView).offset(-16.f);
    }];
    
    /// sort view
    [self addSubview:self.sortView];
    [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(240.f);
    }];
    _sortView.transform = CGAffineTransformMakeTranslation(0, 240.f);
}

// MARK: - 懒加载 -

/// sort view
-(UIView *)sortView {
    if (!_sortView) {
        _sortView = [[UIView alloc] init];
        _sortView.backgroundColor = [UIColor whiteColor];
    }
    return _sortView;
}

/// sort button
-(UIButton *)sortButton {
    if (!_sortButton) {
        _sortButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_sortButton addTarget:self action:@selector(sortButtonAtionHanler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;
}

/// sure button
-(UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = [UIColor whiteColor];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor colorWithHex:@"#696969"] forState:UIControlStateNormal];
    }
    return _sureButton;
}

/// detail button
-(UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.backgroundColor = [UIColor whiteColor];
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailButton setTitleColor:[UIColor colorWithHex:@"#696969"] forState:UIControlStateNormal];
    }
    return _detailButton;
}

/// task view
-(UIView *)taskView {
    if (!_taskView) {
        _taskView = [[UIView alloc] init];
        _taskView.backgroundColor = [UIColor whiteColor];
        
        // UISwipeGestureRecognizer
        UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_taskView addGestureRecognizer:swipe];
    }
    return _taskView;
}

/// schedule
-(UIView *)scheduleView {
    if (!_scheduleView) {
        _scheduleView = [[UIView alloc] init];
        _scheduleView.backgroundColor = [UIColor whiteColor];
        
        // UISwipeGestureRecognizer
        UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [_scheduleView addGestureRecognizer:swipe];
    }
    return _scheduleView;
}

@end
