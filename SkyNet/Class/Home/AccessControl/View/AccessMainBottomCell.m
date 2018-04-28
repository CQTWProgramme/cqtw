//
//  AccessMainBottomCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessMainBottomCell.h"
#import "ACVillageModel.h"

@interface AccessMainBottomCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *locationImageView;
@end
@implementation AccessMainBottomCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.centerImageView.frame = CGRectMake((self.width - 15) / 2, (self.height - 15) / 2, 15, 15);
    self.contentLabel.frame = CGRectMake(5, 0, self.contentView.frame.size.width - 10, self.height);
    self.locationImageView.frame = CGRectMake(self.width - 30, self.height - 30, 20, 20);
}

- (void)setupViews {
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.centerImageView];
    [self.contentView addSubview:self.locationImageView];
}

-(UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIImageView *)centerImageView {
    if (nil == _centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.image = [UIImage imageNamed:@"access_main_add"];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _centerImageView;
}

-(UIImageView *)locationImageView {
    if (nil == _locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.hidden = YES;
        _locationImageView.image = [UIImage imageNamed:@"location"];
        _locationImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _locationImageView;
}

-(void)setModel:(ACVillageModel *)model {
    _model = model;
    self.contentLabel.text = _model.wdmc;
}

-(void)setIsShowLocation:(BOOL)isShowLocation {
    _isShowLocation = isShowLocation;
    self.locationImageView.hidden = !_isShowLocation;
}

-(void)setIsLastCell:(BOOL)isLastCell {
    _isLastCell = isLastCell;
    self.centerImageView.hidden = !isLastCell;
    self.contentLabel.hidden = isLastCell;
    if (_isLastCell) {
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        [self addLastBorderToLayer:self.contentView];
    }else {
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderWidth = 1;
    }
}

- (void)addLastBorderToLayer:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.cornerRadius = 5;
    border.masksToBounds = YES;
    //  线条颜色
    border.strokeColor = NAVI_COLOR.CGColor;
    
    border.fillColor = nil;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:5];
    border.path = path.CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@9, @4];

    [view.layer addSublayer:border];
}

-(void)setSelected:(BOOL)selected {
    if (selected) {
        _contentLabel.textColor = NAVI_COLOR;
        self.contentView.layer.borderColor = NAVI_COLOR.CGColor;
    }else {
        _contentLabel.textColor = [UIColor blackColor];
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}
@end
