//
//  ACDistrictItemCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//  门禁默认分组cell

#import <UIKit/UIKit.h>
@class ACDistrictModel;
@interface ACDistrictItemCell : UITableViewCell
//静态构造方法
+ (instancetype)districtCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) ACDistrictModel *districtModel; //模型属性
@end
