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
@property (nonatomic, assign) long currentPage;
@property (nonatomic, assign) long pageSize;
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
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSInteger totalPage = [returnValue[@"data"][@"totalPage"] integerValue];
                if (totalPage <= weakSelf.currentPage) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    [weakSelf.myTableView.mj_footer resetNoMoreData];
                }
                
                NSMutableArray *muArr = [NSMutableArray array];
                NSArray *arr = returnValue[@"data"][@"rows"];
                NSInteger dataCount = arr.count;
                if (dataCount > 0) {
                    for (NSDictionary *dic in arr) {
                        EquipmentModel *model = [EquipmentModel mj_objectWithKeyValues:dic];
                        [muArr addObject:model];
                    }
                }
                weakSelf.equipmentsArray = muArr;
                [weakSelf.myTableView.mj_header endRefreshing];
                [weakSelf.myTableView reloadData];
            }else {
                [weakSelf.myTableView.mj_header endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }else if (weakSelf.myRefreshView == weakSelf.myTableView.mj_footer) {
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                
                NSInteger totalPage = [returnValue[@"data"][@"totalPage"] integerValue];
                if (weakSelf.currentPage > totalPage) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    NSMutableArray *muArr = [NSMutableArray array];
                    NSDictionary * dic = returnValue[@"data"];
                    NSArray *arr = dic[@"rows"];
                    if (arr.count > 0) {
                        for (NSDictionary *dic1 in arr) {
                            EquipmentModel *model = [EquipmentModel mj_objectWithKeyValues:dic1];
                            [muArr addObject:model];
                        }
                    }
                    
                    [weakSelf.equipmentsArray addObjectsFromArray:muArr];
                    [weakSelf.myTableView.mj_footer endRefreshing];
                    [weakSelf.myTableView reloadData];
                }
                
            }else {
                [weakSelf.myTableView.mj_footer endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }
    } failure:^(id errorCode) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        [STTextHudTool showErrorText:@"操作失败"];
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
            weakSelf.currentPage = 1;
            weakSelf.pageSize = 10;
            [weakSelf.equipmentsArray removeAllObjects];
            [weakSelf loadData];
        }];
        // 马上进入刷新状态
        [_myTableView.mj_header beginRefreshing];

        //..上拉刷新
        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             weakSelf.myRefreshView = _myTableView.mj_footer;
            weakSelf.currentPage += 1;
            weakSelf.pageSize=weakSelf.pageSize;
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
