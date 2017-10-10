//
//  ACItemCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//  门禁自定义分组cell

#import <UIKit/UIKit.h>
@class ACModel;
@interface ACItemCell : UITableViewCell
//静态构造方法
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) ACModel *model; //模型属性

@property (nonatomic, copy) void (^deleteAFItem)(); //删除会员block回调方法
@property (nonatomic, copy) void (^editAFItem)();
@property (nonatomic, copy) void (^closeOtherCellSwipe)(); //关闭其他cell的左滑

@property(nonatomic,strong)UILabel     * afContentLabel;
- (void)closeLeftSwipe; //关闭左滑

@end
