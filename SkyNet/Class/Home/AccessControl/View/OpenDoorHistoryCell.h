//
//  OpenDoorHistoryCell.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OpenDoorHistoryModel;
@interface OpenDoorHistoryCell : UITableViewCell
//静态构造方法
+ (instancetype)openDoorHistoryCellWithTableView: (UITableView *)tableView;
@property (nonatomic, strong) OpenDoorHistoryModel *openDoorModel; //模型属性
@end
