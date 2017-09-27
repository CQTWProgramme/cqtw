//
//  RegisterView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RegisterView.h"
#import "RegisterCell.h"
#import "RegisterViewModel.h"

#define MARGIN 10
#define PADDING 7
#define LABEL_W 70
#define CONTROL_H 30
#define LINE_H 0.5

@implementation RegisterView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=BACKGROUND_COLOR;
        [self initUI];
        
    }
    
    return self;
    
}

#pragma mark 初始化UI
-(void)initUI{

    _mainScorllView=[UIScrollView new];
    [self addSubview:_mainScorllView];
    _mainScorllView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
#pragma mark seciton 1
    
    UIView * sectionOneView =[UIView new];
    sectionOneView.backgroundColor=[UIColor whiteColor];
    [_mainScorllView addSubview:sectionOneView];
    sectionOneView.sd_layout
    .leftEqualToView(_mainScorllView)
    .topEqualToView(_mainScorllView)
    .rightEqualToView(_mainScorllView)
    .heightIs(4*(2*PADDING+CONTROL_H)+4*LINE_H);
    
    
    
//手机号
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"手机号";
    phoneLabel.textAlignment=NSTextAlignmentLeft;
    phoneLabel.font=[UIFont systemFontOfSize:14];
    phoneLabel.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:phoneLabel];
    
    phoneLabel.sd_layout
    .leftSpaceToView(sectionOneView, 10)
    .topSpaceToView(sectionOneView, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _phoneText=[UITextField new];
    _phoneText.placeholder=@"请输入手机号";
    [_phoneText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _phoneText.clearButtonMode=UITextFieldViewModeAlways;
    _phoneText.font=[UIFont systemFontOfSize:14];
    _phoneText.keyboardType=UITextBorderStyleNone;
    _phoneText.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:_phoneText];
    _phoneText.sd_layout
    .leftSpaceToView(phoneLabel,MARGIN)
    .centerYEqualToView(phoneLabel)
    .rightSpaceToView(sectionOneView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line1 =[UIView new];
    line1.backgroundColor=BACKGROUND_COLOR;
    [sectionOneView addSubview:line1];
    line1.sd_layout
    .leftEqualToView(sectionOneView)
    .topSpaceToView(_phoneText, PADDING)
    .rightEqualToView(sectionOneView)
    .heightIs(LINE_H);
    


//验证码
    
    UILabel * codeLabel =[UILabel new];
    codeLabel.text=@"验证码";
    codeLabel.textAlignment=NSTextAlignmentLeft;
    codeLabel.font=[UIFont systemFontOfSize:14];
    codeLabel.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:codeLabel];
    
    codeLabel.sd_layout
    .leftSpaceToView(sectionOneView, 10)
    .topSpaceToView(line1, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _codeText=[UITextField new];
    _codeText.placeholder=@"请输入验证码";
    [_codeText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _codeText.clearButtonMode=UITextFieldViewModeAlways;
    _codeText.keyboardType=UITextBorderStyleNone;
    _codeText.font=[UIFont systemFontOfSize:14];
    _codeText.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:_codeText];
    _codeText.sd_layout
    .leftSpaceToView(codeLabel,MARGIN)
    .centerYEqualToView(codeLabel)
    .rightSpaceToView(sectionOneView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * codeRightView =[UIView new];
    codeRightView.backgroundColor=[UIColor clearColor];
    codeRightView.frame=CGRectMake(0, 0, 90, CONTROL_H);
   _codeBtn=[UILabel new];
    _codeBtn.backgroundColor=[UIColor clearColor];
    _codeBtn.text=@"获取验证码";
    _codeBtn.font=[UIFont systemFontOfSize:14];
    _codeBtn.textColor=NAVI_COLOR;
    _codeBtn.textAlignment=NSTextAlignmentRight;
    _codeBtn.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendMsg:)];
    [_codeBtn addGestureRecognizer:labelTapGestureRecognizer];
    [codeRightView addSubview:_codeBtn];
    _codeBtn.sd_layout
    .leftSpaceToView(codeRightView, 0)
    .centerYEqualToView(codeRightView)
    .rightSpaceToView(codeRightView, 5)
    .heightIs(CONTROL_H);
    _codeText.rightView=codeRightView;
    _codeText.rightViewMode=UITextFieldViewModeAlways;
    
    
    
    UIView * line2 =[UIView new];
    line2.backgroundColor=BACKGROUND_COLOR;
    [sectionOneView addSubview:line2];
    line2.sd_layout
    .leftEqualToView(sectionOneView)
    .topSpaceToView(_codeText, PADDING)
    .rightEqualToView(sectionOneView)
    .heightIs(LINE_H);

//密码
    UILabel * passwordLabel =[UILabel new];
    passwordLabel.text=@"密码";
    passwordLabel.textAlignment=NSTextAlignmentLeft;
    passwordLabel.font=[UIFont systemFontOfSize:14];
    passwordLabel.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:passwordLabel];
    
    passwordLabel.sd_layout
    .leftSpaceToView(sectionOneView, 10)
    .topSpaceToView(line2, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _passwordText=[UITextField new];
    _passwordText.placeholder=@"请输入密码";
    [_passwordText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _passwordText.clearButtonMode=UITextFieldViewModeAlways;
    _passwordText.keyboardType=UITextBorderStyleNone;
    _passwordText.font=[UIFont systemFontOfSize:14];
    _passwordText.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:_passwordText];
    _passwordText.sd_layout
    .leftSpaceToView(passwordLabel,MARGIN)
    .centerYEqualToView(passwordLabel)
    .rightSpaceToView(sectionOneView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line3 =[UIView new];
    line3.backgroundColor=BACKGROUND_COLOR;
    [sectionOneView addSubview:line3];
    line3.sd_layout
    .leftEqualToView(sectionOneView)
    .topSpaceToView(_passwordText, PADDING)
    .rightEqualToView(sectionOneView)
    .heightIs(LINE_H);


//确认密码
    
    UILabel * checkLabel =[UILabel new];
    checkLabel.text=@"确认密码";
    checkLabel.textAlignment=NSTextAlignmentLeft;
    checkLabel.font=[UIFont systemFontOfSize:14];
    checkLabel.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:checkLabel];
    
    checkLabel.sd_layout
    .leftSpaceToView(sectionOneView, 10)
    .topSpaceToView(line3, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _checkText=[UITextField new];
    _checkText.placeholder=@"请再次输入密码";
    [_checkText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _checkText.clearButtonMode=UITextFieldViewModeAlways;
    _checkText.keyboardType=UITextBorderStyleNone;
    _checkText.font=[UIFont systemFontOfSize:14];
    _checkText.textColor=[UIColor darkGrayColor];
    [sectionOneView addSubview:_checkText];
    _checkText.sd_layout
    .leftSpaceToView(checkLabel,MARGIN)
    .centerYEqualToView(checkLabel)
    .rightSpaceToView(sectionOneView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line4 =[UIView new];
    line4.backgroundColor=BACKGROUND_COLOR;
    [sectionOneView addSubview:line4];
    line4.sd_layout
    .leftEqualToView(sectionOneView)
    .topSpaceToView(_checkText, PADDING)
    .rightEqualToView(sectionOneView)
    .heightIs(LINE_H);



#pragma mark seciton 2
    
    UIView * sectionTwoView =[UIView new];
    sectionTwoView.backgroundColor=[UIColor whiteColor];
    [_mainScorllView addSubview:sectionTwoView];
    sectionTwoView.sd_layout
    .leftEqualToView(_mainScorllView)
    .topSpaceToView(sectionOneView, 2*MARGIN)
    .rightEqualToView(_mainScorllView)
    .heightIs(3*(2*PADDING+CONTROL_H)+4*LINE_H);
    
    UIView * line5 =[UIView new];
    line5.backgroundColor=BACKGROUND_COLOR;
    [sectionTwoView addSubview:line5];
    line5.sd_layout
    .leftEqualToView(sectionTwoView)
    .topSpaceToView(sectionTwoView, 0)
    .rightEqualToView(sectionTwoView)
    .heightIs(LINE_H);

    
//姓名
    UILabel * nicknameLabel =[UILabel new];
    nicknameLabel.text=@"姓名";
    nicknameLabel.textAlignment=NSTextAlignmentLeft;
    nicknameLabel.font=[UIFont systemFontOfSize:14];
    nicknameLabel.textColor=[UIColor darkGrayColor];
    [sectionTwoView addSubview:nicknameLabel];
    
    nicknameLabel.sd_layout
    .leftSpaceToView(sectionTwoView, 10)
    .topSpaceToView(line5, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _nicknameText=[UITextField new];
    _nicknameText.placeholder=@"请输入你的姓名";
    [_nicknameText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _nicknameText.clearButtonMode=UITextFieldViewModeAlways;
    _nicknameText.keyboardType=UITextBorderStyleNone;
    _nicknameText.font=[UIFont systemFontOfSize:14];
    _nicknameText.textColor=[UIColor darkGrayColor];
    [sectionTwoView addSubview:_nicknameText];
    _nicknameText.sd_layout
    .leftSpaceToView(nicknameLabel,MARGIN)
    .centerYEqualToView(nicknameLabel)
    .rightSpaceToView(sectionTwoView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line6 =[UIView new];
    line6.backgroundColor=BACKGROUND_COLOR;
    [sectionTwoView addSubview:line6];
    line6.sd_layout
    .leftEqualToView(sectionTwoView)
    .topSpaceToView(_nicknameText, PADDING)
    .rightEqualToView(sectionTwoView)
    .heightIs(LINE_H);

//性别
    
    UILabel * sexLabel =[UILabel new];
    sexLabel.text=@"性别";
    sexLabel.textAlignment=NSTextAlignmentLeft;
    sexLabel.font=[UIFont systemFontOfSize:14];
    sexLabel.textColor=[UIColor darkGrayColor];
    [sectionTwoView addSubview:sexLabel];
    
    sexLabel.sd_layout
    .leftSpaceToView(sectionTwoView, 10)
    .topSpaceToView(line6, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _sexBtn=[UIButton new];
    _sexBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_sexBtn setTitle:@"请选择性别" forState:UIControlStateNormal];
    [_sexBtn setTitleColor:RGBA(187, 186, 194, 1) forState:UIControlStateNormal];
    _sexBtn.backgroundColor=[UIColor clearColor];
    _sexBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _sexBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_sexBtn addTarget:self action:@selector(sexSelect) forControlEvents:UIControlEventTouchUpInside];
    [sectionTwoView addSubview:_sexBtn];
    _sexBtn.sd_layout
    .leftSpaceToView(sexLabel,MARGIN)
    .centerYEqualToView(sexLabel)
    .rightSpaceToView(sectionTwoView, 30)
    .heightIs(CONTROL_H);
    
    UIImage * image=ImageNamed(@"more");
    UIImageView * imageView=[UIImageView new];
    imageView.image=image;
    [sectionTwoView addSubview:imageView];
    imageView.sd_layout
    .centerYEqualToView(_sexBtn)
    .leftSpaceToView(_sexBtn, 10)
    .widthIs(image.size.width)
    .heightIs(image.size.height);
    
    
    
    
    UIView * line7 =[UIView new];
    line7.backgroundColor=BACKGROUND_COLOR;
    [sectionTwoView addSubview:line7];
    line7.sd_layout
    .leftEqualToView(sectionTwoView)
    .topSpaceToView(_sexBtn, PADDING)
    .rightEqualToView(sectionTwoView)
    .heightIs(LINE_H);

//个性签名
    UILabel * signLabel =[UILabel new];
    signLabel.text=@"个性签名";
    signLabel.textAlignment=NSTextAlignmentLeft;
    signLabel.font=[UIFont systemFontOfSize:14];
    signLabel.textColor=[UIColor darkGrayColor];
    [sectionTwoView addSubview:signLabel];
    
    signLabel.sd_layout
    .leftSpaceToView(sectionTwoView, 10)
    .topSpaceToView(line7, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _signText=[UITextField new];
    _signText.placeholder=@"请输入您的签名";
    [_signText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _signText.clearButtonMode=UITextFieldViewModeAlways;
    _signText.keyboardType=UITextBorderStyleNone;
    _signText.font=[UIFont systemFontOfSize:14];
    _signText.textColor=[UIColor darkGrayColor];
    [sectionTwoView addSubview:_signText];
    _signText.sd_layout
    .leftSpaceToView(signLabel,MARGIN)
    .centerYEqualToView(signLabel)
    .rightSpaceToView(sectionTwoView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line8 =[UIView new];
    line8.backgroundColor=BACKGROUND_COLOR;
    [sectionTwoView addSubview:line8];
    line8.sd_layout
    .leftEqualToView(sectionTwoView)
    .topSpaceToView(_signText, PADDING)
    .rightEqualToView(sectionTwoView)
    .heightIs(LINE_H);

    UIButton * registerBtn =[UIButton new];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor=NAVI_COLOR;
    registerBtn.layer.masksToBounds=YES;
    [registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [_mainScorllView addSubview:registerBtn];
    registerBtn.sd_layout
    .topSpaceToView(sectionTwoView, 2*MARGIN)
    .leftSpaceToView(_mainScorllView, 2*MARGIN)
    .rightSpaceToView(_mainScorllView, 2*MARGIN)
    .heightIs(CONTROL_H+2*PADDING);
    registerBtn.sd_cornerRadius=@(CONTROL_H/2+PADDING);
    
    [_mainScorllView setupAutoContentSizeWithBottomView:registerBtn bottomMargin:PADDING];
    
    
    

}




#pragma mark 发送验证码
-(void)sendMsg:(UITapGestureRecognizer *)recognizer{
    
    UILabel *countdownLabel=(UILabel*)recognizer.view;
    
    if (self.delegate) {
        [self.delegate getMessageCodeWithPhone:_phoneText.text showLabel:countdownLabel];
    }
    
}



#pragma mark 性别选择
-(void)sexSelect{
    
    DefineWeakSelf;
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"选择性别" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
        
        if (buttonIndex==1) {
            [weakSelf.sexBtn setTitle:@"男" forState:UIControlStateNormal];
            [weakSelf.sexBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }else if (buttonIndex==2){
            
            [weakSelf.sexBtn setTitle:@"女" forState:UIControlStateNormal];
            [weakSelf.sexBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        
    } otherButtonTitles:@"男", @"女", nil];

     [actionSheet show];
}


#pragma mark 注册
-(void)registerUser{
    
    RegisterViewModel * viewModel =[RegisterViewModel new];
    BOOL isValid=[viewModel checkRegiserInfoPhone:_phoneText.text msgCode:_codeText.text password:_passwordText.text checkPassword:_checkText.text];
    if (isValid&&self.delegate) {
        
        [self.delegate registerUserWithPhone:_phoneText.text msgCode:_codeText.text password:_passwordText.text];
    }
    
}




@end
