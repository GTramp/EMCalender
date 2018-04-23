//
//  EMExtensionHeader.h
//  EMExtension
//
//  Created by tramp on 2018/4/23.
//  Copyright © 2018年 tramp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EM_EXTENSION_HEADER_TYPE_SCHEDULE,
    EM_EXTENSION_HEADER_TYPE_TASK,
    EM_EXTENSION_HEADER_TYPE_MEMO,
} EM_EXTENSION_HEADER_TYPE;

@interface EMExtensionHeader : UIView

@property(nonatomic,strong) NSString * title;
@property(nonatomic,assign) EM_EXTENSION_HEADER_TYPE type;

@end
