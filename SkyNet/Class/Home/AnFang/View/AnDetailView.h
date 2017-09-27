//
//  AnDetailView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnDetailView : UIView
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * headTitle;


@property(nonatomic,strong)UIView * numMenuView;
@property(nonatomic,strong)UILabel * zxLabel;
@property(nonatomic,strong)UILabel * lxLabel;
@property(nonatomic,strong)UILabel * bfLabel;
@property(nonatomic,strong)UILabel * cfLabel;
@property(nonatomic,strong)UILabel * bjLabel;

@property(nonatomic,strong)UIView  * bottomView;


@property(nonatomic,strong)UIViewController * currentVC;



-(instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)currentVC;
@end
