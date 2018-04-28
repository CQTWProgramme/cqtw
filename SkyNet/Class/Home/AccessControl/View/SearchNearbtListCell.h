//
//  SearchNearbtListCell.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchNearbyListModel;
@interface SearchNearbtListCell : UITableViewCell
//静态构造方法
+ (instancetype)searchNearbtListCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) SearchNearbyListModel *model; //模型属性
@end
