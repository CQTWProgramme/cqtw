//
//  RegisterVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterView.h"
#import "RegisterViewModel.h"
@interface RegisterVC ()<RegisterViewDelegate>
@property(nonatomic,strong)RegisterView * registerView;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户注册";
   
    [self.view addSubview:self.registerView];
}


#pragma mark 获取验证码aciton
-(void)getMessageCodeWithPhone:(NSString *)phone showLabel:(UILabel *)showlabel
{
    
    RegisterViewModel * registerSever =[RegisterViewModel new];
    [registerSever setBlockWithReturnBlock:^(id returnValue) {
        
        
    } WithErrorBlock:^(id errorCode) {
        
        
    } WithFailureBlock:^{
        
    }];

    [registerSever requestRegisterCode:phone countdownLabel:showlabel];

}



#pragma mark 注册
-(void)registerUserWithPhone:(NSString *)phone
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password
{
    
    RegisterViewModel * registerSever =[RegisterViewModel new];
    [registerSever setBlockWithReturnBlock:^(id returnValue) {
        
        
    } WithErrorBlock:^(id errorCode) {
        
        
    } WithFailureBlock:^{
        
    }];
    
    [registerSever requestRegisterUser:phone dlmm:password code:msgCode];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(RegisterView *)registerView{
    
    if (!_registerView) {
        _registerView =[[RegisterView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _registerView.delegate=self;
        
    }
    
    return _registerView;
    
}

@end
