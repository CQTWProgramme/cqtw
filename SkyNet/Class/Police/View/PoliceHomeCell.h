//
//  PoliceHomeCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoliceHomeCell : UITableViewCell
@property(nonatomic,strong)UIImageView * signImageView;
@property(nonatomic,strong)UIImageView * timeImageView;
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UILabel     * timeLabel;
@property(nonatomic, strong)UIView *lineView;
@end
