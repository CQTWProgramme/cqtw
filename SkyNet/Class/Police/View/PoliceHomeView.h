//
//  PoliceHomeView.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PoliceHomeViewDelegate <NSObject>

//上拉刷新
-(void)reloadTableView;

-(void)menuClick:(NSInteger)tag;

@end

@interface PoliceHomeView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView            * headView;//头视图（轮播图+菜单）
@property(nonatomic,strong) SDCycleScrollView * adScrollView;//轮播图
@property(nonatomic,strong) UIScrollView      * menuScrollView;//菜单
@property(nonatomic,strong) UITableView       * myTableView;
@property(nonatomic,strong) NSArray           * shortDataArr;
@property(nonatomic,strong) NSArray           * advArr;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong) id<PoliceHomeViewDelegate> delegate;


-(void)loadAdScrollImage:(NSArray *)imageUrlArr;

@end
