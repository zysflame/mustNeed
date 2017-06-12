//
//  YStopView.m
//  Car
//
//  Created by MACOS02 on 2017/5/10.
//  Copyright © 2017年 MACOS01. All rights reserved.
//

#import "YStopView.h"

@implementation YStopView

+ (instancetype)topView{
    YStopView *topView = [[NSBundle mainBundle] loadNibNamed:@"YStopView" owner:nil options:nil].firstObject;
    return topView;
}

#pragma mark  > 点击了回到顶部的按钮 <
- (IBAction)clickTheTopBtn:(UIButton *)button {
    if (self.blockDidClickTheTopView) {
        self.blockDidClickTheTopView();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
