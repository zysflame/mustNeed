//
//  ViewController.m
//  StarSliderDemo
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "StarSliderView.h"

@interface ViewController ()<StarSLiderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  createStarSliderView];
}

#pragma mark - - 创建评论星星等级的滑杆
-(void)createStarSliderView{
    StarSliderView *star = [[StarSliderView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 400, self.view.frame.size.width/2, 100) andWithCurrentStarNum:1 andUserEnabled:YES andWithDistance:10];
    star.delegate = self;
    [self.view addSubview:star];
}

#pragma mark - - 代理方法
-(void)starSliderMoveWithCurrentNum:(int)starNum{
    NSLog(@"^^^^^^^^^%d^^^^^^^^^^^^^",starNum);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
