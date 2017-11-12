//
//  SaveUserHouseVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "SaveUserHouseVC.h"
#import "ACViewModel.h"

@interface SaveUserHouseVC ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UITextField *markTextField;

@end

@implementation SaveUserHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.title = @"房屋认证";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.nameLabel.text = self.name;
    self.addressLabel.text = self.address;
    
    
}
- (IBAction)typeSelectAction:(id)sender {
    DefineWeakSelf;
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"选择住户类型" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
        
        if (buttonIndex==1) {
            weakSelf.typeLabel.text = @"业主";
        }else if (buttonIndex==2){
            
            weakSelf.typeLabel.text = @"家庭成员";
        }else if (buttonIndex == 3) {
             weakSelf.typeLabel.text = @"租赁户";
        }
        
    } otherButtonTitles:@"业主", @"家庭成员", @"租赁户",nil];
    
    [actionSheet show];
}

- (IBAction)submitAction:(id)sender {
    if ([self.typeLabel.text isEqualToString:@"类型"]) {
        [STTextHudTool showErrorText:@"请选择住户类型"];
        return;
    }
    NSInteger type = 0;
    if ([self.typeLabel.text isEqualToString:@"业主"]) {
        type = 1;
    }else if ([self.typeLabel.text isEqualToString:@"家庭成员"]) {
        type = 2;
    }else if ([self.typeLabel.text isEqualToString:@"租赁户"]) {
        type = 3;
    }
    
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString *code = returnValue;
        if (code.integerValue == 1) {
            [STTextHudTool showSuccessText:@"提交审核成功"];
            UIViewController *viewCtl = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:viewCtl animated:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [viewModel acSaveUserHouseWithAreasId:self.areasId type:type ly:1 bz:self.markTextField.text];
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
