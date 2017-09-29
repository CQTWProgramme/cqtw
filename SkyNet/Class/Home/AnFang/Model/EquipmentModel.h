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
@property (nonatomic, copy) NSString *deviceId;
+ (void)getListDevicesDataById:(NSString *)customId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
