//
//  AddNewGroupVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AddNewGroupVC.h"
#import "AddGroupPointVC.h"
#import "AFViewModel.h"
@interface AddNewGroupVC ()
@property(nonatomic,strong)UITextField * inputText;
@end

@implementation AddNewGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.inputText];
     [self setNavBackButtonImage:ImageNamed(@"back")];
    self.title=@"新增分组";
    [self createRightItem];
    

}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

-(void)addNewGroup{
    [self goToAddNetPoint];
}

#pragma mark 创建自定义分组
-(void)goToAddNetPoint{
    
    if ([self.inputText.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请输入分组名字" withSecond:HudDelay];
        return ;
    }
    
    MJWeakSelf
        AFViewModel * afViewModel =[AFViewModel new];
        [afViewModel setBlockWithReturnBlock:^(id returnValue) {
            
            NSString  *code =[NSString stringWithFormat:@"%@",returnValue[@"code"]];
            if ([code isEqualToString:@"1"]) {
                
                AddGroupPointVC * adVC =[[AddGroupPointVC alloc]init];
                adVC.customId=returnValue[@"data"];
                adVC.gn = self.fzgn;
                adVC.type = self.type;
                [weakSelf.navigationController pushViewController:adVC animated:YES];
            }
            
            
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        
        [afViewModel requestAddNewGroup:self.inputText.text withFzgn:self.fzgn withFid:self.fid];

}


#pragma mark 输入框懒加载
-(UITextField *)inputText{
    
    if (!_inputText) {
        _inputText =[[UITextField alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT+10, SCREEN_WIDTH, 44)];
        _inputText.backgroundColor=[UIColor whiteColor];
        _inputText.borderStyle=UITextBorderStyleNone;
        _inputText.placeholder =@"  请输入分组名称";
    }
    
    return _inputText;
    
}

@end
