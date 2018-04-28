//
//  HouseBindVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "HouseBindVC.h"
#import "HouseBindListModel.h"
#import "HouseBindListCell.h"
#import "ACViewModel.h"
#import "HouseBindListDetailVC.h"

@interface HouseBindVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *passArray;
@property (nonatomic, strong) NSMutableArray *unPassArray;
@end

@implementation HouseBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"房屋绑定记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)passArray {
    if (nil == _passArray) {
        _passArray = [NSMutableArray array];
    }
    
    return _passArray;
}

-(NSMutableArray *)unPassArray {
    if (nil == _unPassArray) {
        _unPassArray = [NSMutableArray array];
    }
    
    return _unPassArray;
}

-(UITableView *)myTableView{
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.rowHeight=60;
        
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
        [_myTableView.mj_header beginRefreshing];
    }
    return _myTableView;
}

-(void)loadData {
    MJWeakSelf
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            NSArray *dataArray = returnValue[@"data"];
            if (dataArray.count > 0) {
                for (NSDictionary * dic in dataArray) {
                    HouseBindListModel *model = [HouseBindListModel mj_objectWithKeyValues:dic];
                    if (model.auditState == 2) {
                        [self.passArray addObject:model];
                    }else {
                        [self.unPassArray addObject:model];
                    }
                }
            }
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.mj_header endRefreshing];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
            [weakSelf.myTableView.mj_header endRefreshing];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"请求失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"请求失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
    
    [viewModel selectAppUserHouseData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.passArray.count;
    }else {
        return self.unPassArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, 30);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    titleView.backgroundColor = [UIColor lightGrayColor];
    [titleView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"绑定已通过";
    }else {
        titleLabel.text = @"绑定未通过";
    }
    return titleView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseBindListCell *listCell = [HouseBindListCell myHouseBindListCellWithTableView:tableView];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (self.passArray.count > 0) {
            listCell.model = self.passArray[indexPath.row];
        }
    }else {
        if (self.unPassArray.count > 0) {
            listCell.model = self.unPassArray[indexPath.row];
        }
    }
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HouseBindListModel *model = self.passArray[indexPath.row];
        HouseBindListDetailVC *detailVC = [[HouseBindListDetailVC alloc] init];
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
        HouseBindListModel *model = self.unPassArray[indexPath.row];
        HouseBindListDetailVC *detailVC = [[HouseBindListDetailVC alloc] init];
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
