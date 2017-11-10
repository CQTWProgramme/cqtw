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
@end
