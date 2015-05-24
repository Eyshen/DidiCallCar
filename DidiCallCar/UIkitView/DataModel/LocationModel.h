//
//  LocationModel.h
//  DidiCallCar
//
//  Created by qianfeng on 15/5/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

//    _fromLocation.locationname=poi.name;
//    _fromLocation.latitude=poi.location.latitude;
//    _fromLocation.longitude=poi.location.longitude;

@property (nonatomic,strong)NSString *locationName;
@property (nonatomic,assign)double latitude;
@property (nonatomic,assign)double longitude;

@end
