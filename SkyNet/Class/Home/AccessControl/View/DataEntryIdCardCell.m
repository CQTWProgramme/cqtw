//
//  DataEntryIdCardCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/23.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "DataEntryIdCardCell.h"
#import "IDImagePickModel.h"

@interface DataEntryIdCardCell()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation DataEntryIdCardCell
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
    self.addImageView.frame = CGRectMake((self.width - 15) / 2, (self.height - 10) / 2 - 15, 15, 15);
    self.contentLabel.frame = CGRectMake(0, self.addImageView.bottom + 10, self.contentView.frame.size.width, 15);
    self.deleteButton.frame = CGRectMake(self.width - 30, 0, 30, 30);
}

- (void)setupViews {
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.addImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.deleteButton];
}

-(UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = NAVI_COLOR;
    }
    return _contentLabel;
}

-(UIImageView *)backImageView {
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}

-(UIImageView *)addImageView {
    if (nil == _addImageView) {
        _addImageView = [[UIImageView alloc] init];
        _addImageView.image = [UIImage imageNamed:@"access_main_add"];
        _addImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _addImageView;
}

-(UIButton *)deleteButton {
    if (nil == _deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"access_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(void)setModel:(IDImagePickModel *)model {
    _model = model;
    if (_model.isEmpty) {
        [self addBorderToLayer:self.contentView];
        self.addImageView.hidden = NO;
        self.contentLabel.hidden = NO;
        self.backImageView.hidden = YES;
        self.deleteButton.hidden = YES;
    }else {
        self.addImageView.hidden = YES;
        self.contentLabel.hidden = YES;
        self.backImageView.hidden = NO;
        self.deleteButton.hidden = NO;
    }
    self.contentLabel.text = _model.content;
    if (_model.pickImg) {
        self.backImageView.image = _model.pickImg;
    }
}

- (void)deleteAction {
    if (self.deleteImg) {
        self.deleteImg();
    }
}

- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = NAVI_COLOR.CGColor;
    
    border.fillColor = nil;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:3];
    border.path = path.CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    //  第一个是 线条长度   第二个是间距    nil时为实线
    
    border.lineDashPattern = @[@9, @4];
    
    [view.layer addSublayer:border];
}

@end
