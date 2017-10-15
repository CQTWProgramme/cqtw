//
//  NetDetailCell.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NetDetailDistrictModel;
@interface NetDetailCell : UITableViewCell
//静态构造方法
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, copy) void (^deleteAFItem)(); //删除会员block回调方法
@property (nonatomic, copy) void (^editAFItem)();
@property (nonatomic, copy) void (^closeOtherCellSwipe)(); //关闭其他cell的左滑
@property (nonatomic, strong) NetDetailDistrictModel *model; //模型属性
- (void)setData: (NetDetailDistrictModel *)model; //设置要显示的数据
@property(nonatomic,strong)UILabel     * afContentLabel;
- (void)closeLeftSwipe; //关闭左滑
@end
