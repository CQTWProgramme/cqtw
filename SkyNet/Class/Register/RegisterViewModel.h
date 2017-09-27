//
//  RegisterViewModel.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/5.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewModel : BaseViewModel



/**
 用户注册

 @param dlzh 手机号码
 @param dlmm 密码
 @param code 验证码
 */
-(void)requestRegisterUser:(NSString *)dlzh
                      dlmm:(NSString *)dlmm
                      code:(NSString *)code;





/**
 获取验证码

 @param phone 手机号码
 */
-(void)requestRegisterCode:(NSString *)phone
            countdownLabel:(UILabel *)countdownLabel;



/**
 验证注册信息

 @param phone 手机号码
 @param msgCode 验证码
 @param password 密码
 @param checkPassword 再次输入密码
 @return 是否有效
 */
-(BOOL)checkRegiserInfoPhone:(NSString *)phone
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password
               checkPassword:(NSString *)checkPassword;





@end
