//
//  XingChengViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "XingChengViewController.h"

@interface XingChengViewController ()

@end

@implementation XingChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftItemsWithImageName:@"list_fanhui" andTarget:nil andSelector:@selector(backBtnClick)];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
