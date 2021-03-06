//
//  MyInfo.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MyInfo.h"
#import "LoginViewModel.h"
#import "UserInfo.h"
#define MARGIN 10
#define PADDING 7
#define LABEL_W 70
#define CONTROL_H 30
#define LINE_H 0.5
@interface MyInfo ()
@property(nonatomic,strong) UITextField * phoneText;
@property(nonatomic,strong) UITextField * nicknameText;
@property(nonatomic,strong) UIButton    * sexBtn;
@property(nonatomic,strong) UITextField * signText;
@property(nonatomic,copy) NSString *yhxb;
@property(nonatomic,copy) NSString *enablepushapp;
@end

@implementation MyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的资料";
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
    LoginViewModel *viewModel = [LoginViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showSuccessText:@"修改成功"];
            [UserInfo shareInstance].yhxb = [self.yhxb integerValue];
            [UserInfo shareInstance].bz = self.signText.text;
            [UserInfo shareInstance].yhxm = self.nicknameText.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfoChangeSuccess" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"操作失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"操作失败"];
    }];
    [viewModel updateUserInfoWithYhxm:self.nicknameText.text yhxb:self.yhxb enablepushapp:self.enablepushapp bz:self.signText.text];
}

-(void)createUI{
    
    self.enablepushapp = [NSString stringWithFormat:@"%@",@([UserInfo shareInstance].enablepushapp)];
    
    UIScrollView * scollView=[UIScrollView new];
    [self.view addSubview:scollView];
    scollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"手机号";
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
    _phoneText.placeholder=@"请输入手机号";
    [_phoneText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _phoneText.clearButtonMode=UITextFieldViewModeAlways;
    _phoneText.font=[UIFont systemFontOfSize:14];
    _phoneText.keyboardType=UITextBorderStyleNone;
    _phoneText.textColor=[UIColor darkGrayColor];
    _phoneText.text = [UserInfo shareInstance].dlzh;
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
    nicknameLabel.text=@"姓名";
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
    _nicknameText.placeholder=@"请输入你的姓名";
    [_nicknameText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _nicknameText.clearButtonMode=UITextFieldViewModeAlways;
    _nicknameText.keyboardType=UITextBorderStyleNone;
    _nicknameText.font=[UIFont systemFontOfSize:14];
    _nicknameText.textColor=[UIColor darkGrayColor];
    _nicknameText.text = [UserInfo shareInstance].yhxm;
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
    
    //性别
    UILabel * sexLabel =[UILabel new];
    sexLabel.text=@"性别";
    sexLabel.textAlignment=NSTextAlignmentLeft;
    sexLabel.font=[UIFont systemFontOfSize:14];
    sexLabel.textColor=[UIColor darkGrayColor];
    [scollView addSubview:sexLabel];
    
    sexLabel.sd_layout
    .leftSpaceToView(scollView, 10)
    .topSpaceToView(line2, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _sexBtn=[UIButton new];
    _sexBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    if ([UserInfo shareInstance].yhxb == 0) {
        [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
    }else {
        [_sexBtn setTitle:@"女" forState:UIControlStateNormal];
    }
    self.yhxb = [NSString stringWithFormat:@"%@",@([UserInfo shareInstance].yhxb)];
    [_sexBtn setTitleColor:RGBA(187, 186, 194, 1) forState:UIControlStateNormal];
    _sexBtn.backgroundColor=[UIColor clearColor];
    _sexBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _sexBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_sexBtn addTarget:self action:@selector(sexSelect) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:_sexBtn];
    _sexBtn.sd_layout
    .leftSpaceToView(sexLabel,MARGIN)
    .centerYEqualToView(sexLabel)
    .rightSpaceToView(scollView, 30)
    .heightIs(CONTROL_H);
    
    UIImage * image=ImageNamed(@"more");
    UIImageView * imageView=[UIImageView new];
    imageView.image=image;
    [scollView addSubview:imageView];
    imageView.sd_layout
    .centerYEqualToView(_sexBtn)
    .leftSpaceToView(_sexBtn, 10)
    .widthIs(image.size.width)
    .heightIs(image.size.height);
    
    
    
    
    UIView * line3 =[UIView new];
    line3.backgroundColor=BACKGROUND_COLOR;
    [scollView addSubview:line3];
    line3.sd_layout
    .leftEqualToView(scollView)
    .topSpaceToView(_sexBtn, PADDING)
    .rightEqualToView(scollView)
    .heightIs(LINE_H);
    
    //个性签名
    UILabel * signLabel =[UILabel new];
    signLabel.text=@"个性签名";
    signLabel.textAlignment=NSTextAlignmentLeft;
    signLabel.font=[UIFont systemFontOfSize:14];
    signLabel.textColor=[UIColor darkGrayColor];
    [scollView addSubview:signLabel];
    
    signLabel.sd_layout
    .leftSpaceToView(scollView, 10)
    .topSpaceToView(line3, PADDING)
    .widthIs(LABEL_W)
    .heightIs(CONTROL_H);
    
    _signText=[UITextField new];
    _signText.placeholder=@"请填写个性签名";
    [_signText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _signText.clearButtonMode=UITextFieldViewModeAlways;
    _signText.keyboardType=UITextBorderStyleNone;
    _signText.font=[UIFont systemFontOfSize:14];
    _signText.textColor=[UIColor darkGrayColor];
    _signText.text = [UserInfo shareInstance].bz;
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

- (void)sexSelect {
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"选择性别" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
        
        if (buttonIndex==1) {
            [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
            self.yhxb = @"0";
        }else if (buttonIndex==2){
            [_sexBtn setTitle:@"女" forState:UIControlStateNormal];
            self.yhxb = @"1";
        }
    } otherButtonTitles:@"男", @"女",nil];
    
    [actionSheet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
