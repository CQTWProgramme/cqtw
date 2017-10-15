//
//  MonitorSecondVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorSecondVC.h"
#import "MonitorSecondView.h"
#import "KYAlertView.h"
#import "AddNewGroupVC.h"
#import "AddGroupPointVC.h"
#import "MonitorViewModel.h"
#import "MonitorDetailListVC.h"

@interface MonitorSecondVC ()<MonitorSecondViewDelegate>
@property(nonatomic,assign) NSInteger currPage;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong)MonitorSecondView * netDetailView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MonitorSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_groupTitle;
    [self setNavBackButtonImage:ImageNamed(@"back")];
    if (self.type == 0) {
        self.currPage=0;
        self.pageSize=10;
    }else {
        [self createRightItem];
    }
    [self.view addSubview:self.netDetailView];
    [self setupRefresh];
}

- (void)setupRefresh {
    MJWeakSelf
    _netDetailView.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.netDetailView.myRefreshView = weakSelf.netDetailView.myTableView.mj_header;
        weakSelf.currPage = 0;
        weakSelf.pageSize=10;
        [weakSelf getGroupDataWithPage:weakSelf.currPage PageSize:weakSelf.pageSize];
        
    }];
    
    _netDetailView.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.netDetailView.myRefreshView = weakSelf.netDetailView.myTableView.mj_footer;
        weakSelf.currPage = weakSelf.currPage + 1;
        weakSelf.pageSize=10;
        [weakSelf getGroupDataWithPage:weakSelf.currPage PageSize:weakSelf.pageSize];
    }];
    if (self.type == 1) {
        _netDetailView.myTableView.mj_footer.hidden = YES;
    }else {
        _netDetailView.myTableView.mj_footer.hidden = NO;
    }
    [_netDetailView.myTableView.mj_header beginRefreshing];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addNewGroup {
    MJWeakSelf
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"创建分组或添加数据" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"创建分组",@"添加数据",nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            NSLog(@"取消");
            
        }else  if (index == 1) {
            AddNewGroupVC * addNewGroupVC =[AddNewGroupVC new];
            addNewGroupVC.fzgn = 1;
            addNewGroupVC.fid = weakSelf.itemId;
            [weakSelf.navigationController pushViewController:addNewGroupVC animated:YES];
            
        }else if (index == 2) {
            AddGroupPointVC * adVC =[[AddGroupPointVC alloc]init];
            adVC.customId = weakSelf.itemId;
            [weakSelf.navigationController pushViewController:adVC animated:YES];
            
        }
        
    };
    
    [alert show];
}

- (void)getGroupDataWithPage:(NSInteger )page PageSize:(NSInteger )pageSize {
    MJWeakSelf
    MonitorViewModel *afViewModel =[MonitorViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        if (self.type == 0) {
            //..下拉刷新
            if (weakSelf.netDetailView.myRefreshView == weakSelf.netDetailView.myTableView.mj_header) {
                [weakSelf.dataArr removeAllObjects];
                weakSelf.dataArr=returnValue;
                weakSelf.netDetailView.groupArr = weakSelf.dataArr;
                dispatch_async(dispatch_get_main_queue(), ^(){
                    
                    [weakSelf.netDetailView.myTableView reloadData];
                    [weakSelf.netDetailView.myTableView.mj_header  endRefreshing];
                });
                
            }else if(weakSelf.netDetailView.myRefreshView == weakSelf.netDetailView.myTableView.mj_footer){
                
                if ([returnValue count]==0) {
                    
                    [STTextHudTool showText:@"暂无更多内容"];
                    
                }else {
                    [self.dataArr addObjectsFromArray:returnValue];
                    weakSelf.netDetailView.groupArr = weakSelf.dataArr;
                }
                dispatch_async(dispatch_get_main_queue(), ^(){
                    
                    [weakSelf.netDetailView.myTableView reloadData];
                    [weakSelf.netDetailView.myTableView.mj_footer  endRefreshing];
                });
            }
        }else {
            weakSelf.dataArr = returnValue;
            weakSelf.netDetailView.groupArr = weakSelf.dataArr;
            dispatch_async(dispatch_get_main_queue(), ^(){
                [weakSelf.netDetailView.myTableView reloadData];
                [weakSelf.netDetailView.myTableView.mj_header  endRefreshing];
            });
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    if (self.type == 0) {
        [afViewModel requestDistrictDataWithDistrictId:self.itemId currentPage:self.currPage pageSize:self.pageSize];
    }else {
        [afViewModel requestGroupData:self.itemId];
    }
}

#pragma mark 选择表格
-(void)selectGroup:(MonitorSecondGroupModel *)groupModel{
    MonitorSecondVC * secondVC =[[MonitorSecondVC alloc]init];
//    secondVC.groupTitle = netDetailModel.fzmc;
//    secondVC.itemId = netDetailModel.customId;
    secondVC.type = self.type;
    [self.navigationController pushViewController:secondVC animated:YES];
    
}

-(void)selectPoint:(MonitorSecondPointModel *)pointModel {
    MonitorDetailListVC *listVC = [[MonitorDetailListVC alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

-(void)deleteGroup:(NSString *)customId
            updateCellBlock:(UpdateCellBlock)block {
    MJWeakSelf;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该分组" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf deleteMonitorSecondGroup:customId updateCellBlock:block];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
}

//删除网点
-(void)deletePoint:(NSString *)customId
           updateCellBlock:(UpdateCellBlock)block {
    MJWeakSelf;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该网点" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf deleteMonitorSecondpoint:customId updateCellBlock:block];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
}

////编辑分组
-(void)editNetDetailGroup:(NSString *)customId
                groupName:(NSString *)groupName
          modifyNameBlock:(ModifyNameBlock)block {
    MJWeakSelf
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"编辑分组名" message:@"请输入您要编辑的名字" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [[alert textFieldAtIndex:0] setPlaceholder:@"输入分组名"];
    UITextField *tf=[alert textFieldAtIndex:0];//获得输入框
    tf.text=groupName;
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            NSLog(@"取消");
            
        }else  if (index == 1) {
            
            NSString * inputText=tf.text;//获得值
            if ([inputText isEqualToString:@""]) {
                
                [STTextHudTool showErrorText:@"分组名不能为空" withSecond:HudDelay];
                
            }else{
                
                [weakSelf editMonitorSecondGroup:customId groupName:groupName modifyNameBlock:block];
            }
            
        }
        
    };
    
    [alert show];
}
#pragma mark 修改自定义分组名称

-(void)editMonitorSecondGroup:(NSString *)customId groupName:(NSString *)groupName modifyNameBlock:(ModifyNameBlock)block{
    MJWeakSelf
    MonitorViewModel * afViewModel =[MonitorViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            [weakSelf getGroupDataWithPage:0 PageSize:0];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestEditGroup:groupName customId:customId];
}

-(void)deleteMonitorSecondGroup:(NSString *)customId updateCellBlock:(UpdateCellBlock)block{
    
    MonitorViewModel * afViewModel =[MonitorViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
            });
        }
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestDeleteGroup:customId];
}

-(void)deleteMonitorSecondpoint:(NSString *)customId updateCellBlock:(UpdateCellBlock)block {
    MonitorViewModel * afViewModel =[MonitorViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
            });
        }
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestDeleteGroup:customId];
}

-(MonitorSecondView *)netDetailView{
    if (!_netDetailView) {
        _netDetailView =[[MonitorSecondView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _netDetailView.type = self.type;
        _netDetailView.delegate=self;
    }
    return _netDetailView;
}

@end
