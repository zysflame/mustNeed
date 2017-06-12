//
//  YStopView.h
//  Car
//
//  Created by MACOS02 on 2017/5/10.
//  Copyright © 2017年 MACOS01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YStopView : UIView

/** 下载按钮传值的block块*/
@property (nonatomic,copy) void (^blockDidClickTheTopView)();

/** 创建时的类方法*/
+ (instancetype)topView;

@end
