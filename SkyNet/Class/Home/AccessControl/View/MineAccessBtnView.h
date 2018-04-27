//
//  MineAccessBtnView.h
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/26.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^mineAccessBtnActionBlock) (void);
/**
 我的门禁页面的功能按钮
 */
@interface MineAccessBtnView : UIView
@property (nonatomic, strong) UIImageView *accessImageView;
@property (nonatomic, strong) UILabel *accessLabel;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, copy) mineAccessBtnActionBlock btnActionBlock;
@end
