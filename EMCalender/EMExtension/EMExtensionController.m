//
//  EMExtensionController.m
//  EMExtension
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMExtensionController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Masonry.h>
#import "UIColor+Extension.h"

@interface EMExtensionController ()<NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>

/// UITableView
@property(nonatomic,strong) UITableView * tableView;

@end

@implementation EMExtensionController

// MARK: - 生命周期 -
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 初始化
    [self initialization];
    // 2. initUi
    [self initUi];
}

// MARK: - 初始化 -

/// initUi
-(void)initUi {
    // 预设
    self.view.backgroundColor = [UIColor colorWithHex:@"#FFFFFF" alpha:0.5];
    
    // table view
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

/// 初始化
-(void)initialization {
    // 预设
    //    widgetLargestAvailableDisplayMode
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    } else {
        // Fallback on earlier versions
        self.preferredContentSize = CGSizeMake(0, 400.f);
    }
    
}


// MARK: - UITableViewDelegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL * url = [NSURL URLWithString:@"calender://cn.com.sina.staff.tramp.calender"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
}


// MARK: - UITableViewDataSource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}


// MARK: - NCWidgetProviding -

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

-(void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    // new data
    completionHandler(NCUpdateResultNewData);
}

-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = maxSize;
    } else {
        self.preferredContentSize = CGSizeMake(maxSize.width, 400.f);
    }
}


// MARK: - 懒加载 -

/// table view
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
