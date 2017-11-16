//
//  MCSegmentedView.h
//  MerchantClient
//
//  Created by Jeffery He on 15/4/20.
//  Copyright (c) 2015年 Chongqing Huizhan Networking Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MCSegmentedViewDelegate;

@interface THCSegmentedView : UIView

@property (nonatomic, strong) NSArray *segmentedTitles;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, weak) id<MCSegmentedViewDelegate> segmentDelegate;

@property (nonatomic, strong) NSArray *segmentControllers;

@end

@protocol MCSegmentedViewDelegate <NSObject>

@required
- (void)segmentedViewDidSelected:(THCSegmentedView *)segmentedView fromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
