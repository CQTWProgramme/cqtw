//
//  NetDetailVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "NetDetailVC.h"
#import "NetDetailView.h"
#import "AFViewModel.h"
#import "AnDetailVC.h"
#import "AFViewModel.h"
@interface NetDetailVC ()<NetDetailViewDelegate>
@property(nonatomic,strong)NetDetailView * netDetailView;
@end

@implementation NetDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    MJWeakSelf
    self.title=_groupTitle;
     [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self.view addSubview:self.netDetailView];
    // Do any additional setup after loading the view.
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
   // [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

#pragma mark 下拉刷新
-(void)reloadTableView{
    
    __weak typeof(self)weakSelf =self;
    //[self getGroupData];
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        [weakSelf.netDetailView.myRefreshView endRefreshing];
        
    });
    
}

#pragma mark 选择表格
-(void)selectItem:(NetDetailModel *)netDetailModel{
    
    MJWeakSelf
   
    AFViewModel *afViewModel =[AFViewModel new];
    
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSArray * arr =returnValue;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arr.count==0) {
                //数组为空直接跳转安防详情
                AnDetailVC * anDetailVC =[[AnDetailVC alloc]init];
                [self.navigationController pushViewController:anDetailVC animated:YES];
                
                
            }else{
                
                //刷新当前列表
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   NetDetailVC * netDetail =[[NetDetailVC alloc]init];
                   netDetail.dataArr=arr;
                   [weakSelf.navigationController pushViewController:netDetail animated:YES];
                   
                 });
            }
        });
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestGroupData:netDetailModel.dataCustomId];
    
    
}

//
//#pragma mark 查询安防自定义分组
//-(void)getGroupData{
//    
//    
//    MJWeakSelf
//    AFViewModel * afViewModel =[AFViewModel new];
//    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
//        [weakSelf.netDetailView setGroupArr:returnValue];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新，
//            [weakSelf.netDetailView.myTableView reloadData];
//            [weakSelf.netDetailView.myRefreshView  endRefreshing];
//        });
//    } WithErrorBlock:^(id errorCode) {
//        
//    } WithFailureBlock:^{
//        
//    }];
//    
//    [afViewModel requestGroupData:_customId];
//    
//}




-(NetDetailView *)netDetailView{
    
    if (!_netDetailView) {
        _netDetailView =[[NetDetailView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _netDetailView.delegate=self;
        [_netDetailView setGroupArr:_dataArr];
    }
    
    return _netDetailView;
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
