//
//  LoginVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/21.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"
#import "RegisterVC.h"
#import "LoginViewModel.h"
#import "BaseNavigationC.h"
@interface LoginVC ()<LoginViewDelegate>
@property(nonatomic,strong)LoginView * loginView;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.loginView];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}

#pragma mark 登录点击
-(void)loginWithUsername:(NSString *)username password:(NSString *)password{
    
    MJWeakSelf
    LoginViewModel * loginViewModel =[LoginViewModel new];
    [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        [ClientTool saveToken:returnValue];
        UITabBarController * tabBar =[ClientTool setupTabBar];
        [weakSelf presentViewController:tabBar animated:YES completion:nil];
        
    } WithErrorBlock:^(id errorCode) {
        
   
    } WithFailureBlock:^{
        
    
    }];
    
    
    [loginViewModel requestLoginWithUserName:username password:password];
    

    
}


#pragma mark 跳转到注册界面
-(void)jumpToRegisterVC{
    RegisterVC * registerVC=[[RegisterVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark 是否隐藏密码
-(void)showEyePassword:(BOOL)isHidden{
    
    [ClientTool saveEyePassword:isHidden];
    
}


-(LoginView *)loginView{
    
    if (!_loginView) {
        _loginView =[[LoginView alloc]initWithFrame:self.view.bounds];
        _loginView.delegate=self;
        
    }
    
    return _loginView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
