//
//  AccessMainBottomCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessMainBottomCell.h"
@interface AccessMainBottomCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *centerImageView;
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
    self.contentLabel.frame = CGRectMake(0, (self.contentView.height - 15) / 2, self.contentView.frame.size.width, 15);
}

- (void)setupViews {
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.centerImageView];
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

-(UIImageView *)centerImageView {
    if (nil == _centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.image = [UIImage imageNamed:@"access_main_add"];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _centerImageView;
}

-(void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}

-(void)setIsLastCell:(BOOL)isLastCell {
    _isLastCell = isLastCell;
    self.centerImageView.hidden = !isLastCell;
    self.contentLabel.hidden = isLastCell;
    [self addBorderToLayer:self.contentView];
}

- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.cornerRadius = 2;
    border.masksToBounds = YES;
    //  线条颜色
    if (_isLastCell) {
        border.strokeColor = [UIColor blueColor].CGColor;
    }else {
        border.strokeColor = [UIColor lightGrayColor].CGColor;
    }
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"round";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    if (_isLastCell) {
        border.lineDashPattern = @[@9, @4];
    }else {
        border.lineDashPattern = nil;
    }
    
    [view.layer addSublayer:border];
}

@end
