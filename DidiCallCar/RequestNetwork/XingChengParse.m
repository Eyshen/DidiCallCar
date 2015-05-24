//
//  XingChengParse.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/23.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "XingChengParse.h"

@implementation XingChengParse
-(id)init
{
    if (self=[super init]) {
        _data=[NSMutableArray new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
    XingChengParse *parse=[self new];
    NSArray *dataArr=responseObj[@"data"];
    [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parse.data addObject:[XingChengInfo parse:obj]];
    }];
    return parse;
}

@end
@implementation XingChengInfo

+(instancetype)parse:(NSDictionary *)xingChengDic
{
    XingChengInfo *info=[XingChengInfo new];
    info.order_datetime=xingChengDic[@"order_datetime"];
    info.order_from_address=xingChengDic[@"order_from_address"];
    info.order_id=xingChengDic[@"order_id"];
    info.order_state=xingChengDic[@"order_state"];
    info.order_to_address=xingChengDic[@"order_to_address"];
    info.payment_price=xingChengDic[@"payment_price"];

    return info;
}

@end

