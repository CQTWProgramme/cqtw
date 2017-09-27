//
//  MyCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/3.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _logoImageView=[UIImageView new];
        _contentLabel=[UILabel new];
        _contentLabel.textColor=[UIColor darkGrayColor];
        _contentLabel.font= [UIFont systemFontOfSize:15];
        _contentLabel.textAlignment= NSTextAlignmentLeft;
        
        
        
        [self.contentView sd_addSubviews:@[_logoImageView, _contentLabel]];
        
        
        
        _logoImageView.sd_layout
        .widthIs(20)
        .heightEqualToWidth()
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        _contentLabel.sd_layout
        .centerYEqualToView(_logoImageView)
        .leftSpaceToView(_logoImageView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
        
        
    }
    return self;
}


@end
