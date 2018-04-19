//
//  EMMainController.m
//  EMCalender
//
//  Created by tramp on 2018/4/19.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMMainController.h"
#import "EMCalenderController.h"
#import  <Masonry.h>

@interface EMMainController ()

@property(nonatomic,strong) UILabel * tipLabel;

@end

@implementation EMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-100.f);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.navigationController pushViewController:[[EMCalenderController alloc]init] animated:YES];
}

-(UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.font = [UIFont systemFontOfSize:84.f];
        _tipLabel.text = @"tap";
    }
    return _tipLabel;
}


@end
