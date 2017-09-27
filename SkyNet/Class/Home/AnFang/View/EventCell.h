//
//  EventCell.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property(nonatomic,strong)UIImageView * logoImageView;
@property(nonatomic,strong)UILabel * eventTitle;
@property(nonatomic,strong)UILabel * eventContent;
@property(nonatomic,strong)UILabel * createTime;
@end
