//
//  ACVillageModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/6.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ACVillageModel.h"

@implementation ACVillageModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             
              @"doorInfo":[ACVillageDoorModel class]
             };
}
@end
