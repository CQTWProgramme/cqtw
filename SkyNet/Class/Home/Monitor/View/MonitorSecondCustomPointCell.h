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
@property (nonatomic, copy) void (^deleteAFItem)(); //删除会员block回调方法
@property (nonatomic, copy) void (^closeOtherCellSwipe)(); //关闭其他cell的左滑
- (void)closeLeftSwipe; //关闭左滑
@end
