//
//  EquipmentModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>
//设备模型
@interface EquipmentModel : BaseModel
@property (nonatomic, copy) NSString *azwz;
@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, copy) NSString *csjg;
@property (nonatomic, copy) NSString *dlzh;
@property (nonatomic, copy) NSString *sbbh;
@property (nonatomic, copy) NSString *sbcj;
@property (nonatomic, copy) NSString *sbdk;
@property (nonatomic, copy) NSString *sbip;
@property (nonatomic, assign) long sbgn;
@property (nonatomic, copy) NSString *sbmc;
@property (nonatomic, copy) NSString *sbmm;
@property (nonatomic, copy) NSString *sbxh;
@property (nonatomic, copy) NSString *sfgg;
@property (nonatomic, strong) NSArray *state;
@property (nonatomic, copy) NSString *sysAllStateList;
@property (nonatomic, copy) NSString *txfs;

@property (nonatomic, copy) NSString *deviceId;
+ (void)getListDevicesDataById:(NSString *)branchId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
