//
//  LatticePointDetailModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseModel.h"

@interface LatticePointDetailModel : BaseModel
+ (void)getLatticePointDetailDataById:(NSString *)customId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
