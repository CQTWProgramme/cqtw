//
//  AccessDetailCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessDetailModel.h"
@interface AccessDetailCell : UITableViewCell
@property (nonatomic, strong)AccessDetailModel *model;
+ (instancetype)cellWithTableView: (UITableView *)tableView;
@end
