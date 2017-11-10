//
//  AccessManiTopCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessManiTopCell.h"
#import "ACVillageModel.h"

@interface AccessManiTopCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@end
@implementation AccessManiTopCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    self.contentLabel.frame = CGRectMake(0, (self.contentView.height - 15) / 2, self.contentView.frame.size.width, 15);
}

- (void)setupViews {
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.contentLabel];
}

-(UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

-(UIImageView *)backImageView {
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"access_doorcard_back"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}

-(void)setModel:(ACVillageDoorModel *)model {
    _model = model;
    self.contentLabel.text = _model.name;
}
@end
