//
//  MCSegmentedButton.m
//  MerchantClient
//
//  Created by Jeffery He on 15/4/20.
//  Copyright (c) 2015年 Chongqing Huizhan Networking Technology. All rights reserved.
//

#import "THCSegmentedButton.h"
#import "UIImage+THCAddtion.h"
#define kRadio 0.95f
#define kSegmentFontSize 16

@interface THCSegmentedButton ()

@property (nonatomic, weak) UIView *dividingView;

@end

@implementation THCSegmentedButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:kSegmentFontSize];
    
    UIView *dividingView = [[UIView alloc] init];
    dividingView.backgroundColor = NAVI_COLOR;
    dividingView.alpha = 0.7f;
    [self addSubview:dividingView];
    self.dividingView = dividingView;
    
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:[UIImage resizedImageWithName:@"bg_navigation_bar"] forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat dividingW = 0.8f;
    CGFloat dividingX = self.width - dividingW;
    CGFloat dividingY = 10.0f;
    CGFloat dividingH = self.frame.size.height - dividingY * 2;
    self.dividingView.frame = CGRectMake(dividingX, dividingY, dividingW, dividingH);
}

- (void)setIsShowDividing:(BOOL)isShowDividing {
    _isShowDividing = isShowDividing;
    self.dividingView.hidden = isShowDividing;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0.0f;
    CGFloat titleY = 0.0f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * kRadio;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 20.0f;
    CGFloat imageY = contentRect.size.height * kRadio;
    CGFloat imageW = contentRect.size.width - imageX * 2;
    CGFloat imageH = contentRect.size.height * (1 - kRadio);
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
