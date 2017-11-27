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
#import "MonitorVC.h"
#import "MonitorDetailListVC.h"
#import "AccessControlVC.h"
#import "VHLNavigation.h"
#import <AVFoundation/AVFoundation.h>
#import "HomeSearchVC.h"
#import "AnDetailVC.h"
#import "ShortcutModel.h"
@interface HomeVC ()<HomeViewDelegate>
@property(nonatomic,strong)HomeView * homeView;
@end

@implementation HomeVC


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    [self vhl_setNavBackgroundColor:[UIColor clearColor]];
    [self vhl_setNavBarBackgroundAlpha:0];
    [self.view addSubview:self.homeView];
    [self createRightItem];
    [self getAdverList];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 0;
    rightBtn.frame=CGRectMake(0 ,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(toSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    //[self.view addSubview:rightBtn];
}

- (void)toSearchAction:(UIButton *)sender {
    HomeSearchVC *searchVC = [[HomeSearchVC alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
//    Class captureDevice = NSClassFromString(@"AVCaptureDevice");
//    if (captureDevice != nil) {
//        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        if ([device hasTorch]) {
//            [device lockForConfiguration:nil];
//            if (sender.tag == 0) {
//                sender.tag = 1;
//                [device setTorchMode:AVCaptureTorchModeOn];
//            }else {
//                sender.tag = 0;
//                [device setTorchMode:AVCaptureTorchModeOff];
//            }
//            [device unlockForConfiguration];
//        }
//    }
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
            MonitorVC *monitorVC = [[MonitorVC alloc] init];
            monitorVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:monitorVC animated:YES];
            
        }
            break;
        
        case 2:
        {
            AccessControlVC *acVC = [[AccessControlVC alloc] init];
            acVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:acVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)cellClickWithShortcutModel:(ShortcutModel *)model {
    AnDetailVC *detailVC = [[AnDetailVC alloc] init];
    detailVC.branchId = model.dataId;
    detailVC.name = model.name;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(HomeView *)homeView{
    
    if (!_homeView) {
        _homeView =[[HomeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
        _homeView.delegate=self;
        
    }
    
    return _homeView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
