//
//  UserInfoListViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "UserInfoListViewController.h"
#import "BaseNavigationViewController.h"
@interface UserInfoListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserInfoListViewController
{
    UIView *_userInfoView;
    NSArray *_infoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iv=[[UIImageView alloc]initWithFrame:self.view.frame];
    iv.image=[UIImage imageNamed:@"bg_da"];
    [self.view addSubview:iv];
    self.mainViewC=[[MainViewController alloc]init];
    
    
    
    BaseNavigationViewController *nc=[[BaseNavigationViewController alloc]initWithRootViewController:self.mainViewC];
    self.mainViewC.title=@"滴滴约车";
    
    
    [self addChildViewController:nc];
    [self.view addSubview:nc.view];
    
    [self setUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserInfoViewRightOrLeft:) name:@"007" object:nil];
}
-(void)UserInfoViewRightOrLeft:(NSNotification *)info
{
    if ([[info object] isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.4 animations:^{
            _userInfoView.center=CGPointMake(_userInfoView.center.x+_view_width*4/5.f, _userInfoView.center.y);
        }];
    } else{
        [UIView animateWithDuration:0.4 animations:^{
            _userInfoView.center=CGPointMake(_userInfoView.center.x-_view_width*4/5.f, _userInfoView.center.y);
        }];
    }
}

#pragma mark----设置用户 Info
-(void)setUI
{
    _userInfoView=[[UIView alloc]initWithFrame:CGRectMake(-_view_width*4/5.f, 0,_view_width*4/5.f, _view_height)];
    _userInfoView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_userInfoView];
    
    UITableView *userInfoTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(_userInfoView.bounds), CGRectGetHeight(_userInfoView.bounds)-95)];
    userInfoTable.backgroundColor=[UIColor clearColor];
    userInfoTable.delegate=self;
    userInfoTable.dataSource=self;
    userInfoTable.bounces=NO;
    userInfoTable.separatorColor=[UIColor clearColor];
    [_userInfoView addSubview:userInfoTable];
    
    UIButton *quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=CGRectMake(_view_width*2/5.f-50, _view_height-95+10, 100, 30);
    [quitBtn setImage:[UIImage imageNamed:@"ist_tuichu"] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_userInfoView addSubview:quitBtn];
    
    UILabel *numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, _view_height-45,CGRectGetWidth(_userInfoView.bounds), 25)];
    numberLabel.textColor=[UIColor whiteColor];
    numberLabel.text=@"400-000-0011";
    numberLabel.font=[UIFont systemFontOfSize:12];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [_userInfoView addSubview:numberLabel];
    
}

-(void)quitBtnClick:(UIButton *)sender
{
    NSLog(@"退出");
}


#pragma mark----tableView lifeCycle
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *headCell=[tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!headCell) {
            
            headCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell"];
            headCell.selectionStyle=UITableViewCellSelectionStyleNone;
            headCell.backgroundColor=[UIColor clearColor];
            UIImageView *userIcon=[[UIImageView alloc]initWithFrame:CGRectMake(_view_width*2/5.f-30, 20, 60, 60)];
            
            userIcon.image=[UIImage imageNamed:@"img_geren"];
            
            UILabel *phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 80,_view_width*4/5.f, 30)];
            phoneLabel.textAlignment=NSTextAlignmentCenter;
            phoneLabel.textColor=[UIColor colorWithRed:0.953 green:0.502 blue:0.094 alpha:1.000];
            phoneLabel.text=@"15942818446";
            phoneLabel.font=[UIFont boldSystemFontOfSize:20];
            [headCell.contentView addSubview:userIcon];
            [headCell.contentView addSubview:phoneLabel];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(5, 119, _view_width*4/5.f-5, 1)];
            lineView.backgroundColor=[UIColor colorWithWhite:1.000 alpha:0.500];
            [headCell.contentView addSubview:lineView];
        }
        return headCell;
    }
    NSArray *imageArr=@[@"ist_kuan",@"list_xingcheng",@"ist_quan",@"ist_shezhi",@"ist_gengxin",@"ist_bangzhu",@"ist_fenxiang"];
    _infoArr=@[@"预存款",@"历史行程",@"优惠劵",@"设置",@"更新",@"使用帮助",@"向朋友推荐"];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCell"];
        cell.backgroundColor=[UIColor clearColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 49, _view_width*4/5.f-10, 1)];
        lineView.backgroundColor=[UIColor colorWithWhite:1.000 alpha:0.500];
        [cell.contentView addSubview:lineView];
    }
    cell.imageView.image=[UIImage imageNamed:imageArr[indexPath.row-1]];
    cell.textLabel.text=_infoArr[indexPath.row-1];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark---Cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfo" object:_infoArr[indexPath.row-1] userInfo:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"007" object:nil];
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
