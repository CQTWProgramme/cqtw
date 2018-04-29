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
    self.title=@"到访房屋选择";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupTableView];
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
    
    [self.myTableView.mj_header beginRefreshing];
}

-(void)loadData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        [self.myTableView.mj_header endRefreshing];
        NSMutableArray *dataArray = returnValue;
        
        if (dataArray.count > 0) {
            for (NSInteger i = 0; i < dataArray.count; i++) {
                AccessDetailModel *model = dataArray[i];
                NSMutableArray *tempArray = [NSMutableArray array];
                [tempArray addObject:model];
                
                for (NSInteger j = i+1; j < dataArray.count; j++) {
                    AccessDetailModel *jmodel = dataArray[j];
                    
                    if ([model.disName isEqualToString:jmodel.disName]) {
                        [tempArray addObject:jmodel];
                        [dataArray removeObjectAtIndex:j];
                        j -= 1;
                    }
                }
                
                [self.dataArray addObject:tempArray];
            }
        }
        [self.myTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        [self.myTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.myTableView.mj_header endRefreshing];
    }];
    [viewModel getBranchAreasInfoData];
}

#pragma tableviewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    headerView.backgroundColor = BACKGROUND_COLOR;
    
    AccessDetailModel *model = self.dataArray[section][0];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 35)];
    headLabel.font = [UIFont systemFontOfSize:13];
    headLabel.textColor = [UIColor lightGrayColor];
    headLabel.text = [NSString stringWithFormat:@"%@(%@)",model.disName,@([self.dataArray[section] count])];
    [headerView addSubview:headLabel];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessDetailCell *cell = [AccessDetailCell cellWithTableView:tableView];
    AccessDetailModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AccessDetailModel *model = self.dataArray[indexPath.section][indexPath.row];
    AddVisitorVC *addVC = [[AddVisitorVC alloc] init];
    addVC.model = model;
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
