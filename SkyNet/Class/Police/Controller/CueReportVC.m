//
//  CueReportVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "CueReportVC.h"
#import "CueReportCell.h"
#import "ReportVC.h"

@interface CueReportVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation CueReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"线索举报";
    [self setupMyTableView];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
}

-(void)createRightItem{

    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"我要举报" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(toReportVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setupMyTableView {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)toReportVC {
    ReportVC *reportVC = [[ReportVC alloc] init];
    [self.navigationController pushViewController:reportVC animated:YES];
}
         
#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CueReportCell *cell = [CueReportCell cellWithTableView:tableView];
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
