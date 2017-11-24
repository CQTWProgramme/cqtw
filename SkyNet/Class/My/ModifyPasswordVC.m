//
//  ModifyPasswordVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ModifyPasswordVC.h"
#import "LoginViewModel.h"

#define MARGIN 10
#define PADDING 7
#define LABEL_W 70
#define CONTROL_H 30
#define LINE_H 0.5

@interface ModifyPasswordVC ()
@property(nonatomic,strong) UITextField * phoneText;
@property(nonatomic,strong) UITextField * nicknameText;
@property(nonatomic,strong) UITextField * signText;
@end

@implementation ModifyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRightItem];
    [self createUI];
}

-(void)createRightItem{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveInfoAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)saveInfoAction {
    if ([self.phoneText.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请填写原密码"];
        return;
    }
    if ([self.nicknameText.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请填写新密码"];
        return;
    }
    if (![self.nicknameText.text isEqualToString:self.signText.text]) {
        [STTextHudTool showErrorText:@"两次新密码不一致"];
        return;
    }
    LoginViewModel *viewModel = [LoginViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool hideSTHud];
            [STTextHudTool showSuccessText:@"密码修改成功" withSecond:HudDelay];
            [[NSUserDefaults standardUserDefaults] setObject:self.signText.text forKey:@"password"];
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"密码修改失败" withSecond:HudDelay];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel updatePasswordWithOldPassword:self.phoneText.text newPassword:self.nicknameText.text];
}

-(void)createUI{
    
    UIScrollView * scollView=[UIScrollView new];
    [self.view addSubview:scollView];
    scollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"原密码";
    phoneLabel.textAlignment=NSTextAlignmentLeft;
    phoneLabel.font=[UIFont systemFontOfSize:14];
    phoneLabel.textColor=[UIColor darkGrayColor];
    [scollView addSubview:phoneLabel];
    
    phoneLabel.sd_layout
    .leftSpaceToView(scollView, 10)
    .topSpaceToView(scollView, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    
    _phoneText=[UITextField new];
    _phoneText.placeholder=@"请输入原密码";
    [_phoneText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _phoneText.clearButtonMode=UITextFieldViewModeAlways;
    _phoneText.font=[UIFont systemFontOfSize:14];
    _phoneText.keyboardType=UITextBorderStyleNone;
    _phoneText.textColor=[UIColor darkGrayColor];
    [scollView addSubview:_phoneText];
    _phoneText.sd_layout
    .leftSpaceToView(phoneLabel,MARGIN)
    .centerYEqualToView(phoneLabel)
    .rightSpaceToView(scollView, MARGIN)
    .heightIs(CONTROL_H);
    
    
    UIView * line1 =[UIView new];
    line1.backgroundColor=BACKGROUND_COLOR;
    [scollView addSubview:line1];
    line1.sd_layout
    .leftEqualToView(scollView)
    .topSpaceToView(_phoneText, PADDING)
    .rightEqualToView(scollView)
    .heightIs(LINE_H);
    
    
    UILabel * nicknameLabel =[UILabel new];
    nicknameLabel.text=@"新密码";
    nicknameLabel.textAlignment=NSTextAlignmentLeft;
    nicknameLabel.font=[UIFont systemFontOfSize:14];
    nicknameLabel.textColor=[UIColor darkGrayColor];
    [scollView addSubview:nicknameLabel];
    
    nicknameLabel.sd_layout
    .leftSpaceToView(scollView, 10)
    .topSpaceToView(line1, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _nicknameText=[UITextField new];
    _nicknameText.placeholder=@"请输入新密码";
    [_nicknameText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _nicknameText.clearButtonMode=UITextFieldViewModeAlways;
    _nicknameText.keyboardType=UITextBorderStyleNone;
    _nicknameText.font=[UIFont systemFontOfSize:14];
    _nicknameText.textColor=[UIColor darkGrayColor];
    [scollView addSubview:_nicknameText];
    _nicknameText.sd_layout
    .leftSpaceToView(nicknameLabel,MARGIN)
    .centerYEqualToView(nicknameLabel)
    .rightSpaceToView(scollView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line2 =[UIView new];
    line2.backgroundColor=BACKGROUND_COLOR;
    [scollView addSubview:line2];
    line2.sd_layout
    .leftEqualToView(scollView)
    .topSpaceToView(_nicknameText, PADDING)
    .rightEqualToView(scollView)
    .heightIs(LINE_H);
    
    //个性签名
    UILabel * signLabel =[UILabel new];
    signLabel.text=@"确认密码";
    signLabel.textAlignment=NSTextAlignmentLeft;
    signLabel.font=[UIFont systemFontOfSize:14];
    signLabel.textColor=[UIColor darkGrayColor];
    [scollView addSubview:signLabel];
    
    signLabel.sd_layout
    .leftSpaceToView(scollView, 10)
    .topSpaceToView(line2, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _signText=[UITextField new];
    _signText.placeholder=@"请再次输入密码";
    [_signText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _signText.clearButtonMode=UITextFieldViewModeAlways;
    _signText.keyboardType=UITextBorderStyleNone;
    _signText.font=[UIFont systemFontOfSize:14];
    _signText.textColor=[UIColor darkGrayColor];
    [scollView addSubview:_signText];
    _signText.sd_layout
    .leftSpaceToView(signLabel,MARGIN)
    .centerYEqualToView(signLabel)
    .rightSpaceToView(scollView, MARGIN)
    .heightIs(CONTROL_H);
    
    UIView * line4 =[UIView new];
    line4.backgroundColor=BACKGROUND_COLOR;
    [scollView addSubview:line4];
    line4.sd_layout
    .leftEqualToView(scollView)
    .topSpaceToView(_signText, PADDING)
    .rightEqualToView(scollView)
    .heightIs(LINE_H);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
