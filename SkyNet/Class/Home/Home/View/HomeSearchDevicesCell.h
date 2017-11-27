//
//  HomeSearchDevicesCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultDeviceModel;
@interface HomeSearchDevicesCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)SearchResultDeviceModel *model;
@end
