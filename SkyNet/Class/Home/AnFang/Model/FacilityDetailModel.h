//
//  FacilityDetailModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacilityDetailModel : BaseModel
@property (nonatomic, copy) NSString *azwz;
@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) long csjg;
@property (nonatomic, copy) NSString *dlzh;
@property (nonatomic, copy) NSString *sbbh;
@property (nonatomic, assign) long gprsLoginserver;
@property (nonatomic, assign) long lanLoginserver;
@property (nonatomic, copy) NSString *sbcj;
@property (nonatomic, copy) NSString *sbip;
@property (nonatomic, assign) long sbdk;
@property (nonatomic, assign) long sbgn;
@property (nonatomic, copy) NSString *sblx;
@property (nonatomic, copy) NSString *sbmc;
@property (nonatomic, copy) NSString *sbxh;
@property (nonatomic, copy) NSString *sbmm;
@property (nonatomic, copy) NSString *serverId;
@property (nonatomic, assign) long sfgg;
@property (nonatomic, assign) long txfs;

+ (void)getDetailDataById:(NSString *)deviceId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
