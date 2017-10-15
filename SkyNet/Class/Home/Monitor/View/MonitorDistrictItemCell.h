//
//  MonitorDistrictItemCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitorDistrictItemModel.h"
@interface MonitorDistrictItemCell : UITableViewCell
//静态构造方法
+ (instancetype)districtCellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) MonitorDistrictItemModel *model; //模型属性
- (void)setData: (MonitorDistrictItemModel *)model; //设置要显示的数据
@property(nonatomic,strong)UILabel     * afContentLabel;
@end
