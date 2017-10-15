//
//  EquipmentVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EquipmentVC.h"
#import "EquipCell.h"
#import "FacilityDetailVC.h"
#import "EquipmentModel.h"
@interface EquipmentVC ()
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong) UITableView * myTableView;
//设备数组
@property (nonatomic, strong) NSMutableArray *equipmentsArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation EquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
}

-(NSMutableArray *)equipmentsArray {
    if (nil == _equipmentsArray) {
        _equipmentsArray = [NSMutableArray array];
    }
    return _equipmentsArray;
}

//加载设备数据
- (void)loadData {
    
    MJWeakSelf
    [EquipmentModel getListDevicesDataById:self.branchId currentPage:self.currentPage pageSize:self.pageSize success:^(id returnValue) {
        if (weakSelf.myRefreshView == weakSelf.myTableView.mj_header) {
            weakSelf.equipmentsArray = returnValue;
            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView reloadData];
        }else if (weakSelf.myRefreshView == weakSelf.myTableView.mj_footer) {
            if ([returnValue count]==0) {
                
                [STTextHudTool showText:@"暂无更多内容"];
            }
            [weakSelf.equipmentsArray addObjectsFromArray:returnValue];
            [weakSelf.myTableView.mj_footer endRefreshing];
            [weakSelf.myTableView reloadData];
        }
    } failure:^(id errorCode) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.equipmentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"EquipCell";
    EquipCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[EquipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    EquipmentModel *model = self.equipmentsArray[indexPath.row];
    cell.equitTitle.text = model.sbmc;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
        _myTableView.tableFooterView=[[UIView alloc]init];
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = _myTableView.mj_header;
            weakSelf.currentPage = 0;
            weakSelf.pageSize = 10;
            [weakSelf.equipmentsArray removeAllObjects];
            [weakSelf loadData];
        }];
        // 马上进入刷新状态
        [_myTableView.mj_header beginRefreshing];

        //..上拉刷新
        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             weakSelf.myRefreshView = _myTableView.mj_footer;
            weakSelf.currentPage = weakSelf.currentPage + 1;
            weakSelf.pageSize=weakSelf.pageSize + 10;
            [weakSelf loadData];
        }];
        _myTableView.mj_footer.hidden = NO;
    }
    return _myTableView;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EquipmentModel *model = self.equipmentsArray[indexPath.row];
    FacilityDetailVC *detailVC = [[FacilityDetailVC alloc] init];
    detailVC.deviceId = model.deviceId;
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
