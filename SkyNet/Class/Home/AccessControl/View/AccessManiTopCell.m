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
@property (nonatomic, strong) UILabel *bottomtLabel;
@property (nonatomic, strong) UIImageView *centerImageView;
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
    MJWeakSelf
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@5);
        make.right.bottom.equalTo(@-5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentLabel.mas_left).with.offset(-10);
    }];
    
    [self.bottomtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-20);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-20);
    }];
    
    
    self.backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    self.contentLabel.frame = CGRectMake(0, (self.contentView.height - 15) / 2, self.contentView.frame.size.width, 15);
}

- (void)setupViews {
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.centerImageView];
    [self.contentView addSubview:self.bottomtLabel];
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

-(UILabel *)bottomtLabel {
    if (nil == _bottomtLabel) {
        _bottomtLabel = [[UILabel alloc] init];
        _bottomtLabel.textAlignment = NSTextAlignmentCenter;
        _bottomtLabel.font = [UIFont systemFontOfSize:14];
        _bottomtLabel.textColor = [UIColor whiteColor];
    }
    return _bottomtLabel;
}

-(UIImageView *)backImageView {
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"access_doorcard_back"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}

-(UIImageView *)centerImageView {
    if (nil == _centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.image = [UIImage imageNamed:@"access_lock"];
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _centerImageView;
}

-(void)setModel:(ACVillageDoorModel *)model {
    _model = model;
    self.contentLabel.text = _model.name;
    
}

-(void)setBottomContent:(NSString *)bottomContent {
    _bottomContent = bottomContent;
    self.bottomtLabel.text = _bottomContent;
}
@end
