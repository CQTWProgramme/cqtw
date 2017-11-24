//
//  LoginViewModel.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel


/**
 验证登录信息

 @param phone 手机号码
 @param password 密码
 @return 是否有效
 */
-(BOOL)checkLoginInfoPhone:(NSString *)phone
                  password:(NSString *)password;







/**
 请求登录

 @param userName 用户名
 @param password 密码
 */
-(void)requestLoginWithUserName:(NSString *)userName
                       password:(NSString *)password;
/**
 修改密码
 
 @param oldDlmm 原始加密后密码
 @param newDlmm 新修改加密后密码
 */
-(void)updatePasswordWithOldPassword:(NSString *)oldPassword
                         newPassword:(NSString *)newPassword;
/**
 修改用户信息
 
 @param yhxm 用户姓名
 @param yhxb 用户性别(0.男 1.女)
 @param enablepushapp 是否推送app开关(0:推 其余数字表示不推)
 @param bz 备注
 */
-(void)updateUserInfoWithYhxm:(NSString *)yhxm
                         yhxb:(NSString *)yhxb
                enablepushapp:(NSString *)enablepushapp
                           bz:(NSString *)bz;
@end
