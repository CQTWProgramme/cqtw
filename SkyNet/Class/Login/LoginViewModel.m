//
//  LoginViewModel.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LoginViewModel.h"
#import "CusMD5.h"
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
                            @"dlxx": @"1"
                            };
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest(USER_LGOIN).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"登录成功" withSecond:HudDelay];
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
@end
