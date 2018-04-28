//
//  AddHouseVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "AddHouseVC.h"
#import "ACViewModel.h"
#import "SearchNearbtListCell.h"
#import "SearchNearbyListModel.h"
#import "SearchListResultModel.h"
#import "SearchListResultCell.h"
#import "ChooseDistrictSecondVC.h"

@interface AddHouseVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate> {
    BOOL _isSearching;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITextField *searchTextField;
@end

@implementation AddHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查找小区";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupUI];
    [self setupLocation];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupUI {
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH - 70, 30)];
    searchTextField.placeholder = @"输入小区名称";
    searchTextField.layer.borderWidth = 1.0;
    searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.layer.cornerRadius = 5.0;
    [self.view addSubview:searchTextField];
    self.searchTextField = searchTextField;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderColor = [UIColor blueColor].CGColor;
    searchBtn.layer.borderWidth = 1.0;
    searchBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 74, 50, 30);
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}

- (void)searchAction {
    _isSearching = YES;
    if ([self.searchTextField.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请输入搜索内容"];
    }
    MJWeakSelf
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [weakSelf.dataArray removeAllObjects];
            NSArray *dataArray = returnValue[@"data"];
            if (dataArray.count > 0) {
                for (NSDictionary *dic in dataArray) {
                    SearchListResultModel *model = [SearchListResultModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:model];
                }
            }
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.mj_header endRefreshing];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
            [weakSelf.myTableView.mj_header endRefreshing];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"加载失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"加载失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
    
    [viewModel acGetAreaDataWithkey:self.searchTextField.text];
}

- (void)setupLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }break;
        default:break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations) {
        CLLocation *newLocation = locations[0];
        self.latitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.latitude)];
        self.longitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.longitude)];
        [self.locationManager stopUpdatingLocation];
        [self.view addSubview:self.myTableView];
    }else {
        [STTextHudTool showErrorText:@"定位失败"];
    }
}

-(UITableView *)myTableView{
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
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
                for (NSDictionary *dic in dataArray) {
                    SearchNearbyListModel *model = [SearchNearbyListModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:model];
                }
            }
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.mj_header endRefreshing];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
            [weakSelf.myTableView.mj_header endRefreshing];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"加载失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"加载失败"];
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
    
    [viewModel acGetNearbyAreaDataWithLatitude:self.latitude longitude:self.longitude];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSearching) {
        SearchListResultCell *cell = [SearchListResultCell searchListResultCellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else {
        SearchNearbtListCell *cell = [SearchNearbtListCell searchNearbtListCellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isSearching) {
        SearchListResultModel *model = self.dataArray[indexPath.row];
        ChooseDistrictSecondVC *vc = [[ChooseDistrictSecondVC alloc] init];
        vc.parentId = model.branchId;
        vc.disName = model.wdmc;
        vc.address = model.wdmc;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        SearchNearbyListModel *model = self.dataArray[indexPath.row];
        ChooseDistrictSecondVC *vc = [[ChooseDistrictSecondVC alloc] init];
        vc.parentId = model.branchId;
        vc.disName = model.disName;
        vc.address = model.disName;
        [self.navigationController pushViewController:vc animated:YES];
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
