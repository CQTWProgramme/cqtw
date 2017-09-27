//
//  LoginView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/8/21.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>


/**
 登录

 @param username 用户名
 @param password 密码
 */
-(void)loginWithUsername:(NSString *)username
                password:(NSString *)password;




/**
 显示隐藏密码

 @param isHidden 是否隐藏
 */
-(void)showEyePassword:(BOOL)isHidden;




/**
 跳转到注册界面
 */
-(void)jumpToRegisterVC;


@end
@interface LoginView : UIView
@property(nonatomic,strong)UITextField * usernameText;//用户名输入框
@property(nonatomic,strong)UITextField * passwordText;//密码输入框
@property(nonatomic,strong)id<LoginViewDelegate>delegate;//代理
@end
