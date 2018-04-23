//
//  EMExtensionView.m
//  EMExtension
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import "EMExtensionView.h"
#import "EMExtensionCell.h"
#import "UIColor+Extension.h"
#import "EMExtensionHeader.h"
#import "UIView+Extension.h"

@interface EMExtensionView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EMExtensionView

// MARK: - 生命周期 -
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        // 初始化
        [self initialization];
    }
    return self;
}

// MARK: - UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EMExtensionHeader * header = (EMExtensionHeader *)[tableView headerViewForSection:indexPath.section];
    
    // open url
    NSString * openUrlString = nil;
    switch (header.type) {
        case EM_EXTENSION_HEADER_TYPE_SCHEDULE:
            openUrlString = @"calender://cn.com.sina.staff.tramp.canlender?open=create&type=schedule";
            break;
        case EM_EXTENSION_HEADER_TYPE_TASK:
            openUrlString = @"calender://cn.com.sina.staff.tramp.canlender?open=create&type=task";
            break;
        case EM_EXTENSION_HEADER_TYPE_MEMO:
            openUrlString = @"calender://cn.com.sina.staff.tramp.canlender?open=create&type=memo";
            break;
            
        default:
            break;
    }
    
    openUrlString = [openUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // url
    NSURL * openURL = [NSURL URLWithString:openUrlString];
    // open
    [[self currentVC].extensionContext openURL:openURL completionHandler:^(BOOL success) {
        success ? NSLog(@"success") : NSLog(@"failure");
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    EMExtensionHeader * sectionHeader = [[EMExtensionHeader alloc] init];
    
    if (section == 0) {
        sectionHeader.title = @"schedule";
        sectionHeader.type = EM_EXTENSION_HEADER_TYPE_SCHEDULE;
    } else if (section == 1) {
        sectionHeader.title = @"task";
        sectionHeader.type = EM_EXTENSION_HEADER_TYPE_TASK;
    } else {
        sectionHeader.title = @"memo";
        sectionHeader.type = EM_EXTENSION_HEADER_TYPE_MEMO;
    }
    
    return sectionHeader;
}

// MARK: - UITableViewDataSource -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMExtensionCell * cell = (EMExtensionCell *)[tableView dequeueReusableCellWithIdentifier:EM_EXTENSION_CELL_ID
                                                                                forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

// MARK: - 初始化 -

/// 初始化
-(void)initialization {
    // 预设
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[EMExtensionCell class] forCellReuseIdentifier:EM_EXTENSION_CELL_ID];
}

@end
