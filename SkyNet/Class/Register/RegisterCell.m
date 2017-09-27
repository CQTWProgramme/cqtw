//
//  RegisterCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RegisterCell.h"

@implementation RegisterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        _typeLabel=[UILabel new];
        _typeLabel.textColor=[UIColor darkGrayColor];
        _typeLabel.font= [UIFont systemFontOfSize:14];
        _typeLabel.textAlignment= NSTextAlignmentLeft;
        
        _inputText=[UITextField new];
        _inputText.backgroundColor=[UIColor clearColor];
        _inputText.borderStyle=UITextBorderStyleNone;
        
        [self.contentView sd_addSubviews:@[_typeLabel, _inputText]];
        
        
        
        _typeLabel.sd_layout
        .widthIs(100)
        .heightIs(30)
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        _inputText.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_typeLabel, 0)
        .rightSpaceToView(self.contentView, 100)
        .heightIs(30);
        
        
        
    }
    return self;
}


@end
