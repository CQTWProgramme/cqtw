//
//  DistrictSecondCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectDistrictSecondModel;
@interface DistrictSecondCell : UITableViewCell
+ (instancetype)districtSecondCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) SelectDistrictSecondModel *model;
@end
