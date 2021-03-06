//
//  LoginViewModel.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LoginViewModel.h"
#import "CusMD5.h"
#import "UserInfo.h"
@implementation LoginViewModel

#pragma mark 验证登录信息
-(BOOL)checkLoginInfoPhone:(NSString *)phone
                  password:(NSString *)password
{
    
    if ([phone isEqualToString:@""]) {
        
        [STTextHudTool showErrorText:@"请输入用户名" withSecond:HudDelay];
        
        return NO;
    }
    
    
    if ([password isEqualToString:@""]) {
        
        [STTextHudTool showErrorText:@"请输入密码" withSecond:HudDelay];
        
        return NO;
    }
    
    return YES;
    
}

#pragma mark 请求登录
-(void)requestLoginWithUserName:(NSString *)userName
                       password:(NSString *)password
{
    
     [STTextHudTool loadingWithTitle:@"登录中..."];
    NSString * mdDlmm=[CusMD5 md5String:[NSString stringWithFormat:@"%@:%@",userName,password]];
    NSDictionary * param =@{@"dlzh": userName,
                            @"dlmm": [mdDlmm uppercaseString],
                            @"dllx": @"1"
                            };
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest(USER_LGOIN).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool hideSTHud];
            [STTextHudTool showSuccessText:@"登录成功" withSecond:HudDelay];
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [ClientTool saveToken:responseObject[@"message"]];
            UserInfo *shareInstance = [UserInfo shareInstance];
            shareInstance = [UserInfo mj_objectWithKeyValues:responseObject[@"data"]];
            super.returnBlock(responseObject[@"message"]);
        }else{
            
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"登录失败" withSecond:HudDelay];
            
    }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"登录失败" withSecond:HudDelay];
       
    }];

}

-(void)updatePasswordWithOldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword {
    [STTextHudTool loadingWithTitle:@"修改中..."];
    NSString * oldDlmm=[CusMD5 md5String:oldPassword];
    NSString * newDlmm=[CusMD5 md5String:newPassword];
    NSDictionary * param =@{@"oldDlmm": oldDlmm,
                            @"newDlmm": newDlmm
                            };
    [[AFNetAPIClient sharedJsonClient].setRequest(UPDATE_PWD).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        super.returnBlock(responseObject[@"message"]);
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"操作失败" withSecond:HudDelay];
        
    }];
}

-(void)updateUserInfoWithYhxm:(NSString *)yhxm
                         yhxb:(NSString *)yhxb
                enablepushapp:(NSString *)enablepushapp
                           bz:(NSString *)bz {
    [STTextHudTool loadingWithTitle:@"保存中..."];
    NSDictionary * param =@{@"yhxm": yhxm,
                            @"yhxb": yhxb,
                            @"enablepushapp": enablepushapp,
                            @"bz": bz
                            };
    [[AFNetAPIClient sharedJsonClient].setRequest(UPDATE_USER).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        super.returnBlock(responseObject);
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"操作失败" withSecond:HudDelay];
        
    }];
}
@end
