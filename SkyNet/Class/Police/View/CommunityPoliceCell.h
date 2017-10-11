//
//  CommunityPoliceCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommunityPoliceModel;
@interface CommunityPoliceCell : UITableViewCell
//静态构造方法
+ (instancetype)cellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) CommunityPoliceModel *model;
@end
