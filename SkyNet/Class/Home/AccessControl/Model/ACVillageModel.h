//
//  ACVillageModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/6.
//  Copyright © 2017年 xrg. All rights reserved.
//  门禁小区模型

#import <Foundation/Foundation.h>
#import "ACVillageDoorModel.h"

@interface ACVillageModel : NSObject
@property (nonatomic, copy) NSString *wdwd;
@property (nonatomic, copy) NSString *wdwz;
@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, copy) NSString *wdmc;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *wdjd;
@property (nonatomic, strong) NSArray<ACVillageDoorModel *> *doorInfo;
@end
