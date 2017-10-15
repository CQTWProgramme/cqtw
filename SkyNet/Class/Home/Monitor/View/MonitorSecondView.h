//
//  MonitorSecondView.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonitorSecondPointModel;
@class MonitorSecondGroupModel;
typedef void (^UpdateCellBlock)();
typedef void (^ModifyNameBlock)(NSString * groupName);
@protocol MonitorSecondViewDelegate <NSObject>

//删除分组
-(void)deleteMonitorSecondGroup:(NSString *)customId
                updateCellBlock:(UpdateCellBlock)block;
//删除网点
-(void)deleteMonitorSecondpoint:(NSString *)customId
                updateCellBlock:(UpdateCellBlock)block;

////编辑分组
-(void)editMonitorSecondGroup:(NSString *)customId
                    groupName:(NSString *)groupName
              modifyNameBlock:(ModifyNameBlock)block;

//选择分组
-(void)selectGroup:(MonitorSecondGroupModel *)groupModel;

//选择网点
-(void)selectPoint:(MonitorSecondPointModel *)pointModel;
@end

@interface MonitorSecondView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView       * myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,strong)   NSMutableArray           * groupArr;
@property(nonatomic,strong) id<MonitorSecondViewDelegate> delegate;
@property (nonatomic, assign) NSInteger type;

@end
