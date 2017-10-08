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
        weakSelf.currPage = weakSelf.currPage + 5;
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
                    
                }
                [self.dataArr addObjectsFromArray:returnValue];
                weakSelf.netDetailView.groupArr = weakSelf.dataArr;
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
    
    MJWeakSelf
    if (netDetailModel.branchId == nil) {
        NetDetailVC * netDetail =[[NetDetailVC alloc]init];
        netDetail.groupTitle = netDetailModel.wdmc;
        netDetail.itemId = netDetailModel.customId;
        netDetail.type = self.type;
        [weakSelf.navigationController pushViewController:netDetail animated:YES];
    }else {
        //数组为空直接跳转安防详情
        AnDetailVC * anDetailVC =[[AnDetailVC alloc]init];
        anDetailVC.branchId = netDetailModel.branchId;
        anDetailVC.name = netDetailModel.wdmc;
        [self.navigationController pushViewController:anDetailVC animated:YES];
    }
}

-(void)deleteAFItem:(NSString *)customId updateCellBlock:(UpdateCellBlock)block {
    
}

-(NetDetailView *)netDetailView{
    if (!_netDetailView) {
        _netDetailView =[[NetDetailView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _netDetailView.delegate=self;
    }
    return _netDetailView;
}

@end
