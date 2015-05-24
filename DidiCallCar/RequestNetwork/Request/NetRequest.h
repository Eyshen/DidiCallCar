//
//  NetRequest.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "CarKindParse.h"
#import "QuanParse.h"
#import "XingChengParse.h"
@interface NetRequest : NSObject

+(void)getCarKindSuccess:(void(^)(CarKindParse *parse))success failure:(void(^)(NSString *errorMessage))failure;

+(void)getQuanSuccess:(void (^)(QuanParse* parse))success failure:(void (^)(NSString *errorMessage))failure withUrl:(NSString *)urlStr;
+(void)getXingChengSuccess:(void (^)(XingChengParse* parse))success failure:(void (^)(NSString *errorMessage))failure withPhoneNum:(NSString *)numStr runningStr:(NSString *)runningStr getCount:(NSString *)getCount;
@end
