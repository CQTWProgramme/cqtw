//
//  CommunityPoliceVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "CommunityPoliceVC.h"
#import "CommunityPoliceCell.h"
#import "CommunityPoliceModel.h"

@interface CommunityPoliceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation CommunityPoliceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

-(NSArray *)dataArr {
    if (nil == _dataArr) {
        CommunityPoliceModel *model1 = [[CommunityPoliceModel alloc] init];
        model1.imgUrl = nil;
        model1.content = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        model1.time = @"2017.10.11";
        
        CommunityPoliceModel *model2 = [[CommunityPoliceModel alloc] init];
        model2.imgUrl = @"www.baidu.test";
        model2.content = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        model2.time = @"2017.10.11";
        _dataArr = @[model1,model2];
    }
    return _dataArr;
}

- (void)setupTableView {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityPoliceCell *cell = [CommunityPoliceCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
