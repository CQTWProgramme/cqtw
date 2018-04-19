//
//  LatticePointDetailModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseModel.h"

@interface LatticePointDetailModel : BaseModel
@property (nonatomic, copy) NSString *districtId;
@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, copy) NSString *wdwz;
@property (nonatomic, copy) NSString *wdlx;
@property (nonatomic, copy) NSString *azry;
@property (nonatomic, copy) NSString *xgsj;
@property (nonatomic, copy) NSString *districtMc;
@property (nonatomic, copy) NSString *wdjd;
@property (nonatomic, copy) NSString *alarmoperId;
@property (nonatomic, copy) NSString *alarmchargeId;
@property (nonatomic, copy) NSString *wdmc;
@property (nonatomic, copy) NSString *wdbh;
@property (nonatomic, copy) NSString *alarmchargeMc;
@property (nonatomic, copy) NSString *alarmoperMc;
@property (nonatomic, copy) NSString *wdwd;
+ (void)getLatticePointDetailDataById:(NSString *)customId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
+ (void)getLatticePointDetailHeadDataById:(NSString *)branchId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
