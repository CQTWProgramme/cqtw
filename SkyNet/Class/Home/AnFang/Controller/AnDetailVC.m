//
//  AnDetailVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AnDetailVC.h"
#import "AnDetailView.h"
#import "LatticePointDetailVC.h"
#import "AFViewModel.h"
@interface AnDetailVC ()<AnDetailViewDelegate>
@property(nonatomic,strong)AnDetailView * anDetailView;
@end

@implementation AnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"安防详情";
     [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self.view addSubview:self.anDetailView];
    [self getData];
    
}


- (void)getData {
    
}

-(void)bottomViewClickWithType:(BottomViewClickType)type {
    AFViewModel *afViewModel = [AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString *code = returnValue;
        if (code.integerValue == 1) {
            if (type == BuFangType) {
                [STTextHudTool showSuccessText:@"一键布防成功!"];
            }else if (type == CeFang) {
                [STTextHudTool showSuccessText:@"一键撤防成功!"];
            }else if (type == XiaoJing) {
                [STTextHudTool showSuccessText:@"一键消警成功!"];
            }
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    if (type == BuFangType) {
        [afViewModel alarmBranchBCFWithId:self.branchId type:1];
    }else if (type == CeFang) {
        [afViewModel alarmBranchBCFWithId:self.branchId type:2];
    }else if (type == XiaoJing) {
        [afViewModel alarmBranchBCFWithId:self.branchId type:3];
    }
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    // [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

-(AnDetailView *)anDetailView{
    MJWeakSelf
    if (!_anDetailView) {
       _anDetailView =[[AnDetailView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT) currentVC:self];
        _anDetailView.delegate=self;
        _anDetailView.headTitle.text = weakSelf.name;
        _anDetailView.latticePointDetailBlock = ^(){
            LatticePointDetailVC *latticeDetailVC = [[LatticePointDetailVC alloc] init];
            latticeDetailVC.branchId = weakSelf.branchId;
            latticeDetailVC.view.backgroundColor = [UIColor whiteColor];
            [weakSelf.navigationController pushViewController:latticeDetailVC animated:YES];
        };
    }
    return _anDetailView;
    
}

@end
