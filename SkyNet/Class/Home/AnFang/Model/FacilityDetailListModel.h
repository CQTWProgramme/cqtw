//
//  FacilityDetailListModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseModel.h"

@interface FacilityDetailListModel : BaseModel
@property (nonatomic, copy) NSString *azdz;
@property (nonatomic, copy) NSString *bz;
@property (nonatomic, copy) NSString *cgqlx;
@property (nonatomic, copy) NSString *cgqsl;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *jkbh;
@property (nonatomic, copy) NSString *jkmc;
@property (nonatomic, assign) long jklx;
@property (nonatomic, copy) NSString *jktdh;
@property (nonatomic, copy) NSString *play_img;
@property (nonatomic, copy) NSString *play_video;
@property (nonatomic, copy) NSString *qx;
@property (nonatomic, copy) NSString *sbbh;
@property (nonatomic, strong) NSArray *state;

+ (void)getFacilityDetailListDataById:(NSString *)deviceId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
+ (void)getChannelDetailWithChannelId:(NSString *)channelId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure;
@end
