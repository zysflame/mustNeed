//
//  YSStatusBarTool.m
//  Car
//
//  Created by MACOS01 on 2017/6/12.
//  Copyright © 2017年 MACOS01. All rights reserved.
//

#import "YSStatusBarTool.h"

@implementation YSStatusBarTool

+(NSString *)currentBatteryPercent{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    for (id info in infoArray)
    {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarBatteryPercentItemView")])
        {
            NSString *percentString = [info valueForKeyPath:@"percentString"];
            NSLog(@"电量��为：%@",percentString);
            return percentString;
        }
    }
    return @"";
}

+(NetWorkType )currentNetworkType{
    
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    NetWorkType type;
    for (id info in infoArray)
    {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[info valueForKeyPath:@"dataNetworkType"] integerValue];
            NSLog(@"----%lu", (unsigned long)type);
            
            return (NetWorkType)type;
        }
        
    }
    return NetWorkTypeNone;
}
+(NSString *)currentTimeString{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    for (id info in infoArray)
    {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarTimeItemView")])
        {
            NSString *timeString = [info valueForKeyPath:@"timeString"];
            NSLog(@"当前显示时间为：%@",timeString);
            return timeString;
        }
    }
    return @"";
}

+(NSString *)serviceCompany{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    for (id info in infoArray)
    {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")])
        {
            NSString *serviceString = [info valueForKeyPath:@"serviceString"];
            NSLog(@"公司为：%@",serviceString);
            return serviceString;
        }
    }
    return @"";
}

#pragma mark  > 获取WiFi信号强度 <
- (int )getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *dataNetworkItemView = nil;
    
    for (UIView * subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    
    NSLog(@"signal %d", signalStrength);
    return signalStrength;
}


@end
