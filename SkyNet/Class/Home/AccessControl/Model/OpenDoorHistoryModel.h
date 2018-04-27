//
//  OpenDoorHistoryModel.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenDoorHistoryModel : NSObject
@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, copy) NSString *disName;
@property (nonatomic, copy) NSString *openDoorWz;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) long type;
@end
