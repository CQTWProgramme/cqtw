//
//  MyHousrListVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MyHousrListVC.h"
#import "MyHouseListModel.h"
#import "MyHouseListCell.h"
#import "ACViewModel.h"

@interface MyHousrListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyHousrListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的房屋";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self.view addSubview:self.myTableView];
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(UITableView *)myTableView{
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.rowHeight=80;
        
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
        [_myTableView.mj_header beginRefreshing];
    }
    return _myTableView;
}

- (void)loadData {
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
                        MyHouseListModel *model = [MyHouseListModel mj_objectWithKeyValues:dic];
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
    
    [viewModel getMyHouseListData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyHouseListCell *listCell = [MyHouseListCell myHouseListCellWithTableView:tableView];
    if (self.dataArray.count > 0) {
        listCell.myHouseListModel = self.dataArray[indexPath.row];
        listCell.index = indexPath.row + 1;
    }
    return listCell;
}
@end
