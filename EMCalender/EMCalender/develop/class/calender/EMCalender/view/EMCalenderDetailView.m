//
//  EMCalenderDetailView.m
//  EMCalender
//
//  Created by tramp on 2018/4/18.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderDetailView.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface EMCalenderDetailView ()

/// content view
@property(nonatomic,strong) UIView * contentView;
/// detail view
@property(nonatomic,strong) UIView * detailView;
/// contact button
@property(nonatomic,strong) UIButton * contactButton;

@end

@implementation EMCalenderDetailView

// MARK: - 生命周期-
-(instancetype)init {
    if (self = [super init]) {
        // init Ui
        [self initUi];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isMemberOfClass:[self class]]) {
        [self dismiss];
    }
}

// MARK: - 自定义方法 -
/// show in location
-(void)showInLocation:(CGPoint)location info:(id)information {
    // window
    UIWindow * window = [UIApplication sharedApplication].windows.firstObject;
    // frame
    self.frame = window.frame;
    // add
    [window addSubview:self];
    
    // --- Animations
    NSTimeInterval animationDuration = 0.25f;
    // scale animation
    CABasicAnimation * scaleAniamtion = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 预设
    scaleAniamtion.fromValue = @(0.0);
    scaleAniamtion.toValue = @(1.0);
    scaleAniamtion.removedOnCompletion = YES;
    
    // position aniamtion
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 预设
    positionAnimation.fromValue = [NSValue valueWithCGPoint:location];
    positionAnimation.toValue = [NSValue valueWithCGPoint:window.center];
    positionAnimation.removedOnCompletion = YES;
    
    // 动画组
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = 1;
    animationGroup.animations = @[positionAnimation,scaleAniamtion];
    [_contentView.layer addAnimation:animationGroup forKey:nil];
}

/// dismiss
-(void)dismiss {
    [self removeFromSuperview];
}

// MARK: - 初始化 -

/// init UI
-(void)initUi {
    // background color
    self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.6];
    
    // content view
    [self addSubview:self.contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self).offset(-32.f);
        make.height.mas_equalTo(400.f);
    }];
    
    // detail
    [_contentView addSubview: self.detailView];
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).offset(-84.f);
    }];
    
    // contact button
    [_contentView addSubview:self.contactButton];
    [_contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(64.f);
    }];
    
}

// MARK: - 懒加载 -

/// contact button
-(UIButton *)contactButton {
    if (!_contactButton) {
        _contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactButton.backgroundColor = [UIColor whiteColor];
        [_contactButton setTitle:@"contact" forState:UIControlStateNormal];
        [_contactButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _contactButton;
}

/// detail view
-(UIView *)detailView {
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = [UIColor whiteColor];
    }
    return _detailView;
}

/// content view
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}


@end
