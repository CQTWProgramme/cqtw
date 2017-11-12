//
//  DistrictFirstCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectDistrictFirstModel;
@interface DistrictFirstCell : UITableViewCell
+ (instancetype)districtFirstCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) SelectDistrictFirstModel *model;
@end
