//
//  ChooseCarViewController.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/21.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ChooseCarViewController.h"

#import "NetRequest.h"

@interface ChooseCarViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigCarView;
@property (weak, nonatomic) IBOutlet UILabel *carDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *car1Label;
@property (weak, nonatomic) IBOutlet UILabel *car2Label;
@property (weak, nonatomic) IBOutlet UIButton *car1View;
@property (weak, nonatomic) IBOutlet UIButton *car2View;




@end

@implementation ChooseCarViewController
{
    int _selectSign;
    NSMutableArray *_carKind;
    NSInteger _price;
    CarKindParse *_parse;
    UIImageView *_sanjiaoPic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=NO;
    _carKind=[NSMutableArray new];
    _selectSign=0;
    [self setLeftItemsWithImageName:@"list_fanhui" andTarget:nil andSelector:@selector(backBtnClick)];
    _car1Label.textColor=[UIColor colorWithRed:0.953 green:0.502 blue:0.094 alpha:1.000];
    _sanjiaoPic =[[UIImageView alloc]initWithFrame:CGRectMake(59, 393, 10, 10)];
    _sanjiaoPic.image=[UIImage imageNamed:@"xuanze111"];
    _sanjiaoPic.center=CGPointMake(_car1Label.center.x, _sanjiaoPic.center.y);
    [self.view addSubview:_sanjiaoPic];
    [NetRequest getCarKindSuccess:^(CarKindParse *parse) {
        _parse=parse;
        [self setUI];
        NSLog(@"选车型下载成功");
    } failure:^(NSString *errorMessage) {
        
        NSLog(@"下载失败%@",errorMessage);
    }];
}
-(void)setUI
{
    CarKindInfo *ainfo=_parse.data[0];
    CarKindInfo *binfo=_parse.data[1];
    [_bigCarView setImageWithURL:[NSURL URLWithString:ainfo.car_image]];
    
    _car1Label.text=ainfo.car_type_name;
    _car2Label.text=binfo.car_type_name;
    
    [_carKind addObject:ainfo.car_type_note];
    [_carKind addObject:binfo.car_type_note];
    
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)car1BtnClick:(UIButton *)sender {
    _car1Label.textColor=[UIColor blackColor];
    _car2Label.textColor=[UIColor blackColor];
    CarKindInfo *ainfo=_parse.data[0];
    CarKindInfo *binfo=_parse.data[1];
    if (sender.tag==10) {
        
        NSLog(@"选的车1");
        _car1Label.textColor=[UIColor colorWithRed:0.953 green:0.502 blue:0.094 alpha:1.000];
        _sanjiaoPic.center=CGPointMake(sender.center.x, _sanjiaoPic.center.y);
        
//        [_bigCarView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.42.144.10%@",ainfo.car_image]]];
        _bigCarView.image=[UIImage imageNamed:@"img_jiaoche111"];
        
        _carDetailLabel.text=[NSString stringWithFormat:@"%@元+%@元/分钟+%@元/公里系统自动源发多种车型",ainfo.car_min_price,ainfo.car_perminute_wait_price,ainfo.car_perkilometer_price];
        
        _selectSign=0;
    }
    if (sender.tag==11){
        NSLog(@"选的车2");
        _car2Label.textColor=[UIColor colorWithRed:0.953 green:0.502 blue:0.094 alpha:1.000];
        _sanjiaoPic.center=CGPointMake(sender.center.x, _sanjiaoPic.center.y);
        
//        [_bigCarView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.42.144.10%@",binfo.car_image]]];
        _bigCarView.image=[UIImage imageNamed:@"img_suv111"];
        
        _carDetailLabel.text=[NSString stringWithFormat:@"%@元+%@元/分钟+%@元/公里系统自动源发多种车型",binfo.car_min_price,binfo.car_perminute_wait_price,binfo.car_perkilometer_price];
        _selectSign=1;
    }
}
- (IBAction)commitBtnClick:(UIButton *)sender {
    CarKindInfo *ainfo=_parse.data[0];
    CarKindInfo *binfo=_parse.data[1];
    if (!_selectSign) {
        _price=[ainfo.car_perkilometer_price floatValue];
    }else{
        _price=[binfo.car_perkilometer_price floatValue];
    }
    
    self.carBlock(_carKind[_selectSign],_price);
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
