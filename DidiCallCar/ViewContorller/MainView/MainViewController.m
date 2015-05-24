//
//  MainViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "MainViewController.h"

#import "MainViewController.h"


#import <AMapSearchKit/AMapSearchAPI.h>

#import "YouHuiJuanViewController.h"
#import "XingChengViewController.h"
#import "CallCarViewController.h"
#import "LoginViewController.h"
#import "ChooseCarViewController.h"
#import "LocationModel.h"

#import "NetRequest.h"


@interface MainViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CallCarViewControllerDelegate>
typedef void(^CellBlock)(NSString *title);

@property (nonatomic,strong) CellBlock cellBlock0;
@property (nonatomic,strong) CellBlock cellBlock4;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pinView;

@property (weak, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

@property (weak, nonatomic) IBOutlet UIView *selectBgView;

@property (weak, nonatomic) IBOutlet UIButton *tureUseBtn;

@property (weak, nonatomic) IBOutlet UIView *tableViewBgView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIDatePicker *yueDatePicker;

@property (weak, nonatomic) IBOutlet UIView *yueDatePickerBgView;

@property (weak, nonatomic) IBOutlet UILabel *yueOrJuanTitleLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *juanPiker;

@end

@implementation MainViewController
{
    UIImageView *_mengScreen;
    UITapGestureRecognizer *_tapGR;
    NSArray *_infoArr;
    UINavigationItem *_item;
    
    int _infoBtnSign;
    int _callCarSign;
    int _yuYueSign;
    int _useOrOrderSign;
    
    NSArray *_callCarPicArr;
    NSMutableArray *_callCarTitleArr;
    //地图
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocationCoordinate2D _movelocation;
    
    LocationModel *_fromLocation;
    LocationModel *_toLocation;
    
    
    NSTimeInterval _yongCheTime;
    NSString *_beginPlace;
    NSString *_aimPlace;
    NSString *_carKind;
    NSString *_quan;
    
    NSMutableArray *_detailArr;
    
    NSMutableArray *_juanArr;
    
    int _cellNum;
    int _pickViewNum;
    
    QuanParse *_quanParse;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    _fromLocation=[LocationModel new];
    _toLocation=[LocationModel new];
    
    _juanArr=[NSMutableArray new];
    _detailArr=[NSMutableArray new];
    _infoBtnSign=1;
    _callCarSign=1;
    _yuYueSign=1;
    _detailArr.array=@[@"",@"",@"",@"",@""];
    _infoArr=@[@"预存款",@"历史行程",@"优惠劵",@"设置",@"更新",@"使用帮助",@"向朋友推荐"];
    [MAMapServices sharedServices].apiKey = @"10730433006ecc9843775eda6ebb110e";
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"10730433006ecc9843775eda6ebb110e" Delegate:self];
    
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64)];
    [_mapView setZoomLevel:16.1 animated:YES];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    
    
    
    [self.view addSubview:_mapView];
    [self.view sendSubviewToBack:_mapView];
    _tureUseBtn.hidden=YES;
    _tableViewBgView.hidden=YES;
    
    
    
    [self setLeftItemsWithImageName:@"img_wode" andTarget:nil andSelector:@selector(userItemClick:)];
    
    [self setRightItemsWithFirstImageName:@"quan" andFirstTarget:nil andFirstSelector:@selector(youhuijuanClick:) andSecondImageName:@"lishijilu" andSecondTarget:nil andSecondSelector:@selector(lishijiluClick:)];
    
    [self setUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userItemClick:) name:@"King" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoClick:) name:@"UserInfo" object:nil];
}


#pragma mark---CallCarView 的代理方法
-(void)exchangeFromLocation:(AMapPOI *)poi
{
    
    _fromLocation.locationName=poi.name;
    _fromLocation.latitude=poi.location.latitude;
    _fromLocation.longitude=poi.location.longitude;
    [_callCarTitleArr replaceObjectAtIndex:1 withObject:_fromLocation.locationName];
    [self.myTableView reloadData];
    NSLog(@"起始位置更新确定,%@",poi.name);
    
}

-(void)exchangeToLocation:(AMapPOI *)poi
{
    _toLocation.locationName=poi.name;
    _toLocation.latitude=poi.location.latitude;
    _toLocation.longitude=poi.location.longitude;
    [_callCarTitleArr replaceObjectAtIndex:2 withObject:_toLocation.locationName];
    [self.myTableView reloadData];
    NSLog(@"终点位置更新确定%@",poi.name);
    
    
}
-(void)exchangeNowMapLocation:(AMapPOI *)poi
{
    _mapView.centerCoordinate= CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
}



-(void)setLeftItemsWithImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=100;
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIImage *img=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -15;
    self.myNavigationBar.topItem.leftBarButtonItems = @[item,[[UIBarButtonItem alloc]initWithCustomView:btn]];
}

-(void)setRightItemsWithFirstImageName:(NSString *)FirstImageName andFirstTarget:(id)FirstTarget andFirstSelector:(SEL)FirstSel andSecondImageName:(NSString *)SecondImageName andSecondTarget:(id)SecondTarget andSecondSelector:(SEL)SecondSel
{
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
    
    self.myNavigationBar.topItem.rightBarButtonItems = @[item,[[UIBarButtonItem alloc]initWithCustomView:btn2],[[UIBarButtonItem alloc]initWithCustomView:btn]];
}


#pragma mark----约车和现在用车
- (IBAction)callCarClick:(UIButton *)sender {
    
    
    [NetRequest getQuanSuccess:^(QuanParse *parse) {
        _quanParse=parse;
        NSLog(@"下载成功!");
        [_juanArr removeAllObjects];
        [_juanArr addObject:@"不使用优惠卷"];
        
        for (QuanInfo *info in _quanParse.data) {
            [_juanArr addObject:info.coupon_discount_amount];
            NSLog(@"%@---%ld",info.coupon_discount_amount,_juanArr.count);
        }
        [_juanPiker reloadAllComponents];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
    } withUrl:@"errorMessage"];
    
    if (sender.tag==20) {
        _useOrOrderSign=0;
        [_callCarTitleArr replaceObjectAtIndex:0 withObject:@"现在时间"];
        [_myTableView  reloadData];
        if (_callCarSign) {
            _tureUseBtn.hidden=NO;
            _tableViewBgView.hidden=NO;
            _item=[[UINavigationItem alloc]initWithTitle:@"确认信息"];
            
            [self.myNavigationBar pushNavigationItem:_item animated:YES];
            
            [self setMyitemLeftItemsWithImageName:@"list_fanhui" andTarget:nil andSelector:@selector(myItemBackClick)];
            _selectBgView.hidden=YES;
            _callCarSign=0;
        }else{
            
        }
    }else if (sender.tag==21)
    {
        _useOrOrderSign=1;
        
        if (_yuYueSign) {
            _tureUseBtn.hidden=NO;
            _tableViewBgView.hidden=NO;
            _item=[[UINavigationItem alloc]initWithTitle:@"确认信息"];
            
            [self.myNavigationBar pushNavigationItem:_item animated:YES];
            
            [self setMyitemLeftItemsWithImageName:@"list_fanhui" andTarget:nil andSelector:@selector(myItemBackClick)];
            _selectBgView.hidden=YES;
            _yuYueSign=0;
        }else{
            
        }
    }
    [_callCarTitleArr replaceObjectAtIndex:1 withObject:_selectBtn.titleLabel.text];
    [_myTableView reloadData];
}
#pragma mark----约车返回事件

#pragma mark-----自定义 Bar 返回事件
-(void)myItemBackClick
{
    
    
    [self.myNavigationBar popNavigationItemAnimated:YES];
    _yueDatePickerBgView.hidden=YES;
    
    _tureUseBtn.hidden=YES;
    _selectBgView.hidden=NO;
    _tableViewBgView.hidden=YES;
    _callCarSign=1;
    _yuYueSign=1;
}
-(void)setMyitemLeftItemsWithImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=100;
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIImage *img=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -15;
    self.myNavigationBar.topItem.leftBarButtonItems = @[item,[[UIBarButtonItem alloc]initWithCustomView:btn]];
}



#pragma mark---用户列表响应事件
-(void)userInfoClick:(NSNotification *)info
{
    [self userItemClick:nil];
    int num;
    for (int i=0; i<_infoArr.count; i++) {
        if ([[info object] isEqualToString:_infoArr[i]]) {
            num=i;
            break;
        }
    }
    switch (num) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            XingChengViewController *xingCheng=[[XingChengViewController alloc]init];
            xingCheng.title=@"行程管理";
            [self.navigationController pushViewController:xingCheng animated:YES];
        }
            break;
        case 2:
        {
            YouHuiJuanViewController *youHuiVC=[[YouHuiJuanViewController alloc]init];
            youHuiVC.title=@"优惠劵";
            [self.navigationController pushViewController:youHuiVC animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark---获取当前位置坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
        AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
        regeoRequest.searchType = AMapSearchType_ReGeocode;
        regeoRequest.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude ];
        regeoRequest.radius = 1000;
        regeoRequest.requireExtension = YES;
        
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeoRequest];
        
        
    }
    _mapView.showsUserLocation = NO;
    
}


-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame=_pinView.frame;
        frame.origin.y-=10;
        _pinView.frame=frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=_pinView.frame;
            frame.origin.y+=10;
            _pinView.frame=frame;
        }];
    }];
    
    
    [_selectBtn setTitle:@"正在获取地址" forState:UIControlStateNormal];
    
    _movelocation=CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
    
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude ];
    
    regeoRequest.radius = 1000;
    regeoRequest.requireExtension = YES;
    
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeoRequest];
    
    NSLog(@"regionDidChangeAnimated%f   %f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
}
#pragma mark----坐标逆编码
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        //辽宁省大连市甘井子区凌水街道五一路269号, addressComponent: {province: 辽宁省, city: 大连市, district: 甘井子区, township: 凌水街道, neighborhood: , building: , citycode: 0411, adcode: 210211, streetNumber: {street: 五一路, number: 269号, location: {38.888031, 121.533203}, distance: 5, direction: 北}},
        //        NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@%@", response.regeocode.addressComponent.province,response.regeocode.addressComponent.city,response.regeocode.addressComponent.district,response.regeocode.addressComponent.township,response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
//        NSString *addressTitle=[NSString stringWithFormat:@"%@%@%@", response.regeocode.addressComponent.province,response.regeocode.addressComponent.city,response.regeocode.addressComponent.district];
        NSString *addressSubTitle=[NSString stringWithFormat:@"%@%@%@",response.regeocode.addressComponent.township,response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        NSLog(@"%@",addressSubTitle);
        [_selectBtn setTitle:addressSubTitle forState:UIControlStateNormal];
        _beginPlace=addressSubTitle;
    }
}



- (IBAction)SelectBtnClick:(UIButton *)sender {
    CallCarViewController *weiZhiSelectVC=[[CallCarViewController alloc]init];
    weiZhiSelectVC.delegate=self;
    weiZhiSelectVC.title=@"请输入出发地";
    weiZhiSelectVC.fromOrTo=2;
    weiZhiSelectVC.searchname=_beginPlace;
    [self.navigationController pushViewController:weiZhiSelectVC animated:YES];
}

-(void)userItemClick:(UIButton *)sender
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        LoginViewController *loginViewC=[[LoginViewController alloc]init];
        
        [self presentViewController:loginViewC animated:YES completion:nil];
        return;
    }
    NSString *sign=[NSString stringWithFormat:@"%d",_infoBtnSign];
    if (_infoBtnSign) {
        _mengScreen.hidden=NO;
        [UIView animateWithDuration:0.4 animations:^{
            //            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
            //
            //            CGAffineTransform centerScale = CGAffineTransformMakeScale(0.7 , 0.7);
            //            self.navigationController.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
            ////            self.midTBC.view.frame = CGRectMake(240, (ScreenHeight*0.15), ScreenWidth*0.7, ScreenHeight*0.7);
            self.navigationController.view.frame=CGRectMake(_view_width*4/5.f,0, _view_width, _view_height);
        }];
        _infoBtnSign=0;
    }else{
        _mengScreen.hidden=YES;
        [UIView animateWithDuration:0.4 animations:^{
            //            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
            //            CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
            //            self.navigationController.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
            //            self.midTBC.view.frame = CGRectMake(240, (ScreenHeight*0.15), ScreenWidth*0.7, ScreenHeight*0.7);
            self.navigationController.view.frame=CGRectMake(0, 0, _view_width, _view_height);
            
        }];
        _infoBtnSign=1;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"007" object:sign userInfo:nil];
    NSLog(@"用户信息");
}
-(void)youhuijuanClick:(UIButton *)sender
{
    NSLog(@"优惠劵");
    YouHuiJuanViewController *youHuiVC=[[YouHuiJuanViewController alloc]init];
    youHuiVC.title=@"优惠劵";
    [self.navigationController pushViewController:youHuiVC animated:YES];
}
-(void)lishijiluClick:(UIButton *)sender
{
    NSLog(@"历史记录");
    XingChengViewController *xingCheng=[[XingChengViewController alloc]init];
    xingCheng.title=@"行程管理";
    [self.navigationController pushViewController:xingCheng animated:YES];
}

#pragma mark----设置蒙板和用户 Info
-(void)setUI
{
    _yueDatePickerBgView.hidden=YES;
    _juanPiker.delegate=self;
    _juanPiker.dataSource=self;
    _juanPiker.backgroundColor=[UIColor whiteColor];
    _yueDatePicker.backgroundColor=[UIColor whiteColor];
    _yueDatePicker.alpha=1;
    
    _myTableView.backgroundColor=[UIColor clearColor];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorColor=[UIColor clearColor];
    _myTableView.bounces=NO;
    
    _mengScreen=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _view_width, _view_height+64)];
    _mengScreen.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.300];
    _tapGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];
    [_mengScreen addGestureRecognizer:(_tapGR)];
    _mengScreen.userInteractionEnabled=YES;
    _mengScreen.hidden=YES;
    
    [self.view addSubview:_mengScreen];
    
    
    _callCarPicArr=@[@"shijian",@"shi",@"zhong",@"chexing",@"youhui"];
    _callCarTitleArr=[NSMutableArray new];
    _callCarTitleArr.array=@[@"选择用车时间",@"出发地点",@"目的地点",@"智选型",@"优惠劵"];
    
    
}

#pragma mark----用车时间Picker View lifeCycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _juanArr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return _juanArr[row];
    }
    return [NSString stringWithFormat:@"%@元优惠",_juanArr[row]];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _pickViewNum=(int)row;
    NSLog(@"选择的第几行%ld",row);
}

#pragma mark=====DatePickerView
-(NSDate *)dateWithStr:(NSString *)str
{
    //利用时间戳将字符串转换成时间
    NSDateFormatter *datefm=[[NSDateFormatter alloc]init];
    datefm.dateFormat=@"a hh:mm";
    NSDate *date=[datefm dateFromString:str];
    
    return date;
    
}
-(NSString *)StrWithDate:(NSDate *)date
{//利用时间戳将时间转换成字符串
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    
    dateFormater.dateFormat = @"yyyy年MM月dd日 HH:mm";
    
    NSString *dateStr=[dateFormater stringFromDate:date];
    return dateStr;
}
//- (CGSize)rowSizeForComponent:(NSInteger)component
//{
//    return CGSizeMake(_view_width, 30);
//}
//- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSLog(@"viewForRow:(NSInteger)row forComponent");
//    NSArray *arr=@[@"不使用优惠劵",@"使用30元优惠劵"];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view_width, 30)];
//    label.text=arr[row];
//    label.textAlignment=NSTextAlignmentCenter;
//    return label;
//}

#pragma mark----myTableView--lifeCycle
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"callCarCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"callCarCell"];
        cell.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.500];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 43,CGRectGetWidth(cell.contentView.frame), 1)];
        view.backgroundColor=[UIColor colorWithWhite:0.818 alpha:1.000];
        [cell.contentView addSubview:view];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame)-130, 4, 90, 36)];
        label.tag=30+indexPath.row;
        label.textColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:label];
    }
    UILabel *label=(UILabel *)[cell.contentView viewWithTag:30+indexPath.row];
    label.text=_detailArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.500];
    [cell.imageView setImage:[UIImage imageNamed:_callCarPicArr[indexPath.row]]];
    cell.textLabel.text=_callCarTitleArr[indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    _cellNum=(int)indexPath.row;
    if (indexPath.row==0) {
        
        if (_useOrOrderSign==1) {
            _yueDatePickerBgView.hidden=NO;
            [_yueDatePickerBgView bringSubviewToFront:_yueDatePicker];
            cell.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.700];
        }else{
            
        }
    }else{
        cell.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.700];
        if (indexPath.row==1) {
            _yueDatePickerBgView.hidden=YES;
            CallCarViewController *weiZhiSelectVC=[[CallCarViewController alloc]init];
            weiZhiSelectVC.delegate=self;
            weiZhiSelectVC.searchname=_beginPlace;
            weiZhiSelectVC.fromOrTo=1;
            
            weiZhiSelectVC.title=@"请输入出发地";
            [self.navigationController pushViewController:weiZhiSelectVC animated:YES];
        }
        if (indexPath.row==2) {
            _yueDatePickerBgView.hidden=YES;
            CallCarViewController *weiZhiSelectVC=[[CallCarViewController alloc]init];
            weiZhiSelectVC.delegate=self;
            weiZhiSelectVC.fromOrTo=0;
            weiZhiSelectVC.title=@"请输入目的地";
            [self.navigationController pushViewController:weiZhiSelectVC animated:YES];
        }
        if (indexPath.row==3) {
            ChooseCarViewController *chooseCarVC=[[ChooseCarViewController alloc]init];
            chooseCarVC.title=@"车型选择";
            chooseCarVC.carBlock=^(NSString *carKind,NSInteger price){
                [_callCarTitleArr replaceObjectAtIndex:3 withObject:carKind];
                
                
                _carKind=carKind;
                [_myTableView  reloadData];
            };
            
            [self.navigationController pushViewController:chooseCarVC animated:YES];
        }
        if (indexPath.row==4) {
            _yueDatePickerBgView.hidden=NO;
            [_yueDatePickerBgView bringSubviewToFront:_juanPiker];
        }
    }
    
    
}
- (IBAction)juanOrYueTureBtnClick:(UIButton *)sender {
    _yueDatePickerBgView.hidden=YES;
    if (_cellNum==0) {
        
        NSString *date=[self StrWithDate:_yueDatePicker.date];
        NSLog(@"时间----------%@",date);
        NSTimeInterval time=[_yueDatePicker.date timeIntervalSince1970];
        NSLog(@"%f",time);
        
        _yongCheTime=time;
        [_callCarTitleArr replaceObjectAtIndex:0 withObject:date];
    }
    if (_cellNum==4) {
        if (_pickViewNum==0) {
            [_detailArr replaceObjectAtIndex:4 withObject:@"节省0元"];
            _quan=@"0";
        }else{
            [_detailArr replaceObjectAtIndex:4 withObject:
             [NSString stringWithFormat:@"节省%@元",_juanArr[_pickViewNum]]];
            _quan=_juanArr[_pickViewNum];
        }
    }
    
    [_myTableView reloadData];
}
- (IBAction)juanOrYueQuxiaoBtnClick:(UIButton *)sender {
    _yueDatePickerBgView.hidden=YES;
    
    
    
    
}



-(void)tapGR:(UITapGestureRecognizer *)tapGR
{
    NSLog(@"点击");
    [UIView animateWithDuration:0.4 animations:^{
        
        //        CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
        //        CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
        //        self.navigationController.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
        self.navigationController.view.frame=CGRectMake(0, 0, _view_width, _view_height);
        
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"007" object:@"0" userInfo:nil];
    _mengScreen.hidden=YES;
    _infoBtnSign=1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"King" object:nil];
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
