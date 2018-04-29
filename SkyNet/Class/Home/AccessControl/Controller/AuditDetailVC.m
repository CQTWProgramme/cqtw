//
//  AuditDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "AuditDetailVC.h"
#import "ACViewModel.h"
#import "AuditDetailModel.h"
@interface AuditDetailVC ()
@property (nonatomic, strong)AuditDetailModel *detailModel;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, weak) UILabel *label4;
@property (nonatomic, weak) UILabel *label5;
@property (nonatomic, weak) UILabel *label6;
@property (nonatomic, weak) UILabel *label7;
@property (nonatomic, weak) UITextField *textField;
@end

@implementation AuditDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智能人脸门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    MJWeakSelf
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            weakSelf.detailModel = [AuditDetailModel mj_objectWithKeyValues:returnValue[@"data"]];
            [weakSelf resetUI];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"加载失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"加载失败"];
    }];
    
    if (self.model.userHouseId == nil) {
        self.model.userHouseId = @"";
    }
    [viewModel getApplyUserInfoDataWithUserHouseId:self.model.userHouseId];
}

- (void)resetUI {
    self.label1.text = self.detailModel.name;
    self.label2.text = self.detailModel.sex;
    self.label3.text = self.detailModel.cardnum;
    self.label4.text = self.detailModel.phone;
    self.label6.text = self.detailModel.applyTime;
    self.label7.text = self.detailModel.bz;
}

- (void)initUI {
    UIScrollView *backScrollerView = [[UIScrollView alloc] init];
    backScrollerView.scrollEnabled = YES;
    backScrollerView.backgroundColor = BACKGROUND_COLOR;
    backScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    backScrollerView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:backScrollerView];
    
    UIView *topBackImageView = [[UIView alloc] init];
    topBackImageView.backgroundColor = [UIColor whiteColor];
    [backScrollerView addSubview:topBackImageView];
    topBackImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    
    UILabel *topTitleLabel = [[UILabel alloc] init];
    topTitleLabel.font = [UIFont systemFontOfSize:15];
    topTitleLabel.textColor = [UIColor darkGrayColor];
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.frame = CGRectMake(0, 40, SCREEN_WIDTH, 20);
    [topBackImageView addSubview:topTitleLabel];
    topTitleLabel.text = self.model.disName;
    
    UILabel *topContentLabel = [[UILabel alloc] init];
    topContentLabel.font = [UIFont systemFontOfSize:13];
    topContentLabel.textColor = [UIColor lightGrayColor];
    topContentLabel.textAlignment = NSTextAlignmentCenter;
    topContentLabel.frame = CGRectMake(0, topTitleLabel.bottom + 10, SCREEN_WIDTH, 20);
    [topBackImageView addSubview:topContentLabel];
    topContentLabel.text = self.model.houseName;
    
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.text = @"申请信息";
    sectionLabel.textColor = [UIColor lightGrayColor];
    sectionLabel.font = [UIFont systemFontOfSize:13];
    sectionLabel.frame = CGRectMake(10, topBackImageView.bottom + 10, SCREEN_WIDTH - 10, 20);
    [backScrollerView addSubview:sectionLabel];
    
    for (NSInteger i = 0; i < 8; i++) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.frame = CGRectMake(0, sectionLabel.bottom + i * 41, SCREEN_WIDTH, 40);
        [backScrollerView addSubview:contentView];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.frame = CGRectMake(30, 0, 100, 40);
        [contentView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.frame = CGRectMake(titleLabel.right + 30, 0, SCREEN_WIDTH - titleLabel.right - 30, 40);
        [contentView addSubview:contentLabel];
        
        if (i == 0) {
            titleLabel.text = @"申请人:";
            self.label1 = contentLabel;
        }else if (i == 1) {
            titleLabel.text = @"性别:";
            self.label2 = contentLabel;
        }else if (i == 2) {
            titleLabel.text = @"身份证号:";
            self.label3 = contentLabel;
        }else if (i == 3) {
            titleLabel.text = @"手机号码:";
            self.label4 = contentLabel;
        }else if (i == 4) {
            titleLabel.text = @"申请类型:";
            self.label5 = contentLabel;
            contentLabel.layer.cornerRadius = 5;
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.textColor = [UIColor whiteColor];
            contentLabel.layer.masksToBounds = YES;
            if (self.model.type == 1) {
                contentLabel.text = @"业主";
                contentLabel.backgroundColor = RGB(76, 155, 245);
                contentLabel.frame = CGRectMake(titleLabel.right + 30, 10, 30, 20);
            }else if (self.model.type == 2) {
                contentLabel.text = @"家庭成员";
                contentLabel.backgroundColor = RGB(73, 213, 116);
                contentLabel.frame = CGRectMake(titleLabel.right + 30, 10, 60, 20);
            }else {
                contentLabel.text = @"租赁户";
                contentLabel.backgroundColor = RGB(245, 175, 76);
                contentLabel.frame = CGRectMake(titleLabel.right + 30, 10, 30, 20);
            }
        }else if (i == 5) {
            titleLabel.text = @"申请时间:";
            self.label6 = contentLabel;
        }else if (i == 6) {
            titleLabel.text = @"申请备注:";
            self.label7 = contentLabel;
        }else if (i == 7) {
            titleLabel.text = @"审核备注:";
            [contentLabel removeFromSuperview];
            UITextField *textField = [[UITextField alloc] init];
            textField.frame = CGRectMake(titleLabel.right + 30, 0, SCREEN_WIDTH - 40 - titleLabel.right, 40);
            textField.placeholder = @"请输入审核备注";
            [contentView addSubview:textField];
            self.textField = textField;
        }
    }
    
    UIButton *bottomPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomPassBtn setTitle:@"审核通过" forState:UIControlStateNormal];
    [bottomPassBtn setBackgroundColor:[UIColor blueColor]];
    bottomPassBtn.layer.cornerRadius = 5;
    bottomPassBtn.layer.masksToBounds = YES;
    [bottomPassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomPassBtn.frame = CGRectMake(10, 160 + 8 * 41 + 20, (SCREEN_WIDTH - 30) / 2, 40);
    [bottomPassBtn addTarget:self action:@selector(passAction) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:bottomPassBtn];
    
    UIButton *bottomUnPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomUnPassBtn setTitle:@"拒绝申请" forState:UIControlStateNormal];
    [bottomUnPassBtn setBackgroundColor:[UIColor lightGrayColor]];
    bottomUnPassBtn.layer.cornerRadius = 5;
    bottomUnPassBtn.layer.masksToBounds = YES;
    [bottomUnPassBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    bottomUnPassBtn.frame = CGRectMake(bottomPassBtn.right + 10, 160 + 8 * 41 + 20, (SCREEN_WIDTH - 30) / 2, 40);
    [bottomUnPassBtn addTarget:self action:@selector(unPassAction) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:bottomUnPassBtn];
}

- (void)passAction {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showSuccessText:@"操作成功"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
            [array removeObjectAtIndex:array.count - 2];
            [self.navigationController setViewControllers:array animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"操作失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"操作失败"];
    }];
    [viewModel acAuditApprovalOrRefusedToWithUserHouseId:self.model.userHouseId type:@"1" reason:self.textField.text];
}

- (void)unPassAction {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showSuccessText:@"操作成功"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
            [array removeObjectAtIndex:array.count - 2];
            [self.navigationController setViewControllers:array animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"操作失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"操作失败"];
    }];
    [viewModel acAuditApprovalOrRefusedToWithUserHouseId:self.model.userHouseId type:@"2" reason:self.textField.text];
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
