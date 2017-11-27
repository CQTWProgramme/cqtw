//
//  HomeView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShortcutModel;
@protocol HomeViewDelegate <NSObject>

//上拉刷新
-(void)reloadTableView;

-(void)menuClick:(NSInteger)tag;

-(void)cellClickWithShortcutModel:(ShortcutModel *)model;

@end


@interface HomeView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView            * headView;//头视图（轮播图+菜单）
@property(nonatomic,strong) SDCycleScrollView * adScrollView;//轮播图
@property(nonatomic,strong) UIScrollView      * menuScrollView;//菜单
@property(nonatomic,strong) UITableView       * myTableView;
@property(nonatomic,strong) NSArray           * shortDataArr;
@property(nonatomic,strong) NSArray           * advArr;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong) id<HomeViewDelegate> delegate;


-(void)loadAdScrollImage:(NSArray *)imageUrlArr;
@end
