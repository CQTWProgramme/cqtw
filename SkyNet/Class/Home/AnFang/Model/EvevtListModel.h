//
//  EvevtListModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseModel.h"

@interface EvevtListModel : BaseModel
@property (nonatomic, copy) NSString *alarmdesc;
@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, assign) long begintime;
@property (nonatomic, assign) long branchType;
@property (nonatomic, copy) NSString *cardnumId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelJktdh;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) long createtime;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *deviceSbbh;
@property (nonatomic, copy) NSString *endtime;
@property (nonatomic, assign) long isauto;
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sourceInfo;
@property (nonatomic, copy) NSString *sourceType;


+ (void)getEventListDataById:(NSString *)branchId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
