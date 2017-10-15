//
//  EquipCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EquipCell.h"

@implementation EquipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _fontView=[UIView new];
        _fontView.backgroundColor=[UIColor grayColor];
        
        _equitTitle=[UILabel new];
        _equitTitle.font =[UIFont systemFontOfSize:14];
        _equitTitle.textAlignment =NSTextAlignmentLeft;
        _equitTitle.textColor=[UIColor darkGrayColor];
        
        _detailText=[UILabel new];
        _detailText.font =[UIFont systemFontOfSize:14];
        _detailText.textAlignment =NSTextAlignmentRight;
        _detailText.textColor=[UIColor darkGrayColor];
        
        
        
        [self.contentView sd_addSubviews:@[_fontView, _equitTitle,_detailText]];
        
        
        
        _fontView.sd_layout
        .widthIs(4)
        .heightEqualToWidth()
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        _fontView.sd_cornerRadius=@(2);
        
        
        
        _equitTitle.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_fontView, 10)
        .rightSpaceToView(self.contentView, 100)
        .heightIs(20);
        
        _detailText.sd_layout
        .centerYEqualToView(self.contentView)
        .widthIs(80)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
    }
    return self;
}

@end
