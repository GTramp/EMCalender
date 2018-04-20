//
//  EMCalenderItem.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderItem.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "EMCalenderDay.h"
#import <EventKit/EventKit.h>

@interface EMCalenderItem ()

/// bottom border
@property(nonatomic,strong) UIView * bottomBorder;
/// right border
@property(nonatomic,strong) UIView * rightBorder;
/// number label
@property(nonatomic,strong) UILabel * numberLabel;
/// remimd label
@property(nonatomic,strong) UILabel * remindLabel;
/// date label
@property(nonatomic,strong) UILabel * dateLabel;
/// event label
@property(nonatomic,strong) UILabel * eventLabel;

@end

@implementation EMCalenderItem

// MARK: - 生命周期 -
-(instancetype)init {
    if (self = [super init]) {
        // 初始化Ui
        [self initUi];
    }
    return self;
}

// MARK: - 自定义方法 -

/// 更新事件
-(void)updateEvents:(NSArray<EKEvent *> *)events{
    if (events) {
        _eventLabel.hidden = NO;
        
        NSMutableAttributedString * mutAtt = [[NSMutableAttributedString alloc] init];
        for (EKEvent * event in events) {
            NSAttributedString * att = [[NSAttributedString alloc] initWithString:event.title
                                                                       attributes:@{NSBackgroundColorAttributeName: [UIColor colorWithCGColor:event.calendar.CGColor]}];
            [mutAtt appendAttributedString:att];
        }
        _eventLabel.attributedText = mutAtt;
        
    } else {
        _eventLabel.hidden = YES;
    }
}

// MARK: - setter -

-(void)setDay:(EMCalenderDay *)day {
    _day = day;
    
    // number label
    _numberLabel.text = [NSString stringWithFormat:@"%ld",day.day];
    // text color
    day.isInMonth ? (_numberLabel.backgroundColor = [UIColor colorWithHex:@"#FA8072"]) : (_numberLabel.backgroundColor = [UIColor colorWithHex:@"#C0C0C0"]);
    
    // date label
    _dateLabel.text = [NSString stringWithFormat:@"%ld-%02ld",day.year,day.month];
    
    // 更新事件
    [self updateEvents:day.events];
}

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    _bottomBorder.backgroundColor = borderColor;
}

-(void)setMarkType:(EMCalenderMarkType)markType {
    _markType = markType;
    
    if (markType == EMCalenderMarkTypeEvent) {
        
    } else if (markType == EMCalenderMarkTypeRemind) {
        _remindLabel.hidden = NO;
    } else {
        _remindLabel.hidden  = YES;
    }
}

// MARK: - 初始化 -

/// 初始化 Ui
-(void)initUi {
    // 背景色
    self.backgroundColor = [UIColor whiteColor];
    
    // bottom border
    [self addSubview:self.bottomBorder];
    [_bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1.f);
    }];
    
    // right border
    [self addSubview:self.rightBorder];
    [_rightBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(1.f);
    }];
    
    // number label
    [self addSubview:self.numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(24.f);
    }];
    
    // remind label
    [self addSubview:self.remindLabel];
    [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLabel.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(24.f);
    }];
    
    // date label
    [self addSubview:self.dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self);
    }];
    
    // event Label
    [self addSubview:self.eventLabel];
    [_eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.dateLabel.mas_top);
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

/// date label
-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor blueColor];
        _dateLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _dateLabel;
}

/// remind label
-(UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.backgroundColor = [UIColor cyanColor];
        _remindLabel.hidden = YES;
    }
    return _remindLabel;
}

/// number label
-(UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

/// right border
-(UIView *)rightBorder {
    if (!_rightBorder) {
        _rightBorder = [[UIView alloc] init];
        _rightBorder.backgroundColor = [UIColor greenColor];
    }
    return _rightBorder;
}

/// bottom border
-(UIView *)bottomBorder {
    if (!_bottomBorder) {
        _bottomBorder = [[UIView alloc] init];
        _bottomBorder.backgroundColor = [UIColor blueColor];
    }
    return _bottomBorder;
}

@end
