//
//  UserInfo.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/24.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
+(instancetype)shareInstance;
@property(nonatomic, copy)NSString *bz;
@property(nonatomic, copy)NSString *cardnumId;
@property(nonatomic, copy)NSString *dh;
@property(nonatomic, copy)NSString *districtId;
@property(nonatomic, copy)NSString *dlmm;
@property(nonatomic, copy)NSString *dlsj;
@property(nonatomic, copy)NSString *dlzh;
@property(nonatomic, assign)long enablepushapp;
@property(nonatomic, copy)NSString *jsonconfig;
@property(nonatomic, copy)NSString *mqTopic;
@property(nonatomic, copy)NSString *msqUrl;
@property(nonatomic, copy)NSString *roleId;
@property(nonatomic, copy)NSString *userId;
@property(nonatomic, copy)NSString *wxOpenId;
@property(nonatomic, copy)NSString *xgsj;
@property(nonatomic, assign)long yhlx;
@property(nonatomic, assign)long yhxb;
@property(nonatomic, copy)NSString *yhxm;
@property(nonatomic, assign)long yhzt;

//+(void)saveUserInfo;
//+(void)removeUserInfo;
@end
