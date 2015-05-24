//
//  ChooseCarViewController.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/21.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CarBlock) (NSString *kind,NSInteger price);
@interface ChooseCarViewController : BaseViewController
@property (nonatomic,strong) CarBlock carBlock;
@end
