//
//  EMCalenderHeader.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderHeader.h"
#import <Masonry.h>

@interface EMCalenderHeader ()

/// title items
@property(nonatomic,strong) NSMutableArray<UIButton *> * titleItems;
/// bottom border
@property(nonatomic,strong) UIView * bottomBorder;

@end

@implementation EMCalenderHeader

// MARK: - 生命周期 -

-(instancetype)init {
    if (self = [super init]) {
        // 初始化Ui
        [self initUi];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 设置 title item frame
    [self initTitleItemFrames:_titleItems.copy];
}

// MARK: - setter -

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    _bottomBorder.backgroundColor = borderColor;
}

-(void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    // 初始化 titles
    [self initTitleItems:titles];
}


// MARK: - 自定义方法 -

/// 设置选中状态
-(void)selected:(BOOL)isSelected index:(NSInteger)index {
    UIButton * button = _titleItems[index];
    button.selected = isSelected;
}

/// 设置 item frame
-(void)initTitleItemFrames:(NSArray<UIButton *> *) items {
    
    NSInteger column = 7;
    
    CGFloat item_w = self.frame.size.width / column;
    CGFloat item_h = self.frame.size.height;
    CGFloat item_y = 0;
    
    for (NSInteger i = 0; i < items.count; i++) {
        CGFloat item_x = item_w * i;
        UIButton * button = items[i];
        button.frame = CGRectMake(item_x, item_y, item_w, item_h);
    }
}

/// 初始化 title Item
-(void)initTitleItems:(NSArray<NSString *>*)titles {
    
    if (_titleItems) {
        [_titleItems removeAllObjects];
    } else {
        _titleItems = [NSMutableArray arrayWithCapacity:titles.count];
    }
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self addSubview:button];
        [_titleItems addObject:button];
    }
}

// MARK: - 初始化 -

/// 初始化Ui
-(void)initUi {
    // 预设
    self.backgroundColor = [UIColor whiteColor];
    
    // bottom border
    [self addSubview:self.bottomBorder];
    [_bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1.f);
    }];
}

// MARK: - 懒加载 -
-(UIView *)bottomBorder {
    if (!_bottomBorder) {
        _bottomBorder = [[UIView alloc] init];
        _bottomBorder.backgroundColor = [UIColor blueColor];
    }
    return _bottomBorder;
}

@end
