//
//  RegisterView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RegisterViewDelegate <NSObject>

//获取验证码
-(void)getMessageCodeWithPhone:(NSString *)phone
                     showLabel:(UILabel *)showlabel;

//注册
-(void)registerUserWithPhone:(NSString *)phone
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password;

@end



@interface RegisterView : UIView
@property(nonatomic,strong) UIScrollView   * mainScorllView;
@property(nonatomic,strong) UITextField * phoneText;
@property(nonatomic,strong) UITextField * codeText;
@property(nonatomic,strong) UITextField * passwordText;
@property(nonatomic,strong) UITextField * checkText;
@property(nonatomic,strong) UITextField * nicknameText;
@property(nonatomic,strong) UIButton    * sexBtn;
@property(nonatomic,strong) UITextField * signText;
@property(nonatomic,strong) UILabel  * codeBtn;
@property(nonatomic,strong) id<RegisterViewDelegate>delegate;
@end


