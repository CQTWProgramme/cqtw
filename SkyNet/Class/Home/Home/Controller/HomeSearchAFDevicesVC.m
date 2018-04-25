//
//  HomeSearchAFDevicesVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchAFDevicesVC.h"
#import "HomeViewModel.h"
#import "HomeSearchDevicesCell.h"
#import "SearchResultDeviceModel.h"
#import "FacilityDetailVC.h"
@interface HomeSearchAFDevicesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HomeSearchAFDevicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResult:) name:@"GetSearchResultNotification" object:nil];
}

- (void)getResult:(NSNotification *)notification {
    self.searchText = [notification.userInfo objectForKey:@"searchText"];
    if ([self.searchText isEqualToString:@"请输入搜索关键词"]) {
        self.searchText = @"";
    }
    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
    if (type == 1) {
        self.currPage = 0;
        self.pageSize = 10;
        [self loadData];
    }
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadData {
    MJWeakSelf
    HomeViewModel *viewModel = [HomeViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (weakSelf.myRefreshView == weakSelf.myTableView.mj_header) {
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                long totalPage = [returnValue[@"data"][@"totalPage"] longValue];
                if (totalPage <= weakSelf.currPage) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                NSMutableArray *muArr = [NSMutableArray array];
                NSArray *arr = returnValue[@"data"][@"rows"];
                NSInteger dataCount = arr.count;
                if (dataCount > 0) {
                    for (NSDictionary *dic in arr) {
                        SearchResultDeviceModel *model = [SearchResultDeviceModel mj_objectWithKeyValues:dic];
                        [muArr addObject:model];
                    }
                }
                weakSelf.dataArray = muArr;
                [weakSelf.myTableView.mj_header endRefreshing];
                [weakSelf.myTableView reloadData];
            }else {
                [weakSelf.myTableView.mj_header endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }else if (weakSelf.myRefreshView == weakSelf.myTableView.mj_footer) {
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSMutableArray *muArr = [NSMutableArray array];
                NSDictionary * dic = returnValue[@"data"];
                NSArray *arr = dic[@"rows"];
                if ([arr count] < weakSelf.pageSize) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }
                if (arr.count > 0) {
                    for (NSDictionary *dic1 in arr) {
                        SearchResultDeviceModel *model = [SearchResultDeviceModel mj_objectWithKeyValues:dic1];
                        [muArr addObject:model];
                    }
                }
                
                [weakSelf.dataArray addObjectsFromArray:muArr];
                [weakSelf.myTableView.mj_footer endRefreshing];
                [weakSelf.myTableView reloadData];
            }else {
                [weakSelf.myTableView.mj_footer endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        [STTextHudTool showErrorText:@"操作失败"];
    } WithFailureBlock:^{
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        [STTextHudTool showErrorText:@"操作失败"];
    }];
    
    if (self.searchText == nil) {
        self.searchText = @"";
    }
    [viewModel getBdcDataLikeWithType:@"1" gn:@"1" query:self.searchText currPage:self.currPage pageSize:self.pageSize];
}

-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=70;
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
            self.currPage = 1;
            self.pageSize = 10;
            [self loadData];
        }];
        
        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.myTableView.mj_footer;
            self.currPage += 1;
            self.pageSize = 10;
            [self loadData];
        }];
        // 马上进入刷新状态
        [self.myTableView.mj_header beginRefreshing];
    }
    return _myTableView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeSearchDevicesCell *cell = [HomeSearchDevicesCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchResultDeviceModel *model = self.dataArray[indexPath.row];
    FacilityDetailVC *detailVC = [[FacilityDetailVC alloc] init];
    detailVC.deviceId = model.deviceId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
