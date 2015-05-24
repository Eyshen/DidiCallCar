//
//  Utility.h
//  DidiCallCar
//
//  Created by kyo gaku on 2015/05/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObj.h"

@interface Utility : NSObject

@property(nonatomic, retain) UserInfoObj           *userInfo;

+ (Utility *)sharedUtility;


- (NSString*)getStrFromDate:(NSDate*)aDate;
+ (int)getSum:(int)a b:(int)b;

@end
