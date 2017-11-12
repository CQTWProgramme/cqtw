//
//  ChooseDistrictFirstVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ChooseDistrictFirstVC.h"
#import "ChooseDistrictSecondVC.h"
#import "ACViewModel.h"
#import "SelectDistrictFirstModel.h"
#import "DistrictFirstCell.h"

@interface ChooseDistrictFirstVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISearchBar * mySearchBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ChooseDistrictFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.title=@"门禁";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mySearchBar];
    [self.view addSubview:self.myTableView];
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.dataArray addObjectsFromArray:returnValue];
        [self.myTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel selectBranchListDataWithDisName:self.mySearchBar.text];
}

#pragma mark 搜索框懒加载
-(UISearchBar * )mySearchBar{
    if (!_mySearchBar) {
        _mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH,44)];
        
        [_mySearchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        
        _mySearchBar.tintColor=[UIColor groupTableViewBackgroundColor];
        
        // [_mySearchBar setSearchBarPlaceholdePositon];
        _mySearchBar.delegate = self;
        [_mySearchBar setPlaceholder:@"请输入小区名称"];
        [_mySearchBar setContentMode:UIViewContentModeLeft];
        _mySearchBar.showsCancelButton=YES;
        
    }

    return _mySearchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请输入搜索内容"];
        return;
    }
    [self setupData];
}

-(UITableView *)myTableView {
    if (nil == _myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.mySearchBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.mySearchBar.bottom) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=70;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DistrictFirstCell *cell = [DistrictFirstCell districtFirstCellWithTableView:tableView];
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChooseDistrictSecondVC *secondVC = [[ChooseDistrictSecondVC alloc] init];
    SelectDistrictFirstModel *model = self.dataArray[indexPath.row];
    secondVC.parentId = model.branchId;
    secondVC.disName = model.wdmc;
    secondVC.address = model.wdmc;
    [self.navigationController pushViewController:secondVC animated:YES];
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
