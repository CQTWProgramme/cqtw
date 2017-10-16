//
//  MemberControlVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberControlVC.h"
#import "MemberControlCell.h"

@interface MemberControlVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MemberControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupTableView {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberControlCell *cell = [MemberControlCell cellWithTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
