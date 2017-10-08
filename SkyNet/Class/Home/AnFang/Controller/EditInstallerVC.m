//
//  EditInstallerVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/8.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EditInstallerVC.h"

@interface EditInstallerVC ()
@property(nonatomic,strong)UITextField * inputText;
@end

@implementation EditInstallerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.inputText];
    [self setNavBackButtonTitle:@"取消"];
    self.title=@"编辑安装人员";
    [self createRightItem];
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

- (void)saveAction {
    
}

#pragma mark 输入框懒加载
-(UITextField *)inputText{
    
    if (!_inputText) {
        _inputText =[[UITextField alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT+10, SCREEN_WIDTH, 44)];
        _inputText.backgroundColor=[UIColor whiteColor];
        _inputText.borderStyle=UITextBorderStyleNone;
        _inputText.placeholder =@"  请输入安装人员姓名";
    }
    
    return _inputText;
    
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
