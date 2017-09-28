//
//  MonitorVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorVC.h"
#import "MonitorItemCell.h"
#import "MonitorItemModel.h"
#import "MonitorDetailListVC.h"
@interface MonitorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation MonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"监控";
    [self setupTableView];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    // Do any additional setup after loading the view from its nib.
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

-(NSArray *)dataArray {
    if (nil == _dataArray) {
        MonitorItemModel *model1 = [[MonitorItemModel alloc] init];
        model1.fzmc = @"常用监控";
        MonitorItemModel *model2 = [[MonitorItemModel alloc] init];
        model2.fzmc = @"常用监控";
        MonitorItemModel *model3 = [[MonitorItemModel alloc] init];
        model3.fzmc = @"常用监控";
        _dataArray = @[model1,model2,model3];
    }
    return _dataArray;
}

- (void)setupTableView{
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.tableFooterView=[[UIView alloc]init];
    _mytableView.rowHeight=70;

}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MonitorItemCell *cell = [MonitorItemCell cellWithTableView:tableView];
    [cell setData:self.dataArray[indexPath.row]];
    cell.deleteAFItem = ^{
        
    };
    cell.editAFItem = ^{
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MonitorDetailListVC *listVC = [[MonitorDetailListVC alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
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
