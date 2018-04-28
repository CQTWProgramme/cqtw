//
//  HouseBindListCell.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HouseBindListModel;
@interface HouseBindListCell : UITableViewCell
//静态构造方法
+ (instancetype)myHouseBindListCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) HouseBindListModel *model; //模型属性
@end
