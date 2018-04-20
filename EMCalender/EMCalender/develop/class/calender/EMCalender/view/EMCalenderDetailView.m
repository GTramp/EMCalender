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
#import "EMCalenderDay.h"
#import "EMWeekDay.h"
#import <EventKit/EKEvent.h>
#import <EventKit/EKCalendar.h>


@interface EMCalenderDetailView ()

/// content view
@property(nonatomic,strong) UIView * contentView;
/// detail view
@property(nonatomic,strong) UIView * detailView;
/// contact button
@property(nonatomic,strong) UIButton * contactButton;

/// title label
@property(nonatomic,strong) UILabel * titleLabel;
/// add button
@property(nonatomic,strong) UIButton * addButton;
/// partLine
@property(nonatomic,strong) UIView * partLine;
/// event label
@property(nonatomic,strong) UILabel * eventLabel;

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

/// add button action handler
-(void)addButtonActionHandler:(UIButton *) sender {
    if ([_delegate respondsToSelector:@selector(detailView:addButtonActionHandler:)]) {
        [_delegate detailView:self addButtonActionHandler:sender];
    }
}

/// show in location
-(void)showInLocation:(CGPoint)location info:(id)information {
    // window
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
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
    
    // update data
    if ([information isKindOfClass:[EMCalenderDay class]]) {
        EMCalenderDay * info = (EMCalenderDay *)information;
        // title
        _titleLabel.text = [NSString stringWithFormat:@"%ld-%ld %@", info.month, info.day, info.weakDay.zh];
        
        // event
        if (info.events) {
            _eventLabel.hidden = NO;
            NSMutableAttributedString * mutAtt = [[NSMutableAttributedString alloc] init];
            for (EKEvent * event in info.events) {
                NSAttributedString * att = [[NSAttributedString alloc] initWithString:event.title
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor colorWithCGColor:event.calendar.CGColor]}];
                [mutAtt appendAttributedString:att];
            }
            _eventLabel.attributedText = mutAtt;
        } else {
            _eventLabel.hidden = YES;
        }
    }
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
    
    // partline
    [_contentView addSubview:self.partLine];
    [_partLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(64.f);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
    // title view
    [_contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.partLine);
    }];
    
    // add button
    [_contentView addSubview: self.addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).offset(-16.f);
    }];
    
    // event label
    [_contentView addSubview:self.eventLabel];
    [_eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.partLine.mas_bottom).offset(16.f);
        make.height.mas_equalTo(32.f);
    }];
}

// MARK: - 懒加载 -

/// event label
-(UILabel *)eventLabel {
    if (!_eventLabel) {
        _eventLabel = [[UILabel alloc] init];
        _eventLabel.hidden = YES;
    }
    return _eventLabel;
}

/// part line
-(UIView *)partLine {
    if (!_partLine) {
        _partLine = [[UIView alloc] init];
        _partLine.backgroundColor = [UIColor colorWithHex:@"#808080"];
    }
    return _partLine;
}

/// addbutton
-(UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_addButton addTarget:self action:@selector(addButtonActionHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

/// title label
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

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
