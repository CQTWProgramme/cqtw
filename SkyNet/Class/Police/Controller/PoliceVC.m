//
//  PoliceVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/20.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PoliceVC.h"
#import "PoliceHomeView.h"
#import "PoliceHomeModel.h"
#import "CommunityPoliceVC.h"
#import "CueReportVC.h"
#import "PoliceInteractionVC.h"
@interface PoliceVC ()<PoliceHomeViewDelegate>
@property (nonatomic, strong)PoliceHomeView *homeView;
@end

@implementation PoliceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"警务平台";
    [self.view addSubview:self.homeView];
}

-(void)reloadTableView {
    
}

-(void)menuClick:(NSInteger)tag {
    if (tag == 0) {
        CommunityPoliceVC *communityVC = [[CommunityPoliceVC alloc] init];
        [self.navigationController pushViewController:communityVC animated:YES];
    }else if (tag == 1) {
        
    }else if (tag == 2) {
        CueReportVC *reportVC = [[CueReportVC alloc] init];
        [self.navigationController pushViewController:reportVC animated:YES];
    }else {
        PoliceInteractionVC *interVC = [[PoliceInteractionVC alloc] init];
        [self.navigationController pushViewController:interVC animated:YES];
    }
}

-(PoliceHomeView *)homeView{
    
    if (!_homeView) {
        _homeView =[[PoliceHomeView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT-TABBAR_HEIGHT)];
        PoliceHomeModel *model1 = [[PoliceHomeModel alloc] init];
        model1.content = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        model1.time = @"2017.02.03";
        _homeView.shortDataArr = @[model1];
        _homeView.delegate = self;
    }
    return _homeView;
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
