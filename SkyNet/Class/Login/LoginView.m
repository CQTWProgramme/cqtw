//
//  LoginView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/21.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewModel.h"
#define LOGIN_MARGIN_X 40
#define LOGIN_TEXT_H 45
#define LOGIN_PADDING 10
@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=NAVI_COLOR;
        [self initUI];
    
    }
    
    return self;
    
}

#pragma mark 初始化UI
-(void)initUI{
    
    
    
    UIImageView * logoImageView=[UIImageView new];
    UIImage * logoImage=ImageNamed(@"login_logo");
    float scaleH=logoImage.size.height/logoImage.size.width;
    logoImageView.image=logoImage;
    [self addSubview:logoImageView];
    logoImageView.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self, 80)
    .widthIs(SCREEN_WIDTH*0.35)
    .heightIs(SCREEN_WIDTH*0.35*scaleH);
    
    
    _usernameText=[UITextField new];
    _usernameText.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.1];
    _usernameText.layer.borderWidth=1;
    _usernameText.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.3].CGColor;
    _usernameText.textAlignment=NSTextAlignmentLeft;
    _usernameText.layer.masksToBounds=YES;
    _usernameText.textColor=[UIColor whiteColor];
    _usernameText.placeholder=@"请输入用户名";
    [_usernameText setValue:RGBA(126, 160, 238, 1) forKeyPath:@"_placeholderLabel.textColor"];
    _usernameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_usernameText];
    _usernameText.sd_layout
    .leftSpaceToView(self,LOGIN_MARGIN_X)
    .rightSpaceToView(self, LOGIN_MARGIN_X)
    .topSpaceToView(logoImageView, LOGIN_MARGIN_X)
    .heightIs(LOGIN_TEXT_H);
    _usernameText.sd_cornerRadius=@(LOGIN_TEXT_H/2);
    
    
    UIView * userLeftView =[UIView new];
    userLeftView.backgroundColor=[UIColor clearColor];
    userLeftView.frame=CGRectMake(0, 0, 50, LOGIN_TEXT_H);
    UIImageView * leftUserImageView =[UIImageView new];
    UIImage * leftUserImage=ImageNamed(@"login_user");
    leftUserImageView.image=leftUserImage;
    [userLeftView addSubview:leftUserImageView];
    leftUserImageView.sd_layout
    .rightSpaceToView(userLeftView, 10)
    .centerYEqualToView(userLeftView)
    .widthIs(leftUserImage.size.width)
    .heightIs(leftUserImage.size.height);
   _usernameText.leftView=userLeftView;
   _usernameText.leftViewMode=UITextFieldViewModeAlways;
    
    
    
    
    
    _passwordText=[UITextField new];
    _passwordText.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.1];
    _passwordText.layer.borderWidth=1;
    _passwordText.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.3].CGColor;;
    _passwordText.textAlignment=NSTextAlignmentLeft;
    _passwordText.layer.masksToBounds=YES;
    _passwordText.textColor=[UIColor whiteColor];
    _passwordText.placeholder=@"请输入密码";
    [_passwordText setValue:RGBA(126, 160, 238, 1) forKeyPath:@"_placeholderLabel.textColor"];
    _passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_passwordText];
    _passwordText.sd_layout
    .leftSpaceToView(self,LOGIN_MARGIN_X)
    .rightSpaceToView(self, LOGIN_MARGIN_X)
    .topSpaceToView(_usernameText, LOGIN_PADDING)
    .heightIs(LOGIN_TEXT_H);
    _passwordText.sd_cornerRadius=@(LOGIN_TEXT_H/2);
    
    
    UIView * passwordLeftView =[UIView new];
    passwordLeftView.backgroundColor=[UIColor clearColor];
    passwordLeftView.frame=CGRectMake(0, 0, 50, LOGIN_TEXT_H);
    UIImageView * leftPasswordImageView =[UIImageView new];
    UIImage * leftPasswordImage=ImageNamed(@"login_password");
    leftPasswordImageView.image=leftPasswordImage;
    [passwordLeftView addSubview:leftPasswordImageView];
    leftPasswordImageView.sd_layout
    .rightSpaceToView(passwordLeftView, 10)
    .centerYEqualToView(passwordLeftView)
    .widthIs(leftPasswordImage.size.width)
    .heightIs(leftPasswordImage.size.height);
    _passwordText.leftView=passwordLeftView;
    _passwordText.leftViewMode=UITextFieldViewModeAlways;

    
    UIView * passwordRightView =[UIView new];
    passwordRightView.backgroundColor=[UIColor clearColor];
    passwordRightView.frame=CGRectMake(0, 0, 40, LOGIN_TEXT_H);
    UIButton * showPassBtn=[UIButton new];
    showPassBtn.backgroundColor=[UIColor clearColor];
    UIImage * showPassImage=ImageNamed(@"login_eye_show");
    UIImage * hiddenPassImage=ImageNamed(@"login_eye_hidden");
    [showPassBtn setBackgroundImage:showPassImage forState:UIControlStateNormal];
    [showPassBtn setBackgroundImage:hiddenPassImage forState:UIControlStateSelected];
    [showPassBtn addTarget:self action:@selector(showPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [passwordRightView addSubview:showPassBtn];
    
    if ([ClientTool isEysPasswordShow]) {
        showPassBtn.selected=YES;
        _passwordText.secureTextEntry = YES;
    }else{
        
        showPassBtn.selected=NO;
        _passwordText.secureTextEntry = NO;
    }
    
    showPassBtn.sd_layout
    .leftSpaceToView(passwordRightView, 0)
    .centerYEqualToView(passwordRightView)
    .widthIs(showPassImage.size.width)
    .heightIs(showPassImage.size.height);
    _passwordText.rightView=passwordRightView;
    _passwordText.rightViewMode=UITextFieldViewModeAlways;
    
    
    
    
    UIButton * loginBtn =[UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:NAVI_COLOR forState:UIControlStateNormal];
    loginBtn.backgroundColor=RGBA(201, 219, 254, 1);
    loginBtn.layer.masksToBounds=YES;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    loginBtn.sd_layout
    .leftSpaceToView(self,LOGIN_MARGIN_X)
    .rightSpaceToView(self, LOGIN_MARGIN_X)
    .topSpaceToView(_passwordText, LOGIN_PADDING)
    .heightIs(LOGIN_TEXT_H);
    loginBtn.sd_cornerRadius=@(LOGIN_TEXT_H/2);

    
    UIButton * registerBtn =[UIButton new];
    [registerBtn setTitle:@"暂无账号? 立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.backgroundColor=[UIColor clearColor];
    registerBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    registerBtn.layer.borderWidth=0.8;
    registerBtn.layer.masksToBounds=YES;
    [registerBtn addTarget:self action:@selector(jumpToRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];
    registerBtn.sd_layout
    .leftSpaceToView(self,LOGIN_MARGIN_X)
    .rightSpaceToView(self, LOGIN_MARGIN_X)
    .topSpaceToView(loginBtn, LOGIN_PADDING)
    .heightIs(LOGIN_TEXT_H);
    registerBtn.sd_cornerRadius=@(LOGIN_TEXT_H/2);
     registerBtn.sd_cornerRadius=@(LOGIN_TEXT_H/2);
    

}

#pragma mark 登录点击
-(void)loginClick{
    
    LoginViewModel * loginViewModel =[LoginViewModel new];
    BOOL isValid =[loginViewModel checkLoginInfoPhone:_usernameText.text password:_passwordText.text];
        
    if (self.delegate&&isValid) {
        [self.delegate loginWithUsername:_usernameText.text password:_passwordText.text];
    }
    
}

#pragma mark 跳转到注册界面
-(void)jumpToRegisterVC{
    
    if (self.delegate) {
        [self.delegate jumpToRegisterVC];
    }
    
}


#pragma mark 显示隐藏密码
-(void)showPasswordClick:(UIButton *)sender{
    
    BOOL isSelect=NO;
    if (sender.selected) {
        isSelect=NO;
        sender.selected=NO;
        _passwordText.secureTextEntry = NO;
        
    }else{
        isSelect=YES;
        sender.selected=YES;
        _passwordText.secureTextEntry = YES;

    }
    
    if (self.delegate) {
        [self.delegate showEyePassword:isSelect];
    }
    
}
@end
