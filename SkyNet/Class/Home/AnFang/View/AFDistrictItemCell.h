//
//  AFDistrictItemCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/7.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFDistrictModel;
@interface AFDistrictItemCell : UITableViewCell
//静态构造方法
+ (instancetype)districtCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) AFDistrictModel *districtModel; //模型属性
@end
