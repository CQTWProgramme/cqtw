//
//  ACViewModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewModel.h"

@interface ACViewModel : BaseViewModel
/**
 根据用户当前位置获取用户小区信息
 
 @param latitude 纬度
 @param longitude 经度
 */
-(void)requestDataWithLatitude:(NSString *)latitude Longitude:(NSString *)longitude;
/**
 验证登录用户是否需要实名认证
 */
-(void)IsNeedRealNameConfirm;
/**
 上传图片
 */
-(void)uploadImgWithFileImg:(NSData *)fileImg type:(NSInteger )type idCardNumber:(NSString *)idCardNumber;
/**
 根据身份证正面照获取信息
 */
-(void)getMessageWithFileImg:(NSData *)fileImg;
/**
 申请门禁用户基本信息认证接口
 */
-(void)certificationConfirmWithName:(NSString *)name sex:(NSString *)sex peoples:(NSString *)peoples birth:(NSString *)birth address:(NSString *)address idCardNumber:(NSString *)idCardNumber cardType:(NSString *)cardType idCardPage:(NSString *)idCardPage idCardPage1:(NSString *)idCardPage1 lifePhoto:(NSString *)lifePhoto facePhotos:(NSString *)facePhotos;
/**
 查询拥有小区及房屋信息
 */
-(void)selectBranchListDataWithDisName:(NSString *)disName;
/**
 根据小区及扩张区域查询子级扩展区域数据接口
 */
-(void)selectChildListDataWithParentId:(NSString *)parentId;
/**
 根据门id开门
 */
-(void)acOpenDoorWithDoorId:(NSString *)doorId;
/**
 查询申请审核人详细信息
 */
-(void)getApplyUserInfoDataWithUserHouseId:(NSInteger)userHouseId;
/**
 查询拥有小区及房屋信息
 */
-(void)getBranchAreasInfoData;
/**
 房屋绑定申请审核接口
 */
-(void)getAuditApprovalOrRefusedToDataWithUserHouseId:(NSString *)userHouseId type:(NSInteger)type reason:(NSString *)reason;
/**
 查询成员管理数据
 */
-(void)acGetMemberManagementData;
/**
 查询待审核的申请房屋绑定数据
 */
-(void)acGetApplyAuditData;
/**
 查询访客记录
 */
-(void)acGetVisitorsRecord;
/**
 增加访客请求接口
 */
-(void)acCreateVisitorsWithAreasId:(NSString *)areasId name:(NSString *)name phone:(NSString *)phone startTime:(NSString *)startTime endTime:(NSString *)endTime bz:(NSString *)bz facePicture:(NSData *)facePicture;

/**
 开门记录
 */
-(void)getOpenDoorHistoryData;

/**
 我的房屋
 */
-(void)getMyHouseListData;

/**
 房屋绑定审核查询
 */
-(void)selectAppUserHouseData;
/**
 用户申请房屋绑定请求接口
 */
-(void)acSaveUserHouseWithAreasId:(NSString *)areasId type:(NSInteger)type ly:(NSInteger)ly bz:(NSString *)bz;
/**
 获取人脸信息
 */
-(void)acGetFaceImageData;
/**
 更新人脸信息
 */
-(void)acUpdateFaceImageWithFeatureId:(NSString *)featureId FacePicture:(UIImage *)facePicture;
/**
 上传人脸图片
 */
-(void)uploadFaceImgWithFileImg:(NSData *)fileImg featureId:(NSString *)featureId;
/**
 根据房屋Id,查询房屋下成员信息
 */
-(void)acGetHouseDetialWithAreasId:(NSString *)areasId;
/**
 根据经纬度获取离我最近的小区数据
 */
-(void)acGetNearbyAreaDataWithLatitude:(NSString *)latitude longitude:(NSString *)longitude;
/**
 模糊搜索小区接口
 */
-(void)acGetAreaDataWithkey:(NSString *)disName;
@end
