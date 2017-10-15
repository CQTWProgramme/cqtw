//
//  NetDetailDistrictCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDetailModel.h"
@interface NetDetailDistrictCell : UITableViewCell
//静态构造方法
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) NetDetailModel *model; //模型属性
- (void)setData: (NetDetailModel *)model; //设置要显示的数据
@property(nonatomic,strong)UILabel     * afContentLabel;
@end
