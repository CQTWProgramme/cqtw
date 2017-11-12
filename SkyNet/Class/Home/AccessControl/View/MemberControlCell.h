//
//  MemberControlCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemberControlModel;
@interface MemberControlCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void (^deleteAFItem)(); //删除会员block回调方法
@property (nonatomic, copy) void (^closeOtherCellSwipe)(); //关闭其他cell的左滑
@property (nonatomic, strong)MemberControlModel *model;
- (void)closeLeftSwipe; //关闭左滑
@end
