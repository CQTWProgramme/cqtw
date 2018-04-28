//
//  MyHouseDetailModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHouseDetailModel : NSObject
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *areasId;
@property (nonatomic, copy)NSString *disName;
@property (nonatomic, copy)NSString *branchId;
@property (nonatomic, copy)NSString *houseName;
@property (nonatomic, copy)NSString *areasName;
@property (nonatomic, assign)long type;
@property (nonatomic, copy)NSArray *nameAndTypeList;
@end
