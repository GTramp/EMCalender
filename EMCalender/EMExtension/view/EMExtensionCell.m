//
//  EMExtensionCell.m
//  EMExtension
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMExtensionCell.h"
#import <Masonry.h>

@interface EMExtensionCell ()

/// icon image view
@property(nonatomic,strong) UIImageView * iconImageView;
/// event name
@property(nonatomic,strong) UILabel * nameLabel;
/// date range label
@property(nonatomic,strong) UILabel * dateRangeLabel;

@end

@implementation EMExtensionCell

// MARK: - 生命周期 -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // initialization
        [self initialization];
        
        // FIXME: - 测试 -
        _nameLabel.text = @"name Label";
        _dateRangeLabel.text = @"20180418 - 20190101";
    }
    return self;
}

// MARK: - 初始化 -
-(void)initialization {
    // icon ;
    [self.contentView addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(16.f);
        make.width.height.mas_equalTo(20.f);
    }];
    
    // name label;
    [self.contentView addSubview:self.nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(16.f);
        make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-2.f);
    }];
    
    // date range label
    [self.contentView addSubview:self.dateRangeLabel];
    [_dateRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.contentView.mas_centerY).offset(2.f);
    }];
}

// MARK: - 懒加载 -

-(UILabel *)dateRangeLabel {
    if (!_dateRangeLabel) {
        _dateRangeLabel = [[UILabel alloc] init];
        _dateRangeLabel.font = [UIFont systemFontOfSize:12.f];
        _dateRangeLabel.textColor = [UIColor darkTextColor];
    }
    return _dateRangeLabel;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _nameLabel;
}

-(UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"extension_floder"]];
    }
    return _iconImageView;
}

@end
