//
//  MemberApplyVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberApplyVC.h"
#import "MemberApplyCell.h"
#import "ACViewModel.h"
#import "MemberApplyModel.h"
#import "AuditDetailVC.h"

@interface MemberApplyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MemberApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    self.title = @"待审核列表";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupTableView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResultAction:) name:@"MemberManageVCNotification" object:nil];
}

//- (void)getResultAction:(NSNotification *)notification {
//    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
//    if (type == 0) {
//        [self loadData];
//    }
//}

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
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
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
    
    [viewModel acGetApplyAuditData];
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberApplyCell *cell = [MemberApplyCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        MemberApplyModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AuditDetailVC *detailVC = [[AuditDetailVC alloc] init];
    MemberApplyModel *model = self.dataArray[indexPath.row];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
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
