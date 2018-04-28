//
//  HouseOwnerVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "HouseOwnerVC.h"
#import "HouseDetailMemberModel.h"
#import "HouseDetailMemberCell.h"

@interface HouseOwnerVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *myTableView;
@end

@implementation HouseOwnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

-(UITableView *)myTableView{
if (!_myTableView) {
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 - 150 - 45) style:UITableViewStylePlain];
    _myTableView.backgroundColor = BACKGROUND_COLOR;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableFooterView=[[UIView alloc]init];
    _myTableView.rowHeight=60;
}
    return _myTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseDetailMemberCell *listCell = [HouseDetailMemberCell myHouseDetailMemberCellWithTableView:tableView];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        listCell.model = self.dataArray[indexPath.row];
    }
    return listCell;
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
