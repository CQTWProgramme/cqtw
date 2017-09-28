//
//  MonitorItemCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitorItemModel.h"
@interface MonitorItemCell : UITableViewCell
//静态构造方法
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) MonitorItemModel *model; //模型属性
- (void)setData: (MonitorItemModel *)model; //设置要显示的数据

@property (nonatomic, copy) void (^deleteAFItem)(); //删除会员block回调方法
@property (nonatomic, copy) void (^editAFItem)();
@property (nonatomic, copy) void (^closeOtherCellSwipe)(); //关闭其他cell的左滑

@property(nonatomic,strong)UILabel     * afContentLabel;
- (void)closeLeftSwipe; //关闭左滑
@end
