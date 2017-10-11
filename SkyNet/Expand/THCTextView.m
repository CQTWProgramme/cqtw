//
//  THCTextView.m
//  THCFramework
//
//  Created by Jeffery He on 15/2/22.
//  Copyright (c) 2015年 Jeffery He. All rights reserved.
//

#import "THCTextView.h"

@interface THCTextView ()

@property (nonatomic, weak) UILabel *holderLabel;

@end

@implementation THCTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    // 初始化字体，默认为15.0f
    self.font = [UIFont systemFontOfSize:15.0f];
    
    // 初始化UILabel
    [self setupLabel];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewPlaceHolderDidChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

/**
 *  初始化UILabel
 */
- (void)setupLabel {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    // placeHolder的默认颜色为灰色
    label.textColor = [UIColor grayColor];
    [self insertSubview:label atIndex:0];
    self.holderLabel = label;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = [placeHolder copy];
    if (placeHolder.length) {
        self.holderLabel.hidden = NO;
        self.holderLabel.text = _placeHolder;
        // 设置Label的字体和TextView的字体一样
        self.holderLabel.font = self.font;
        NSDictionary *attDic = @{NSFontAttributeName : self.holderLabel.font};
        
        CGFloat labelRectX = 5.0f;
        CGFloat labelRectY = 7.0f;
        CGFloat labelRectW = self.frame.size.width - labelRectX * 2;
        CGFloat labelRectH = self.frame.size.height - labelRectY * 2;
        CGSize labelSizeConstrain = CGSizeMake(labelRectW, labelRectH);
        CGRect labelRect = [_placeHolder boundingRectWithSize:labelSizeConstrain
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:attDic
                                                      context:nil];
        self.holderLabel.frame = CGRectMake(labelRectX, labelRectY, labelRect.size.width, labelRect.size.height);
    } else {
        self.holderLabel.hidden = YES;
    }
}

- (void)setHolderColor:(UIColor *)holderColor {
    _holderColor = holderColor;
    self.holderLabel.textColor = _holderColor;
}

- (void)textViewPlaceHolderDidChanged:(NSNotification *)notification {
    if (self.text.length) {
        self.holderLabel.hidden = YES;
    } else {
        self.holderLabel.hidden = NO;
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolder = self.placeHolder;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
