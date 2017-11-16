//
//  MemberControlVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberControlVC.h"
#import "MemberControlCell.h"
#import "ACViewModel.h"
#import "MemberControlModel.h"

@interface MemberControlVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MemberControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResultAction:) name:@"MemberManageVCNotification" object:nil];
}

- (void)getResultAction:(NSNotification *)notification {
    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
    if (type == 1) {
        [self loadData];
    }
}

- (void)setupTableView {
    MJWeakSelf
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
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
    
    [viewModel acGetMemberManagementData];
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberControlCell *cell = [MemberControlCell cellWithTableView:tableView];
    MemberControlModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"选中了第%@行",@(indexPath.row));
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
