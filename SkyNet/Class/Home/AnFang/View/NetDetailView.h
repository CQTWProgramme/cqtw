//
//  NetDetailView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDetailModel.h"
typedef void (^UpdateCellBlock)();
typedef void (^ModifyNameBlock)(NSString * groupName);
@protocol NetDetailViewDelegate <NSObject>

//上拉刷新
-(void)reloadTableView;

//删除分组
-(void)deleteAFItem:(NSString *)customId
    updateCellBlock:(UpdateCellBlock)block;

//编辑分组
-(void)editAFItem:(NSString *)customId
        groupName:(NSString *)groupName
  modifyNameBlock:(ModifyNameBlock)block;

//选择分组
-(void)selectItem:(NetDetailModel *)netDetailModel;

@end
@interface NetDetailView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView       * myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong)   NSArray           * groupArr;
@property(nonatomic,strong) id<NetDetailViewDelegate> delegate;

@end
