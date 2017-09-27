//
//  EventCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        _logoImageView=[UIImageView new];
       
        
        _eventTitle=[UILabel new];
        _eventTitle.font =[UIFont systemFontOfSize:14];
        _eventTitle.textAlignment =NSTextAlignmentLeft;
        _eventTitle.textColor=[UIColor darkGrayColor];
        
        _eventContent=[UILabel new];
        _eventContent.font =[UIFont systemFontOfSize:12];
        _eventContent.textAlignment =NSTextAlignmentLeft;
        _eventContent.textColor=[UIColor lightGrayColor];
        
        _createTime=[UILabel new];
        _createTime.font =[UIFont systemFontOfSize:12];
        _createTime.textAlignment =NSTextAlignmentRight;
        _createTime.textColor=[UIColor lightGrayColor];
        
        
        
        [self.contentView sd_addSubviews:@[_logoImageView, _eventTitle,_eventContent,_createTime]];
        
        
        
        _logoImageView.sd_layout
        .widthIs(40)
        .heightEqualToWidth()
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10);
        
        
        
        _eventTitle.sd_layout
        .topEqualToView(_logoImageView)
        .leftSpaceToView(_logoImageView, 10)
        .maxWidthIs(200)
        .heightIs(20);
        
        _eventContent.sd_layout
        .topSpaceToView(_eventTitle, 0)
        .leftEqualToView(_eventTitle)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
        
        _createTime.sd_layout
        .topEqualToView(_eventTitle)
        .rightSpaceToView(self.contentView, 10)
        .widthIs(150)
        .heightIs(20);
        
        
    }
    return self;
}


@end
