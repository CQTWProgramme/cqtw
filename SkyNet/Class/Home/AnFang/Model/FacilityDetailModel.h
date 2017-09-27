//
//  FacilityDetailModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacilityDetailModel : BaseModel
+ (void)getDetailDataById:(NSString *)deviceId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
