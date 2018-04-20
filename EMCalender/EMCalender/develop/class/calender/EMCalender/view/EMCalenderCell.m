//
//  EMCalenderCell.m
//  EMCalender
//
//  Created by tramp on 2018/4/17.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMCalenderCell.h"
#import "EMCalenderItem.h"
#import "EMIndexPath.h"
#import "EMCalenderMonth.h"

@interface EMCalenderCell ()

/// items
@property(nonatomic,strong) NSMutableArray<EMCalenderItem *> * calenderItems;

@end

@implementation EMCalenderCell
// MARK: - 生命周期 -

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //  初始化UI
        [self initUi];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 设置 frame
    [self initCalenderItemFrames:_calenderItems];
}

// MARK: - 自定义方法 -

// item in location
-(EMCalenderItem *)itemInLocation:(CGPoint)location {
    for (EMCalenderItem * item in _calenderItems) {
        if (CGRectContainsPoint(item.frame, location)) {
            return item;
        }
    }
    return nil;
}

/// 刷新数据
-(void)reloadData:(NSArray<EMCalenderDay *> *) calenderDays {
    for (NSInteger i = 0; i < calenderDays.count; i ++) {
        EMCalenderItem * item = _calenderItems[i];
        item.day = calenderDays[i];
    }
}

/// 设置 frame
-(void)initCalenderItemFrames:(NSArray <EMCalenderItem *> *) items {
    NSInteger row = 5;
    NSInteger column = 7;
    
    CGFloat item_w = self.frame.size.width / column;
    CGFloat item_h = self.frame.size.height / row;
    
    for (NSInteger i = 0; i < items.count; i ++) {
        CGFloat item_x = (i % column) * item_w;
        CGFloat item_y = (i / column) * item_h;
        EMCalenderItem * item = items[i];
        // frame
        item.frame = CGRectMake(item_x, item_y, item_w, item_h);
        // index path
        item.indexPath = [EMIndexPath indexPathWithRow:(i / column) column:(i % column)];
    }
}

/// 初始化 35宫格
-(void)initCalenderItems {
    // row / column
    NSInteger row = 5;
    NSInteger column = 7;
    // 初始化 calenderItems
    _calenderItems = [NSMutableArray arrayWithCapacity:row * column];
    
    for (NSInteger i= 0; i < row * column; i++) {
        EMCalenderItem * item = [[EMCalenderItem alloc] init];
        [self addSubview:item];
        [_calenderItems addObject:item];
    }
}

// MARK: - getter -
-(NSArray<EMCalenderItem *> *)items {
    return _calenderItems;
}

// MARK: - setter -

-(void)setMonth:(EMCalenderMonth *)month {
    _month = month;
    // 刷新数据
    [self reloadData:month.days];
}

// MARK: - 初始化 -

/// 初始化Ui
-(void)initUi {
    //  35 宫格
    [self initCalenderItems];
}

@end
