//
//  XingChengParse.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/23.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XingChengParse : NSObject
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *error_code;
@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) NSString *result;

+(instancetype)parse:(NSDictionary *)responseObj;
@end

@interface XingChengInfo : NSObject


@property (nonatomic,strong) NSString *order_datetime;
@property (nonatomic,strong) NSString *order_from_address;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *order_state;
@property (nonatomic,strong) NSString *order_to_address;
@property (nonatomic,strong) NSString *payment_price;


+(instancetype)parse:(NSDictionary *)xingChengDic;

@end
