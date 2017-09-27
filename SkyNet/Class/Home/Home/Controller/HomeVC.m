//
//  HomeVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/20.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeVC.h"
#import "HomeView.h"
#import "HomeViewModel.h"
#import "AnFangVC.h"
@interface HomeVC ()<HomeViewDelegate>
@property(nonatomic,strong)HomeView * homeView;
@end

@implementation HomeVC


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.homeView];
    [self getAdverList];
  
    
}





#pragma mark 获取广告列表
-(void)getAdverList{
    
    MJWeakSelf
    HomeViewModel * homeViewModel =[HomeViewModel new];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
//            [weakSelf.homeView setShortDataArr:returnValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [weakSelf.homeView loadAdScrollImage:returnValue];
            }); 
            
        });
        
        
        
    
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [homeViewModel requestAdverList];
    
}

#pragma mark 获取快捷方式列表
-(void)getShortcutList{
    
     MJWeakSelf
    HomeViewModel * homeViewModel =[HomeViewModel new];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf.homeView setShortDataArr:returnValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [weakSelf.homeView.myTableView reloadData];
            [weakSelf.homeView.myRefreshView  endRefreshing];
        });
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [homeViewModel requestShortcutList];

    
}

-(void)reloadTableView{
    
    __weak typeof(self)weakSelf =self;
    [self getShortcutList];
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        [weakSelf.homeView.myRefreshView endRefreshing];
        
    });

}


-(void)menuClick:(NSInteger)tag{
    
    
    switch (tag) {
        case 0:
        {
            AnFangVC * afVC =[[AnFangVC alloc]init];
            afVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:afVC animated:YES];
        }
            break;
       
        case 1:
        {
            
        }
            break;
        
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}
-(HomeView *)homeView{
    
    if (!_homeView) {
        _homeView =[[HomeView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT-TABBAR_HEIGHT)];
        _homeView.delegate=self;
        
    }
    
    return _homeView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
