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
#import "EMExtensionView.h"

@interface EMExtensionController ()<NCWidgetProviding>

/// UITableView
@property(nonatomic,strong) EMExtensionView * extensionView;

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
    [self.view addSubview:self.extensionView];
    [_extensionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
-(EMExtensionView *)extensionView {
    if (!_extensionView) {
        _extensionView = [[EMExtensionView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _extensionView;
}



@end
