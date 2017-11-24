//
//  MonitorDetailListCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorDetailListCell.h"
#import "VideoListModel.h"
@interface MonitorDetailListCell ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MonitorDetailListCell
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
    self.topImageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height *0.6);
    self.nameLabell.frame = CGRectMake(10, self.contentView.frame.size.height *0.6, self.contentView.frame.size.width - 20, self.contentView.frame.size.height *0.25);
    self.timeLabel.frame = CGRectMake(10, self.contentView.frame.size.height *0.85, self.contentView.frame.size.width - 20, self.contentView.frame.size.height *0.15);
}

- (void)setupViews {
    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.nameLabell];
    [self.contentView addSubview:self.timeLabel];
}

-(UIImageView *)topImageView {
    if (nil == _topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = [UIImage imageNamed:@"test"];
    }
    return _topImageView;
}

-(UILabel *)nameLabell {
    if (nil == _nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

-(UILabel *)timeLabel {
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2017.12.13 08:35";
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}

-(void)setModel:(VideoListModel *)model {
    _model = model;
    self.nameLabel.text = _model.jkmc;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_model.play_img] placeholderImage:[UIImage imageNamed:@""]];
}
@end
