//
//  MoreHistoryVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MoreHistoryVC.h"
#import "SearchHistoryCell.h"

@interface MoreHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation MoreHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多历史搜索";
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self.view addSubview:self.myTableView];
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
    }
    return _myTableView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCell *cell = [SearchHistoryCell cellWithTableView:tableView];
    cell.content = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *content = self.dataArray[indexPath.row];
    self.historyHandle(content);
    [self.navigationController popViewControllerAnimated:YES];
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
