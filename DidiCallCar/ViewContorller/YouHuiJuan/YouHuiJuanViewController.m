//
//  YouHuiJuanViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "YouHuiJuanViewController.h"

@interface YouHuiJuanViewController ()

@end

@implementation YouHuiJuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
