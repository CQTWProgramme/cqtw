//
//  ACDetailItemCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ACDetailItemCell.h"

@interface ACDetailItemCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ACDetailItemCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(0, (self.contentView.height - 15) / 2, self.contentView.frame.size.width, 15);
}

- (void)setupViews {
    [self.contentView addSubview:self.contentLabel];
}

-(UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

@end
