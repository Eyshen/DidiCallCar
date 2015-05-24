//
//  CallCarViewController.h
//  Didiyueche
//
//  Created by qianfeng on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AMapSearchKit/AMapSearchAPI.h>
#import "BaseViewController.h"
@protocol CallCarViewControllerDelegate <NSObject>

-(void)exchangeFromLocation:(AMapPOI *)poi;
-(void)exchangeToLocation:(AMapPOI *)poi;
-(void)exchangeNowMapLocation:(AMapPOI *)poi;


@end
@interface CallCarViewController : BaseViewController

@property(nonatomic,strong)NSString *titlename;
//地点
@property(nonatomic,strong)NSString *searchname;

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;

@property(nonatomic,assign)id<CallCarViewControllerDelegate>delegate;
//
@property(nonatomic,assign)NSInteger fromOrTo;


@end
