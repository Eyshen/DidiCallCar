//
//  Utility.m
//  DidiCallCar
//
//  Created by kyo gaku on 2015/05/22.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "Utility.h"

@implementation Utility

@synthesize userInfo;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfo = [[UserInfoObj alloc] init];
    }
    return self;
}

+ (Utility *)sharedUtility
{
    static Utility *sharedUtilityInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtilityInstance = [[self alloc] init];
        
    });
    return sharedUtilityInstance;
}

- (NSString*)getStrFromDate:(NSDate*)aDate {

    NSString *strResult = nil;
    // 操作
    
    return strResult;
}


+ (int)getSum:(int)a b:(int)b {

    return a+b;
}


@end
