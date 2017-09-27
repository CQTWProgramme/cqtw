//
//  HomeCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _signImageView=[UIImageView new];
        _contentLabel=[UILabel new];
        _contentLabel.textColor=[UIColor darkGrayColor];
        _contentLabel.font= [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment= NSTextAlignmentLeft;
        
       
        
        [self.contentView sd_addSubviews:@[_signImageView, _contentLabel]];
        
        
        
        _signImageView.sd_layout
        .widthIs(40)
        .heightEqualToWidth()
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        _contentLabel.sd_layout
        .centerYEqualToView(_signImageView)
        .leftSpaceToView(_signImageView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
      
        
    }
    return self;
}


@end
