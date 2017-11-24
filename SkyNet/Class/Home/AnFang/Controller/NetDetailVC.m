//
//  NetDetailVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "NetDetailVC.h"
#import "NetDetailView.h"
#import "AFViewModel.h"
#import "AnDetailVC.h"
#import "AFViewModel.h"
#import "KYAlertView.h"
#import "AddNewGroupVC.h"
#import "AddGroupPointVC.h"
#import "NetDetailDistrictModel.h"
@interface NetDetailVC ()<NetDetailViewDelegate>
@property(nonatomic,assign) NSInteger currPage;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong)NetDetailView * netDetailView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation NetDetailVC

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
            adVC.type = 1;
            adVC.gn = 1;
            [weakSelf.navigationController pushViewController:adVC animated:YES];
            
        }
        
    };
    
    [alert show];
}

- (void)getGroupDataWithPage:(NSInteger )page PageSize:(NSInteger )pageSize {
    MJWeakSelf
    AFViewModel *afViewModel =[AFViewModel new];
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
-(void)selectItem:(NetDetailModel *)netDetailModel{
    //数组为空直接跳转安防详情
    AnDetailVC * anDetailVC =[[AnDetailVC alloc]init];
    anDetailVC.branchId = netDetailModel.branchId;
    anDetailVC.name = netDetailModel.wdmc;
    [self.navigationController pushViewController:anDetailVC animated:YES];
}

-(void)districtSelectItem:(NetDetailDistrictModel *)netDetailModel {
    NetDetailVC * netDetail =[[NetDetailVC alloc]init];
    netDetail.groupTitle = netDetailModel.fzmc;
    netDetail.itemId = netDetailModel.customId;
    netDetail.type = self.type;
    [self.navigationController pushViewController:netDetail animated:YES];
}

-(void)deleteNetDetailGroup:(NSString *)customId
            updateCellBlock:(UpdateCellBlock)block {
    MJWeakSelf;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该分组" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf deleteAFItem:customId updateCellBlock:block];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
}

//删除网点
-(void)deleteNetDetailItem:(NSString *)customId
           updateCellBlock:(UpdateCellBlock)block {
    MJWeakSelf;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该网点" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf deleteAFItem:customId updateCellBlock:block];
        
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
                
                [weakSelf editGroup:customId groupName:inputText modifyNameBlock:block];
            }
            
        }
        
    };
    
    [alert show];
}
#pragma mark 修改自定义分组名称

-(void)editGroup:(NSString *)customId
       groupName:(NSString *)groupName
 modifyNameBlock:(ModifyNameBlock)block
{
    MJWeakSelf
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(groupName);
            });
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestEditGroup:groupName customId:customId];
}

-(void)deleteAFItem:(NSString *)customId updateCellBlock:(UpdateCellBlock)block {
    
    AFViewModel * afViewModel =[AFViewModel new];
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

-(NetDetailView *)netDetailView{
    if (!_netDetailView) {
        _netDetailView =[[NetDetailView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _netDetailView.type = self.type;
        _netDetailView.delegate=self;
    }
    return _netDetailView;
}

@end
