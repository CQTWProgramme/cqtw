//
//  MemberApplyModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberApplyModel : NSObject
@property (nonatomic, copy) NSString *userHouseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *houseName;
@property (nonatomic, copy) NSString *disName;
@property (nonatomic, assign) NSInteger type;
@end
