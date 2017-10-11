//
//  PoliceHomeCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PoliceHomeCell.h"

@implementation PoliceHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _signImageView=[UIImageView new];
        
        _timeImageView=[UIImageView new];
        
        _contentLabel=[UILabel new];
        _contentLabel.textColor=[UIColor darkGrayColor];
        _contentLabel.font= [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment= NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        
        _timeLabel=[UILabel new];
        _timeLabel.textColor=[UIColor lightGrayColor];
        _timeLabel.font= [UIFont systemFontOfSize:8];
        _timeLabel.textAlignment= NSTextAlignmentLeft;
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView sd_addSubviews:@[_signImageView, _contentLabel,_timeLabel,_lineView]];
        
        
        _signImageView.sd_layout
        .widthIs(80)
        .heightIs(50)
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        _contentLabel.sd_layout
        .topEqualToView(_signImageView)
        .leftSpaceToView(_signImageView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(40);
        
        _timeImageView.sd_layout
        .widthIs(10)
        .heightIs(10)
        .topSpaceToView(_contentLabel, 10)
        .leftSpaceToView(_signImageView, 10);
        
        _timeLabel.sd_layout
        .centerYEqualToView(_timeImageView)
        .leftSpaceToView(_timeImageView, 5);
        
        _lineView.sd_layout
        .heightIs(1)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0);
    }
    return self;
}

@end
