//
//  UserInfo.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/24.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *_userinfo = nil;

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userinfo = [[super allocWithZone:NULL] init];
    });
    return _userinfo;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [UserInfo shareInstance];
}

-(id)copyWithZone:(NSZone *)zone {
    return [UserInfo shareInstance];
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return [UserInfo shareInstance];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_bz forKey:@"bz"];
    [aCoder encodeObject:_cardnumId forKey:@"cardnumId"];
    [aCoder encodeObject:_dh forKey:@"dh"];
    [aCoder encodeObject:_districtId forKey:@"districtId"];
    [aCoder encodeObject:_dlmm forKey:@"dlmm"];
    [aCoder encodeObject:_dlsj forKey:@"dlsj"];
    [aCoder encodeObject:_dlzh forKey:@"dlzh"];
//    [aCoder encode:_cardnumId forKey:@"enablepushapp"];
//    [aCoder encodeObject:_dh forKey:@"dh"];
//    [aCoder encodeObject:_districtId forKey:@"districtId"];
//    [aCoder encodeObject:_dlmm forKey:@"dlmm"];
//    [aCoder encodeObject:_dlsj forKey:@"dlsj"];
    
}
@end
