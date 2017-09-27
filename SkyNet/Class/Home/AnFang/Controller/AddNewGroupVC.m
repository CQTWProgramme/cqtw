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
    

}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
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
                [self.navigationController pushViewController:adVC animated:YES];
                
            }
            
            
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        
        [afViewModel requestAddNewGroup:self.inputText.text];

}


#pragma mark 输入框懒加载
-(UITextField *)inputText{
    
    if (!_inputText) {
        _inputText =[[UITextField alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT+10, SCREEN_WIDTH, 44)];
        _inputText.backgroundColor=[UIColor whiteColor];
        _inputText.borderStyle=UITextBorderStyleNone;
        _inputText.placeholder =@"  常用安防";
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
