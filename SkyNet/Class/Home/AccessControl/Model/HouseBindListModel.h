//
//  HouseBindListModel.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HouseBindListModel : NSObject
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, copy) NSString *auditTime;
@property (nonatomic, copy) NSString *disName;
@property (nonatomic, assign) long auditState;
@property (nonatomic, assign) long type;
@property (nonatomic, copy) NSString *houseName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *userHouseId;
@end
