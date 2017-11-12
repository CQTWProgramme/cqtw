//
//  RecordVisitorCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordVisitorModel.h"
@interface RecordVisitorCell : UITableViewCell
@property (nonatomic, strong)RecordVisitorModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
