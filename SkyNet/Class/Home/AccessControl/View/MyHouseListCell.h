//
//  MyHouseListCell.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyHouseListModel;
@interface MyHouseListCell : UITableViewCell
//静态构造方法
+ (instancetype)myHouseListCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) MyHouseListModel *myHouseListModel; //模型属性
@property (nonatomic, assign) NSInteger index;
@end
