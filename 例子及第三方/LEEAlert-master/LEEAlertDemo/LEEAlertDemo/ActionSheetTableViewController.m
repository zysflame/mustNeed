//
//  ActionSheetTableViewController.m
//  LEEAlertDemo
//
//  Created by 李响 on 2017/5/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "ActionSheetTableViewController.h"

#import "LEEAlert.h"

#import "ShareView.h"

#import "FontSizeView.h"

@interface ActionSheetTableViewController ()

@property (nonatomic , strong ) NSMutableArray *dataArray;

@end

@implementation ActionSheetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ActionSheet";
    
    self.dataArray = [NSMutableArray array];
    
    
    NSMutableArray *baseArray = [NSMutableArray array];
    
    NSMutableArray *demoArray = [NSMutableArray array];
    
    [self.dataArray addObject:baseArray];
    
    [self.dataArray addObject:demoArray];
    
    
    [baseArray addObject:@{@"title" : @"显示一个默认的 actionSheet 菜单" , @"content" : @""}];
    
    [baseArray addObject:@{@"title" : @"显示一个带取消按钮的 actionSheet 菜单" , @"content" : @""}];
    
    [baseArray addObject:@{@"title" : @"显示一个不同控件顺序的 actionSheet 菜单" , @"content" : @"设置的顺序决定了控件显示的顺序."}];
    
    [baseArray addObject:@{@"title" : @"显示一个带自定义视图的 actionSheet 菜单" , @"content" : @"自定义视图的size发生改变时 会自动适应其改变."}];
    
    [baseArray addObject:@{@"title" : @"显示一个横竖屏不同宽度的 actionSheet 菜单" , @"content" : @"最大高度与最大宽度设置方法一样"}];
    
    [baseArray addObject:@{@"title" : @"显示一个自定义标题和内容的 actionSheet 菜单" , @"content" : @"除了标题和内容 其他控件均支持自定义."}];
    
    [baseArray addObject:@{@"title" : @"显示一个多种action的 actionSheet 菜单" , @"content" : @"action分为三种类型 可添加多个 设置的顺序决定了显示的顺序."}];
    
    [baseArray addObject:@{@"title" : @"显示一个自定义action的 actionSheet 菜单" , @"content" : @"action的自定义属性可查看\"LEEAction\"类."}];
    
    [baseArray addObject:@{@"title" : @"显示一个可动态改变action的 actionSheet 菜单" , @"content" : @"已经显示后 可再次对action进行调整"}];
    
    [baseArray addObject:@{@"title" : @"显示一个可动态改变标题和内容的 actionSheet 菜单" , @"content" : @"已经显示后 可再次对其进行调整"}];
    
    [baseArray addObject:@{@"title" : @"显示一个模糊背景样式的 actionSheet 菜单" , @"content" : @"传入UIBlurEffectStyle枚举类型 默认为Dark"}];
    
    [baseArray addObject:@{@"title" : @"显示两个加入队列的 actionSheet 菜单" , @"content" : @"会根据显示队列中的先后顺序去显示 ,如果未加入队列 则不会再被显示"}];
    
    [demoArray addObject:@{@"title" : @"显示一个蓝色自定义风格的 actionSheet 菜单" , @"content" : @"菜单背景等颜色均可以自定义"}];
    
    [demoArray addObject:@{@"title" : @"显示一个类似微信布局的 actionSheet 菜单" , @"content" : @"只需要调整最大宽度,取消action的间隔颜色和底部间距即可"}];
    
    [demoArray addObject:@{@"title" : @"显示一个分享登录的 actionSheet 菜单" , @"content" : @"类似某些复杂内容的弹框 可以通过封装成自定义视图来显示"}];
    
    [demoArray addObject:@{@"title" : @"显示一个设置字体大小等级的 actionSheet 菜单" , @"content" : @"类似某些复杂内容的弹框 可以通过封装成自定义视图来显示"}];
}

#pragma mark - 自定义视图点击事件 (随机调整size)

- (void)viewTapAction:(UITapGestureRecognizer *)tap{
    
    CGFloat randomWidth = arc4random() % 240 + 10;
    
    CGFloat randomHeight = arc4random() % 400 + 10;
    
    CGRect viewFrame = tap.view.frame;
    
    viewFrame.size.width = randomWidth;
    
    viewFrame.size.height = randomHeight;
    
    tap.view.frame = viewFrame;
}

#pragma mark - 基础

- (void)base:(NSInteger)index{
    
    switch (index) {
            
        case 0:
        {
            [LEEAlert actionsheet].config
            .LeeTitle(@"标题")
            .LeeContent(@"内容")
            .LeeAction(@"好的", ^{
                
                // 点击事件Block
            })
            .LeeShow();
        }
            break;
            
        case 1:
        {
            [LEEAlert actionsheet].config
            .LeeTitle(@"标题")
            .LeeContent(@"内容")
            .LeeAction(@"确认", ^{
                
                // 点击事件Block
            })
            .LeeCancelAction(@"取消", ^{
                
                // 点击事件Block
            })
            .LeeShow();
        }
            break;
            
        case 2:
        {
            [LEEAlert actionsheet].config
            .LeeContent(@"内容")
            .LeeTitle(@"标题")
            .LeeAction(@"确认", ^{
                
                // 点击事件Block
            })
            .LeeCancelAction(@"取消", ^{
                
                // 点击事件Block
            })
            .LeeShow();
        }
            break;
            
        case 3:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 200, 100)];
            
            view.backgroundColor = [UIColor colorWithRed:43/255.0f green:133/255.0f blue:208/255.0f alpha:1.0f];
            
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)]];
            
            [LEEAlert actionsheet].config
            .LeeTitle(@"标题")
            .LeeContent(@"内容")
//            .LeeCustomView(view)
            .LeeAddCustomView(^(LEECustomView *custom) {
                
                custom.view = view;
                
//                custom.isAutoWidth = YES; // 设置自动宽度后 会根据insets和最大的宽度自动计算自定义视图的宽度 并修改其frame属性
            })
            .LeeAction(@"确认", ^{
                
            })
            .LeeCancelAction(@"取消", ^{
                
            })
            .LeeShow();
        }
            break;
            
        case 4:
        {
            [LEEAlert actionsheet].config
            .LeeContent(@"内容")
            .LeeTitle(@"标题")
            .LeeAction(@"确认", nil)
            .LeeCancelAction(@"取消", nil)
            //.LeeMaxWidth(280) // LeeMaxWidth设置的最大宽度为固定数值 横屏竖屏都会采用这个宽度 (高度同理)
            .LeeConfigMaxWidth(^CGFloat (LEEScreenOrientationType type) { // LeeConfigMaxWidth可以单独对横屏竖屏情况进行设置
                
                switch (type) {
                        
                    case LEEScreenOrientationTypeHorizontal:
                        
                        // 横屏时最大宽度
                        
                        return CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.7f;
                        
                        break;
                        
                    case LEEScreenOrientationTypeVertical:
                        
                        // 竖屏时最大宽度
                        
                        return CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.9f;
                        
                        break;
                        
                    default:
                        return 0.0f;
                        break;
                }
            })
            .LeeShow();
        }
            break;
            
        case 5:
        {
            [LEEAlert actionsheet].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"已经退出该群组";
                
                label.textColor = [UIColor darkGrayColor];
                
                label.textAlignment = NSTextAlignmentLeft;
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"以后将不会再收到该群组的任何消息";
                
                label.textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
                
                label.textAlignment = NSTextAlignmentLeft;
            })
            .LeeAction(@"好的", nil)
            .LeeShow();
        }
            break;
            
        case 6:
        {
            [LEEAlert actionsheet].config
            .LeeTitle(@"这是一个actionSheet 它有三个不同类型的action!")
            .LeeAction(@"一个默认action", ^{
                
                // 点击事件Block
            })
            .LeeDestructiveAction(@"一个销毁action", ^{
                
                // 点击事件Block
            })
            .LeeCancelAction(@"一个取消action", ^{
                
                // 点击事件Block
            })
            .LeeShow();
        }
            break;
            
        case 7:
        {
            [LEEAlert actionsheet].config
            .LeeTitle(@"自定义 Action 的 actionSheet!")
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"自定义";
                
                action.titleColor = [UIColor brownColor];
                
                action.highlight = @"被点啦";
                
                action.highlightColor = [UIColor orangeColor];
                
                action.image = [UIImage imageNamed:@"smile"];
                
                action.highlightImage = [UIImage imageNamed:@"tongue"];
                
                action.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
                
                action.height = 60.0f;
                
                action.clickBlock = ^{
                    
                    // 点击事件Block
                };
                
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeCancel;
                
                action.title = @"自定义";
                
                action.titleColor = [UIColor orangeColor];
                
                action.highlightColor = [UIColor brownColor];
                
                action.image = [UIImage imageNamed:@"smile"];
                
                action.highlightImage = [UIImage imageNamed:@"tongue"];
                
                action.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
                
                action.height = 60.0f;
                
                action.clickBlock = ^{
                    
                    // 点击事件Block
                };
                
            })
            .LeeShow();
        }
            break;
            
        case 8:
        {
            __block LEEAction *tempAction = nil;
            
            [LEEAlert actionsheet].config
            .LeeContent(@"点击改变 第一个action会长高哦")
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"我是action";
                
                tempAction = action;
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"改变";
                
                action.isClickNotClose = YES; // 设置点击不关闭 (仅适用于默认类型的action)
                
                action.clickBlock = ^{
                    
                    tempAction.height += 40;
                    
                    tempAction.title = @"我长高了";
                    
                    tempAction.titleColor = [UIColor redColor];
                    
                    [tempAction update]; // 更改设置后 调用更新
                };
            })
            .LeeCancelAction(@"取消", nil)
            .LeeShow();
        }
            break;
            
        case 9:
        {
            __block UILabel *tempTitle = nil;
            __block UILabel *tempContent = nil;
            
            [LEEAlert actionsheet].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"动态改变标题和内容的actionSheet";
                
                tempTitle = label;
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"点击调整 action 即可改变";
                
                tempContent = label;
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"调整";
                
                action.isClickNotClose = YES; // 设置点击不关闭 (仅适用于默认类型的action)
                
                action.clickBlock = ^{
                    
                    tempTitle.text = @"一个改变后的标题 ...................................................................";
                    
                    tempTitle.textColor = [UIColor grayColor];
                    
                    tempTitle.textAlignment = NSTextAlignmentLeft;
                    
                    tempContent.text = @"一个改变后的内容";
                    
                    tempContent.textColor = [UIColor lightGrayColor];
                    
                    tempContent.textAlignment = NSTextAlignmentLeft;
                    
                    // 其他控件同理 ,
                };
                
            })
            .LeeCancelAction(@"取消" , nil)
            .LeeShow();
        }
            break;
            
        case 10:
        {
            [LEEAlert actionsheet].config
            .LeeTitle(@"这是一个毛玻璃背景样式的actionSheet")
            .LeeContent(@"通过UIBlurEffectStyle枚举设置效果样式")
            .LeeAction(@"确认", nil)
            .LeeCancelAction(@"取消", nil)
            .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
            .LeeShow();
        }
            break;
            
        case 11:
        {
            // 第一个显示时 第二个也显示了 这时会隐藏第一个 ,在第二个显示结束后再将第一个显示出来
            
            [LEEAlert actionsheet].config
            .LeeTitle(@"actionSheet 1")
            .LeeCancelAction(@"取消", nil)
            .LeeAction(@"确认", nil)
            .LeeAddQueue()
            .LeeShow();
            
            
            [LEEAlert actionsheet].config
            .LeeTitle(@"actionSheet 2")
            .LeeCancelAction(@"取消", nil)
            .LeeAction(@"确认", nil)
            .LeeAddQueue()
            .LeeShow();
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - demo

- (void)demo:(NSInteger)index{
    
    switch (index) {
            
        case 0:
        {
            UIColor *blueColor = [UIColor colorWithRed:90/255.0f green:154/255.0f blue:239/255.0f alpha:1.0f];
            
            [LEEAlert actionsheet].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"确认删除?";
                
                label.textColor = [UIColor whiteColor];
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"删除后将无法恢复, 请慎重考虑";
                
                label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeCancel;
                
                action.title = @"取消";
                
                action.titleColor = blueColor;
                
                action.backgroundColor = [UIColor whiteColor];
                
                action.clickBlock = ^{
                    
                    // 取消点击事件Block
                };
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"删除";
                
                action.titleColor = blueColor;
                
                action.backgroundColor = [UIColor whiteColor];
                
                action.clickBlock = ^{
                    
                    // 删除点击事件Block
                };
            })
            .LeeHeaderColor(blueColor)
            .LeeShow();
        }
            break;
            
        case 1:
        {
            [LEEAlert actionsheet].config
            .LeeContent(@"退出后不会通知群聊中其他成员, 且不会接收此群聊消息.出后不会通知群聊中其他成员, 且不会接收此群聊消息")
            .LeeDestructiveAction(@"确定", ^{
                
                // 点击事件回调Block
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeCancel;
                
                action.title = @"取消";
                
                action.titleColor = [UIColor blackColor];
                
                action.font = [UIFont systemFontOfSize:18.0f];
            })
            .LeeActionSheetCancelActionSpaceColor([UIColor colorWithWhite:0.92 alpha:1.0f]) // 设置取消按钮间隔的颜色
            .LeeActionSheetBottomMargin(0.0f) // 设置底部距离屏幕的边距为0
            .LeeCornerRadius(0.0f) // 设置圆角曲率为0
            .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                
                // 这是最大宽度为屏幕宽度 (横屏和竖屏)
                
                return CGRectGetWidth([[UIScreen mainScreen] bounds]);
            })
            .LeeShow();
        }
            break;
            
        case 2:
        {
            // 初始化分享视图
            
            CGFloat width = CGRectGetHeight([[UIScreen mainScreen] bounds]) > CGRectGetWidth([[UIScreen mainScreen] bounds]) ? CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20 : CGRectGetHeight([[UIScreen mainScreen] bounds]) - 20;
            
            ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, width, 0) InfoArray:nil MaxLineNumber:2 MaxSingleCount:3];
            
            shareView.OpenShareBlock = ^(ShareType type){
                
                // 关闭
                
                [LEEAlert closeWithCompletionBlock:^{
                    
                    NSLog(@"%d" , type);
                }];
                
            };
            
            [LEEAlert actionsheet].config
            .LeeAddCustomView(^(LEECustomView *custom) {
                
                custom.view = shareView;
                
                custom.positionType = LEECustomViewPositionTypeCenter;
            })
            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"取消";
                
                action.titleColor = [UIColor grayColor];
            })
            .LeeShow();
        }
            break;
            
        case 3:
        {   
            FontSizeView *view = [[FontSizeView alloc] init];
            
            view.changeBlock = ^(NSInteger level){
              
                
            };
            
            [LEEAlert actionsheet].config
            .LeeAddCustomView(^(LEECustomView *custom) {
                
                custom.view = view;
                
                custom.isAutoWidth = YES;
            })
            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"取消";
                
                action.titleColor = [UIColor grayColor];
            })
            .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeActionSheetBottomMargin(0.0f)
            .LeeCornerRadius(0.0f)
            .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                
                // 这是最大宽度为屏幕宽度 (横屏和竖屏)
                
                return type == LEEScreenOrientationTypeHorizontal ? CGRectGetHeight([[UIScreen mainScreen] bounds]) : CGRectGetWidth([[UIScreen mainScreen] bounds]);
            })
            .LeeShow();
        }
            break;
            
        case 4:
        {
            
        }
            break;
            
        case 5:
        {
            
        }
            break;
            
        case 6:
        {
            
        }
            break;
            
        case 7:
        {
            
        }
            break;
            
        case 8:
        {
            
        }
            break;
            
        case 9:
        {
            
        }
            break;
            
        case 10:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary *info = self.dataArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = info[@"title"];
    
    cell.detailTextLabel.text = info[@"content"];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return @"基础";
            
            break;
            
        case 1:
            
            return @"Demo";
            
            break;
            
        default:
            
            return @"";
            
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.section) {
            
        case 0:
            
            [self base:indexPath.row];
            
            break;
            
        case 1:
            
            [self demo:indexPath.row];
            
            break;
            
        default:
            break;
    }
    
}

@end
