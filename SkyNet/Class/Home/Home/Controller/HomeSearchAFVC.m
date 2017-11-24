//
//  HomeSearchAFVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchAFVC.h"
#import "HomeViewModel.h"
#import "HomeSearchAFCell.h"
#import "SearchResultModel.h"
#import "AnDetailVC.h"

@interface HomeSearchAFVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HomeSearchAFVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResult:) name:@"GetSearchResultNotification" object:nil];
    
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)getResult:(NSNotification *)notification {
    self.searchText = [notification.userInfo objectForKey:@"searchText"];
    if ([self.searchText isEqualToString:@"请输入搜索关键词"]) {
        self.searchText = @"";
    }
    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
    if (type == 0) {
        self.currPage = 0;
        self.pageSize = 10;
        [self loadData];
    }
}

- (void)loadData {
    MJWeakSelf
    HomeViewModel *viewModel = [HomeViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSMutableArray *arrayM=[NSMutableArray new];
        for (NSDictionary * dic in returnValue[@"rows"]) {
            SearchResultModel * model =[SearchResultModel mj_objectWithKeyValues:dic];
            [arrayM addObject:model];
        }
        //..下拉刷新
        if (weakSelf.myRefreshView == weakSelf.myTableView.mj_header) {
            weakSelf.dataArray = arrayM;
        }else if(weakSelf.myRefreshView ==weakSelf.myTableView.mj_footer){
            
            if (arrayM.count==0) {
                
                [STTextHudTool showText:@"暂无更多内容"];
            }
            [self.dataArray addObjectsFromArray:arrayM];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [weakSelf.myTableView reloadData];
            [weakSelf.myRefreshView  endRefreshing];
            
        });
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    NSString *currPage = [NSString stringWithFormat:@"%@",@(self.currPage)];
    NSString *pageSize = [NSString stringWithFormat:@"%@",@(self.pageSize)];
    if (self.searchText == nil) {
        self.searchText = @"";
    }
    [viewModel getBdcDataLikeWithType:@"0" gn:@"1" query:self.searchText currPage:currPage pageSize:pageSize];
}

-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=70;
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
            self.currPage = 0;
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
    HomeSearchAFCell *cell = [HomeSearchAFCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchResultModel *model = self.dataArray[indexPath.row];
    AnDetailVC *detailVC = [[AnDetailVC alloc] init];
    detailVC.branchId = model.branchId;
    detailVC.name = model.wdmc;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
