//
//  NetRequest.m
//  DidiCallCar
//
//  Created by qianfeng on 15/5/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest
+(void)getCarKindSuccess:(void(^)(CarKindParse *parse))success failure:(void(^)(NSString *errorMessage))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager POST:@"http://121.42.144.10/DDYC/service/getallcartype"parameters:(self)success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([CarKindParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}


+(void)getQuanSuccess:(void (^)(QuanParse* parse))success failure:(void (^)(NSString *errorMessage))failure withUrl:(NSString *)urlStr
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager POST:@"http://121.42.144.10/DDYC/service/getpassengerallcoupon?passenger_telno=15942818446" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([QuanParse parse:responseObject])
        ;     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error.localizedDescription);
        }];
    
}

+(void)getXingChengSuccess:(void (^)(XingChengParse * parse))success failure:(void (^)(NSString *errorMessage))failure withPhoneNum:(NSString *)numStr runningStr:(NSString *)runningStr getCount:(NSString *)getCount
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    //121.42.144.10/DDYC/service/getpassengerhistoryorder?passenger_telno=15942818446&is_running=0&start_index=1&get_data_count=20
    
    [manager POST:@"http://121.42.144.10/DDYC/service/getpassengerhistoryorder" parameters:@{@"passenger_telno":numStr,@"is_running":runningStr,@"start_index":@"1",@"get_data_count":getCount} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([XingChengParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}
@end
