//
//  BaseViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//添加返回按钮
-(void)addBackItem
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img=[[UIImage imageNamed:@"YBS_navigationBarBackButton_lolbox-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    
    btn.frame=CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    //修改距离,距离边缘的 占位符按钮
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width=-15;
    
    //解决 这个回拉的问题;
    self.navigationItem.leftBarButtonItems=@[spaceItem,item];
}

- (void)setLeftItemsWithImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL )sel
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=100;
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIImage *img=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -15;
    self.navigationItem.leftBarButtonItems = @[item,[[UIBarButtonItem alloc]initWithCustomView:btn]];
}


- (void)setRightItemsWithFirstImageName:(NSString *)FirstImageName andFirstTarget:(id)FirstTarget andFirstSelector:(SEL )FirstSel andSecondImageName:(NSString *)SecondImageName andSecondTarget:(id)SecondTarget andSecondSelector:(SEL)SecondSel{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:FirstSel forControlEvents:UIControlEventTouchUpInside];
    UIImage *img1=[[UIImage imageNamed:FirstImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img1 forState:UIControlStateNormal];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 40, 40);
    [btn2 addTarget:self action:SecondSel forControlEvents:UIControlEventTouchUpInside];
    UIImage *img2=[[UIImage imageNamed:SecondImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn2 setImage:img2 forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -15;
    
    self.navigationItem.rightBarButtonItems = @[item,[[UIBarButtonItem alloc]initWithCustomView:btn2],[[UIBarButtonItem alloc]initWithCustomView:btn]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
