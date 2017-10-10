//
//  ACVIew.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UpdateCellBlock)();
typedef void (^ModifyNameBlock)(NSString * groupName);
@protocol ACViewDelegate <NSObject>

////上拉刷新
//-(void)reloadTableView;
//
//删除分组
-(void)deleteACItem:(NSString *)customId
    updateCellBlock:(UpdateCellBlock)block;

//编辑分组
-(void)editACItem:(NSString *)customId
        groupName:(NSString *)groupName
  modifyNameBlock:(ModifyNameBlock)block;

////选择分组
//-(void)selectItem:(AFModel *)afModel;

//选择分组传Id
-(void)selectItem:(NSString *)itemId name:(NSString *)name section:(NSInteger )section;

@end

@interface ACVIew : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView       * myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong)   NSMutableArray           * groupArr;
@property(nonatomic,strong) id<ACViewDelegate> delegate;

@end
