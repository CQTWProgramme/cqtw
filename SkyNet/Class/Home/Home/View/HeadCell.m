//
//  HeadCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HeadCell.h"

@implementation HeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _logoImageView=[UIImageView new];
        _quickLabel=[UILabel new];
        _quickLabel.textColor=[UIColor lightGrayColor];
        _quickLabel.font= [UIFont systemFontOfSize:11];
        _quickLabel.textAlignment= NSTextAlignmentLeft;
        _quickLabel.text=@"快捷方式";
        
        
        [self.contentView sd_addSubviews:@[_logoImageView, _quickLabel]];
        
        
        UIImage * image =ImageNamed(@"home_quick_blank");
        _logoImageView.image=image;
        _logoImageView.sd_layout
        .widthIs(10)
        .heightIs(10*image.size.height/image.size.width)
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        _quickLabel.sd_layout
        .centerYEqualToView(_logoImageView)
        .leftSpaceToView(_logoImageView, 5)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
    }
    return self;
}


@end
