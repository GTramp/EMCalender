//
//  EMExtensionHeader.m
//  EMExtension
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMExtensionHeader.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@interface EMExtensionHeader ()

/// title label
@property(nonatomic,strong) UILabel * titleLabel;
/// add button
@property(nonatomic,strong) UIButton * addButton;
/// bottom line
@property(nonatomic,strong) UIView * bottomline;

@end

@implementation EMExtensionHeader

// MARK: - 生命周期 -
-(instancetype)init {
    if (self = [super init]) {
        // 初始化
        [self initialization];
    }
    return self;
}

// MARK: - setter -


-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

// MARK: - 初始化 -
-(void)initialization {
    
    // title label
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(16.f);
    }];
    
    // add button
    [self addSubview:self.addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self).offset(-16.f);
    }];
    
    // bottom line
    [self addSubview:self.bottomline];
    [_bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
}

// MARK: - 懒加载 -

/// bottom line
-(UIView *)bottomline {
    if (!_bottomline) {
        _bottomline = [[UIView alloc] init];
        _bottomline.backgroundColor = [UIColor colorWithHex:@"#A9A9A9"];
    }
    return _bottomline;
}

/// add button
-(UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    return _addButton;
}

/// title label
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

@end
