//
//  NetDetailView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDetailModel.h"
@class NetDetailDistrictModel;
typedef void (^UpdateCellBlock)();
typedef void (^ModifyNameBlock)(NSString * groupName);
@protocol NetDetailViewDelegate <NSObject>

////上拉刷新
//-(void)reloadTableView;

//删除分组
-(void)deleteNetDetailGroup:(NSString *)customId
    updateCellBlock:(UpdateCellBlock)block;
//删除网点
-(void)deleteNetDetailItem:(NSString *)customId
            updateCellBlock:(UpdateCellBlock)block;

////编辑分组
-(void)editNetDetailGroup:(NSString *)customId
                groupName:(NSString *)groupName
          modifyNameBlock:(ModifyNameBlock)block;

//选择分组
-(void)selectItem:(NetDetailModel *)netDetailModel;

//选择分组
-(void)districtSelectItem:(NetDetailDistrictModel *)netDetailModel;
@end
@interface NetDetailView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView       * myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong)   NSMutableArray           * groupArr;
@property(nonatomic,strong) id<NetDetailViewDelegate> delegate;
@property (nonatomic, assign) NSInteger type;

@end
