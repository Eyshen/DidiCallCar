//
//  CarKindParse.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarKindParse : NSObject

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)NSString *error_code;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *result;

+(instancetype)parse:(NSDictionary *)responseObj;

@end
@interface CarKindInfo : NSObject

@property (nonatomic,strong)NSString *car_basekilometer;
@property (nonatomic,strong)NSString *car_freewait_minutes;
@property (nonatomic,strong)NSString *car_image;
@property (nonatomic,strong)NSString *car_min_price;
@property (nonatomic,strong)NSString *car_min_price_night;
@property (nonatomic,strong)NSString *car_perkilometer_price;
@property (nonatomic,strong)NSString *car_perminute_wait_price;
@property (nonatomic,strong)NSString *car_seating;
@property (nonatomic,strong)NSString *car_type_id;
@property (nonatomic,strong)NSString *car_type_name;
@property (nonatomic,strong)NSString *car_type_note;

+(instancetype)parse:(NSDictionary *)carDic;
@end