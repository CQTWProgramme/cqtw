//
//  VillageApplyModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VillageApplyModel : NSObject
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *userHouseId;
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, assign) long auditState;
@property (nonatomic, copy) NSString *disName;
@property (nonatomic, copy) NSString *auditTime;
@property (nonatomic, copy) NSString *houseName;
@property (nonatomic, assign) long name;
@property (nonatomic, assign) NSInteger type;



@end
