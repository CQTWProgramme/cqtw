//
//  MenuItem.m
//  XDXG
//
//  Created by 冉思路 on 2017/7/8.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(instancetype)init{
    
    self =[super init];
    if (self) {
        
       
    
        _nameLabel=[UILabel new];
        _nameLabel.font= [UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight];
        _nameLabel.textColor=[UIColor darkGrayColor];
        _nameLabel.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        _nameLabel.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .bottomSpaceToView(self,10)
        .heightIs(20);
    
    
        _itemImageView =[UIImageView new];
        _itemImageView.layer.masksToBounds=YES;
        [self addSubview:_itemImageView];
        _itemImageView.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self,10)
        .bottomSpaceToView(_nameLabel,3)
        .widthEqualToHeight();
        _itemImageView.sd_cornerRadiusFromWidthRatio=@(0.5);
        
        
    
    }
    
    return self;
    
}




@end
