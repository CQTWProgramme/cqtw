//
//  ChooseDistrictSecondVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ChooseDistrictSecondVC.h"
#import "ACViewModel.h"
#import "SelectDistrictSecondModel.h"
#import "DistrictSecondCell.h"
#import "SaveUserHouseVC.h"

@interface ChooseDistrictSecondVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ChooseDistrictSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.title=@"请选择";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [self setupHeaderView];
    [self setupData];
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)myTableView {
    if (nil == _myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NavigationBar_HEIGHT) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

-(void)setupHeaderView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    header.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 25)];
    titleLabel.text = self.disName;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom + 5, SCREEN_WIDTH - 20, 15)];
    detailLabel.text = self.address;
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.font = [UIFont systemFontOfSize:10];

    [header addSubview:titleLabel];
    [header addSubview:detailLabel];
    
    self.myTableView.tableHeaderView = header;
}

- (void)setupData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.dataArray addObjectsFromArray:returnValue];
        [self.myTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel selectChildListDataWithParentId:self.parentId];
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DistrictSecondCell *cell = [DistrictSecondCell districtSecondCellWithTableView:tableView];
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectDistrictSecondModel *model = self.dataArray[indexPath.row];
    if (model.lx == 3) {
        SaveUserHouseVC *vc = [[SaveUserHouseVC alloc] init];
        vc.areasId = model.areasId;
        vc.name = model.mc;
        vc.address = [NSString stringWithFormat:@"%@-%@",self.address,model.mc];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ChooseDistrictSecondVC *vc = [[ChooseDistrictSecondVC alloc] init];
        vc.parentId = model.areasId;
        vc.disName = model.mc;
        vc.address = [NSString stringWithFormat:@"%@-%@",self.address,model.mc];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
