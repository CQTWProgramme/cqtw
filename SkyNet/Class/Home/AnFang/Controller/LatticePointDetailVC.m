//
//  LatticePointDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LatticePointDetailVC.h"
#import "LatticePointDetailHeaderView.h"

@interface LatticePointDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)LatticePointDetailHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation LatticePointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网点详情";
    [self setupHeaderView];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupHeaderView {
    LatticePointDetailHeaderView *headerView = [[LatticePointDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.headerView = headerView;
}

- (void)setupTableView {
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headerView;
}

-(NSArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = @[@{@"name":@"网点编号",@"content":@"0001"},@{@"name":@"网所属行政区",@"content":@"巴南区"},@{@"name":@"安装人员",@"content":@"刘德华"},@{@"name":@"运维值班中心",@"content":@"天网"},@{@"name":@"主管部门值班中心",@"content":@"北碚区政府"},@{@"name":@"位置",@"content":@"巴南区"}];
    }
    return _dataArray;
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
    }
    return _myTableView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.dataArray[indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [self.dataArray[indexPath.row] objectForKey:@"content"];
    return cell;
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
