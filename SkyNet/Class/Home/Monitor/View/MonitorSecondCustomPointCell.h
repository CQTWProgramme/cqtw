//
//  MonitorSecondCustomPointCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonitorSecondPointModel;
@interface MonitorSecondCustomPointCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) MonitorSecondPointModel *model;
@end
