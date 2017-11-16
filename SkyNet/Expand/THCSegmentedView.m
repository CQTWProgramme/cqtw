//
//  MCSegmentedView.m
//  MerchantClient
//
//  Created by Jeffery He on 15/4/20.
//  Copyright (c) 2015年 Chongqing Huizhan Networking Technology. All rights reserved.
//

#import "THCSegmentedView.h"
#import "THCSegmentedButton.h"
#define kSegmentViewH 44.0f
#define kMaxShowCount 4 // 最大显示数
#define kMaxItemWidth (ScreenWidth / kMaxShowCount) // item最大宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LightGreenColor RGBColor(9.0f, 173.0f, 136.0f)

@interface THCSegmentedView ()

@property (nonatomic, strong) THCSegmentedButton *selectedButton;

@property (nonatomic, weak) UIView *bottomLine;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation THCSegmentedView

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

- (void)setFrame:(CGRect)frame {
    frame.size.height = kSegmentViewH;
    frame.size.width = ScreenWidth;
    [super setFrame:frame];
}

- (void)setup {
    self.backgroundColor = RGBColor(254.0f, 254.0f, 254.0f);
    // 底部的横线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    CGFloat lineHeight = 1.0f;
    bottomLine.frame = CGRectMake(0.0f, kSegmentViewH - lineHeight, ScreenWidth, lineHeight);
    //[self addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    // 滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, ScreenWidth, kSegmentViewH);
    scrollView.scrollEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setSegmentedTitles:(NSArray *)segmentedTitles {
    _segmentedTitles = segmentedTitles;
    [self setupTitlesWithDataArray:segmentedTitles];
}

- (void)setSegmentControllers:(NSArray *)segmentControllers {
    _segmentControllers = segmentControllers;
    [self setupTitlesWithDataArray:segmentControllers];
}

- (void)setupTitlesWithDataArray:(NSArray *)array {
    NSUInteger count = array.count;
    CGFloat viewWidth = 0;
    if (count > kMaxShowCount) {
        viewWidth = kMaxItemWidth;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(count * kMaxItemWidth, kSegmentViewH);
    } else {
        viewWidth = self.frame.size.width / count;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        id object = array[i];
        NSString *title = nil;
        if ([object isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = object;
            title = controller.title;
        } else if ([object isKindOfClass:[NSString class]]) {
            title = object;
        }
        THCSegmentedButton *button = [THCSegmentedButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        CGFloat buttonX = i * viewWidth;
        CGFloat buttonY = 0.0f;
        CGFloat buttonH = kSegmentViewH;
        button.frame = CGRectMake(buttonX, buttonY, viewWidth, buttonH);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:NAVI_COLOR forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            self.selectedButton = button;
            [self buttonClick:button];
        }
        
        if (i < count) {
            button.isShowDividing = YES;
        }
        [self.scrollView addSubview:button];
    }

}

- (void)buttonClick:(THCSegmentedButton *)button {
    if ([self.segmentDelegate respondsToSelector:@selector(segmentedViewDidSelected:fromIndex:toIndex:)]) {
        [self.segmentDelegate segmentedViewDidSelected:self fromIndex:self.selectedButton.tag toIndex:button.tag];
        self.selectedIndex = button.tag;
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

@end
