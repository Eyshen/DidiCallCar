//
//  BaseViewController.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/20.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//左边一个 item
- (void)setLeftItemsWithImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL )sel;
//右边两个 item
- (void)setRightItemsWithFirstImageName:(NSString *)FirstImageName andFirstTarget:(id)FirstTarget andFirstSelector:(SEL )FirstSel andSecondImageName:(NSString *)SecondImageName andSecondTarget:(id)SecondTarget andSecondSelector:(SEL)SecondSel;
@end
