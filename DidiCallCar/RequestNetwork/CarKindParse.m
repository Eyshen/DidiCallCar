//
//  CarKindParse.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "CarKindParse.h"

@implementation CarKindParse

-(id)init
{
    if (self=[super init]) {
        _data =[NSMutableArray new];
        
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
    CarKindParse *parse=[CarKindParse new];
    NSArray *dataArr=responseObj[@"data"];
    [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parse.data addObject:[CarKindInfo parse:obj]];
    }];
    return parse;
}
@end

@implementation CarKindInfo

+(instancetype)parse:(NSDictionary *)carDic
{
    CarKindInfo *info=[CarKindInfo new];
    info.car_basekilometer=carDic[@"car_basekilometer"];
    info.car_freewait_minutes=carDic[@"car_freewait_minutes"];
    info.car_image=carDic[@"car_image"];
    info.car_min_price=carDic[@"car_min_price"];
    info.car_min_price_night=carDic[@"car_min_price_night"];
    info.car_perkilometer_price=carDic[@"car_perkilometer_price"];
    info.car_perminute_wait_price=carDic[@"car_perminute_wait_price"];
    info.car_seating=carDic[@"car_seating"];
    info.car_type_id=carDic[@"car_type_id"];
    info.car_type_name=carDic[@"car_type_name"];
    info.car_type_note=carDic[@"car_type_note"];
    return info;
}

@end