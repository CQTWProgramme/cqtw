//
//  AccessRecordVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessRecordVC.h"
#import "AccessRecordCell.h"
#import "ACViewModel.h"
#import "RecordVisitorCell.h"
#import "VillageApplyModel.h"
#import "RecordVisitorModel.h"

@interface AccessRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *areaDataArray;
@property (strong, nonatomic) NSMutableArray *visitorDataArray;
@end

@implementation AccessRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self setupSelectAppUserHouseData];
}

- (void)setupTableView {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSMutableArray *)areaDataArray {
    if (nil == _areaDataArray) {
        _areaDataArray = [NSMutableArray array];
    }
    return _areaDataArray;
}

-(NSMutableArray *)visitorDataArray {
    if (nil == _visitorDataArray) {
        _visitorDataArray = [NSMutableArray array];
    }
    return _visitorDataArray;
}

- (void)setupSelectAppUserHouseData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.areaDataArray addObjectsFromArray:returnValue];
        [self setupGetVisitorsRecordData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel selectAppUserHouseData];
}

- (void)setupGetVisitorsRecordData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.visitorDataArray addObjectsFromArray:returnValue];
        [self.myTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel acGetVisitorsRecord];
}

#pragma tableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.areaDataArray.count;
    }else {
        return self.visitorDataArray.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    
    UILabel *headlabel = [[UILabel alloc] init];
    headlabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, 30);
    headlabel.textColor = [UIColor blackColor];
    headlabel.font = [UIFont systemFontOfSize:13];
    
    [headerView addSubview:headlabel];
    if (section == 0) {
        headlabel.text = @"住宅关联申请";
    }else if (section == 1) {
        headlabel.text = @"访客记录";
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AccessRecordCell *cell = [AccessRecordCell cellWithTableView:tableView];
        VillageApplyModel *model = self.areaDataArray[indexPath.row];
        cell.model = model;
        return cell;
    }else {
        RecordVisitorCell *cell = [RecordVisitorCell cellWithTableView:tableView];
        RecordVisitorModel *model = self.visitorDataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
