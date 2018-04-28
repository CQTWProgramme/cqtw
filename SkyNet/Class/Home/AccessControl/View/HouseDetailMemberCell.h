//
//  HouseDetailMemberCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HouseDetailMemberModel;
@interface HouseDetailMemberCell : UITableViewCell
//静态构造方法
+ (instancetype)myHouseDetailMemberCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) HouseDetailMemberModel *model; //模型属性
@end
