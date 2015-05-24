//
//  QuanParse.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/23.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "QuanParse.h"

@implementation QuanParse
-(id)init
{
    if (self=[super init]) {
        _data=[NSMutableArray new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
    QuanParse *parse=[self new];
    NSArray *dataArr=responseObj[@"data"];
    [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parse.data addObject:[QuanInfo parse:obj]];
    }];
    return parse;
}

@end
@implementation QuanInfo

+(instancetype)parse:(NSDictionary *)quanDic
{
    QuanInfo *info=[QuanInfo new];
    info.coupon_day_end=quanDic[@"coupon_day_end"];
    info.coupon_day_start=quanDic[@"coupon_day_start"];
    info.coupon_detail_image=quanDic[@"coupon_detail_image"];
    info.coupon_detail_note=quanDic[@"coupon_detail_image"];
    info.coupon_discount_amount=quanDic[@"coupon_discount_amount"];
    info.coupon_end_date=quanDic[@"coupon_end_date"];
    info.coupon_start_date=quanDic[@"coupon_start_date"];
    info.coupon_title=quanDic[@"coupon_title"];
    info.my_coupon_id=quanDic[@"my_coupon_id"];
    return info;
}

@end
