//
//  SearchListResultCell.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchListResultModel;
@interface SearchListResultCell : UITableViewCell
//静态构造方法
+ (instancetype)searchListResultCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) SearchListResultModel *model; //模型属性
@end
