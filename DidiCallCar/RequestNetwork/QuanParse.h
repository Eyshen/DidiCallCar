//
//  QuanParse.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/23.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuanParse : NSObject
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *error_code;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *passenger_telno;
@property (nonatomic,strong) NSString *result;
+(instancetype)parse:(NSDictionary *)responseObj;
@end
@interface QuanInfo : NSObject


@property (nonatomic,strong) NSString *coupon_day_end;
@property (nonatomic,strong) NSString *coupon_day_start;
@property (nonatomic,strong) NSString *coupon_detail_image;
@property (nonatomic,strong) NSString *coupon_detail_note;
@property (nonatomic,strong) NSString *coupon_discount_amount;
@property (nonatomic,strong) NSString *coupon_end_date;
@property (nonatomic,strong) NSString *coupon_start_date;
@property (nonatomic,strong) NSString *coupon_title;
@property (nonatomic,strong) NSString *my_coupon_id;

+(instancetype)parse:(NSDictionary *)quanDic;

@end