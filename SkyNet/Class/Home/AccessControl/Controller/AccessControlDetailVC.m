//
//  AccessControlDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessControlDetailVC.h"
#import "AddVisitorVC.h"
#import "AccessDetailModel.h"
#import "ACViewModel.h"
#import "AccessDetailCell.h"

@interface AccessControlDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AccessControlDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"访客登记";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupTableView];
    [self loadData];
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupTableView {
    MJWeakSelf
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

-(void)loadData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        [self.myTableView.mj_header endRefreshing];
        [self.dataArray addObjectsFromArray:returnValue];
        [self.myTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        [self.myTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.myTableView.mj_header endRefreshing];
    }];
    [viewModel getBranchAreasInfoData];
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessDetailCell *cell = [AccessDetailCell cellWithTableView:tableView];
    AccessDetailModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AccessDetailModel *model = self.dataArray[indexPath.row];
    AddVisitorVC *addVC = [[AddVisitorVC alloc] init];
    addVC.model = model;
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
