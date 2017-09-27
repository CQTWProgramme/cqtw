//
//  RegisterViewModel.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/5.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RegisterViewModel.h"
#import "CusMD5.h"
@implementation RegisterViewModel

#pragma mark 用户注册
-(void)requestRegisterUser:(NSString *)dlzh
                      dlmm:(NSString *)dlmm
                      code:(NSString *)code
{
    
    NSString * mdDlmm=[CusMD5 md5String:[NSString stringWithFormat:@"%@:%@",dlzh,dlmm]];
    NSDictionary * param =@{@"dlzh": dlzh,
                            @"dlmm": [mdDlmm lowercaseString],
                            @"code": code
                            };
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest(USER_REGISTER).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSString * respCode =responseObject[@"mobileRespHeader"][@"respCode"];
//        if (![respCode isEqualToString:@"2000"]) {
//            
//            super.failureBlock(@"请求失败");
//            
//        }else{
//            
//            
//            super.returnBlock(nil);
//        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        super.failureBlock();
    }];
    
    
}


#pragma mark 获取验证码
-(void)requestRegisterCode:(NSString *)phone
            countdownLabel:(UILabel *)countdownLabel{
    
    if (![XWRegularExpression isPhoneNumber:phone]) {
        
        [STTextHudTool showErrorText:@"请输入正确的手机号码" withSecond:HudDelay];
        
        return ;
    }

    [STTextHudTool loadingWithTitle:@"获取验证码中..."];
       
    [self messageCodeCountDown:countdownLabel];
    
    NSDictionary * param =@{@"dlzh": phone};
    
    [[AFNetAPIClient sharedJsonClient].setRequest(USER_REGISTER_CODE).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
        [STTextHudTool hideSTHud];
        [STTextHudTool showSuccessText:@"发送成功,请注意查收" withSecond:HudDelay];
        
        }else{
            
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"发送失败" withSecond:HudDelay];
            
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"发送失败" withSecond:HudDelay];
    }];


}


#pragma mark 短信验证码倒计时
-(void)messageCodeCountDown:(UILabel *)countdownLabel{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
    });
        __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                countdownLabel.text=@"重新发送";
                countdownLabel.backgroundColor=[UIColor clearColor];
                countdownLabel.textColor=NAVI_COLOR;
                countdownLabel.userInteractionEnabled = YES;
                
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 59;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                countdownLabel.text=[NSString stringWithFormat:@"%@秒",strTime];
                countdownLabel.backgroundColor=[UIColor clearColor];
                countdownLabel.textColor=[UIColor grayColor];
                countdownLabel.textAlignment=NSTextAlignmentRight;
                countdownLabel.userInteractionEnabled = NO;
                
                
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark  验证注册信息
-(BOOL)checkRegiserInfoPhone:(NSString *)phone
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password
               checkPassword:(NSString *)checkPassword
{
    
    
    if ([phone isEqualToString:@""]) {
        
       [STTextHudTool showErrorText:@"请输入手机号码" withSecond:HudDelay];
        
        return NO;
    }
    
    if (![XWRegularExpression isPhoneNumber:phone]) {
        
        [STTextHudTool showErrorText:@"请输入正确的手机号码" withSecond:HudDelay];
        
        return NO;
    }
    
    
    if ([msgCode isEqualToString:@""]) {
        
        [STTextHudTool showErrorText:@"请输入验证码" withSecond:HudDelay];
        
        return NO;
    }
    
    if ([password isEqualToString:@""]) {
        
        [STTextHudTool showErrorText:@"请输入密码" withSecond:HudDelay];
        
        return NO;
    }
    
    
    if (![checkPassword isEqualToString:password]) {
        
        [STTextHudTool showErrorText:@"两次输入密码不一致" withSecond:HudDelay];
        
        return NO;

    }
    
    return YES;
}
@end
