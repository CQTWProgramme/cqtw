//
//  SearchHistoryCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHistoryCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) NSString *content;
@end
