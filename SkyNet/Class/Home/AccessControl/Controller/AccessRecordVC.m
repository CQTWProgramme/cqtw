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
#import "OpenDoorHistoryModel.h"
#import "OpenDoorHistoryCell.h"

@interface AccessRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
//@property (strong, nonatomic) NSMutableArray *areaDataArray;
//@property (strong, nonatomic) NSMutableArray *visitorDataArray;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation AccessRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开门记录";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResultAction:) name:@"AccessControlVCNotification" object:nil];
}

//- (void)getResultAction:(NSNotification *)notification {
//    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
//    if (type == 1) {
//        [self setupSelectAppUserHouseData];
//    }
//}

- (void)setupTableView {
    MJWeakSelf
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setupOpenDoorHistoryData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

//-(NSMutableArray *)areaDataArray {
//    if (nil == _areaDataArray) {
//        _areaDataArray = [NSMutableArray array];
//    }
//    return _areaDataArray;
//}
//
//-(NSMutableArray *)visitorDataArray {
//    if (nil == _visitorDataArray) {
//        _visitorDataArray = [NSMutableArray array];
//    }
//    return _visitorDataArray;
//}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupOpenDoorHistoryData {
    MJWeakSelf
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (returnValue[@"data"] != [NSNull null]) {
                NSArray *data = returnValue[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        OpenDoorHistoryModel *model = [OpenDoorHistoryModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:mutableArr];
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.mj_header endRefreshing];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
            [weakSelf.myTableView.mj_header endRefreshing];
        }
    } WithErrorBlock:^(id errorCode) {
        [self.myTableView.mj_header endRefreshing];
        [STTextHudTool showErrorText:@"加载失败"];
    } WithFailureBlock:^{
        [self.myTableView.mj_header endRefreshing];
        [STTextHudTool showErrorText:@"加载失败"];
    }];
    [viewModel getOpenDoorHistoryData];
}

//- (void)setupSelectAppUserHouseData {
//    ACViewModel *viewModel = [ACViewModel new];
//    [viewModel setBlockWithReturnBlock:^(id returnValue) {
//        if (self.areaDataArray.count > 0) {
//            [self.areaDataArray removeAllObjects];
//        }
//        [self.myTableView.mj_header endRefreshing];
//        [self.areaDataArray addObjectsFromArray:returnValue];
//        [self setupGetVisitorsRecordData];
//    } WithErrorBlock:^(id errorCode) {
//        [self.myTableView.mj_header endRefreshing];
//    } WithFailureBlock:^{
//        [self.myTableView.mj_header endRefreshing];
//    }];
//    [viewModel selectAppUserHouseData];
//}
//
//- (void)setupGetVisitorsRecordData {
//    ACViewModel *viewModel = [ACViewModel new];
//    [viewModel setBlockWithReturnBlock:^(id returnValue) {
//        if (self.visitorDataArray.count > 0) {
//            [self.visitorDataArray removeAllObjects];
//        }
//        [self.visitorDataArray addObjectsFromArray:returnValue];
//        [self.myTableView reloadData];
//    } WithErrorBlock:^(id errorCode) {
//
//    } WithFailureBlock:^{
//
//    }];
//    [viewModel acGetVisitorsRecord];
//}

#pragma tableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return self.areaDataArray.count;
//    }else {
//        return self.visitorDataArray.count;
//    }
//    return 0;
    return self.dataArray.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
//
//    UILabel *headlabel = [[UILabel alloc] init];
//    headlabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, 30);
//    headlabel.textColor = [UIColor blackColor];
//    headlabel.font = [UIFont systemFontOfSize:13];
//
//    [headerView addSubview:headlabel];
//    if (section == 0) {
//        headlabel.text = @"住宅关联申请";
//    }else if (section == 1) {
//        headlabel.text = @"访客记录";
//    }
//    return headerView;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        AccessRecordCell *cell = [AccessRecordCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        VillageApplyModel *model = self.areaDataArray[indexPath.row];
//        cell.model = model;
//        return cell;
//    }else {
//        RecordVisitorCell *cell = [RecordVisitorCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        RecordVisitorModel *model = self.visitorDataArray[indexPath.row];
//        cell.model = model;
//        return cell;
//    }
    
    OpenDoorHistoryCell *cell = [OpenDoorHistoryCell openDoorHistoryCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        OpenDoorHistoryModel *model = self.dataArray[indexPath.row];
        cell.openDoorModel = model;
    }
    return cell;
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
