//
//  MyHouseListModel.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHouseListModel : NSObject
@property (nonatomic, copy)NSString *areasId;
@property (nonatomic, copy)NSString *branchId;
@property (nonatomic, copy)NSString *disName;
@property (nonatomic, copy)NSString *houseName;
@property (nonatomic, assign)long type;
@end
