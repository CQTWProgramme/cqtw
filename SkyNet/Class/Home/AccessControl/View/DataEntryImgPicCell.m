//
//  DataEntryImgPicCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/23.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "DataEntryImgPicCell.h"

@interface DataEntryImgPicCell ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation DataEntryImgPicCell
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
    self.addImageView.frame = CGRectMake((self.width - 13) / 2, (self.height - 13) / 2, 13, 13);
    self.deleteButton.frame = CGRectMake(self.width - 15, 0, 15, 15);
}

- (void)setupViews {
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.addImageView];
    [self.contentView addSubview:self.deleteButton];
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
        _addImageView.image = [UIImage imageNamed:@"data_entry_add"];
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

-(void)setIsLast:(BOOL)isLast {
    _isLast = isLast;
    if (_isLast) {
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        [self addBorderToLayer:self.contentView];
        self.addImageView.hidden = NO;
        self.backImageView.hidden = YES;
        self.deleteButton.hidden = YES;
    }else {
        self.contentView.layer.borderColor = NAVI_COLOR.CGColor;
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderWidth = 1;
        self.addImageView.hidden = YES;
        self.backImageView.hidden = NO;
        self.deleteButton.hidden = NO;
    }
    
}

- (void)deleteAction {
    if (self.deleteImg) {
        self.deleteImg();
    }
}

-(void)setImg:(UIImage *)img {
    _img = img;
    self.backImageView.image = _img;
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
