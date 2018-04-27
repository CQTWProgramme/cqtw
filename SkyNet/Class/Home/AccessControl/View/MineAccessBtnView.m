//
//  MineAccessBtnView.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/26.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MineAccessBtnView.h"

@implementation MineAccessBtnView
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        
        self.accessImageView = [[UIImageView alloc] init];
        [contentView addSubview:self.accessImageView];

        self.accessLabel = [[UILabel alloc] init];
        self.accessLabel.textColor = [UIColor blackColor];
        self.accessLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:self.accessLabel];
        
        self.remindLabel = [[UILabel alloc] init];
        self.remindLabel.layer.cornerRadius = 10;
        self.remindLabel.layer.masksToBounds = YES;
        self.remindLabel.hidden = YES;
        self.remindLabel.textAlignment = NSTextAlignmentCenter;
        self.remindLabel.textColor = [UIColor whiteColor];
        self.remindLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.remindLabel];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];

        [self.accessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.equalTo(contentView);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
        
        [self.accessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).with.offset(50);
            make.left.equalTo(contentView).with.offset(0);
            make.right.equalTo(contentView).with.offset(0);
            make.bottom.equalTo(contentView).with.offset(0);
        }];
        
        [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(5);
            make.right.equalTo(self).with.offset(-5);
            make.width.equalTo(@(50));
            make.height.equalTo(@(20));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}
@end
