//
//  AccessManiTopCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessManiTopCell.h"

@interface AccessManiTopCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation AccessManiTopCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor blueColor];
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

-(void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}
@end
