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
@end
