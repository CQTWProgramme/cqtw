//
//  LatticePointDetailHeaderView.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LatticePointDetailHeaderView.h"
#import "AFViewModel.h"

@interface LatticePointDetailHeaderView ()
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * headTitle;
@property(nonatomic,strong)UIView * numMenuView;
@property(nonatomic,strong)UILabel * zxLabel;
@property(nonatomic,strong)UILabel * lxLabel;
@property(nonatomic,strong)UILabel * bfLabel;
@property(nonatomic,strong)UILabel * cfLabel;
@property(nonatomic,strong)UILabel * bjLabel;
@end
@implementation LatticePointDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createHeadView];
        [self createNumMenuView];
    }
    return self;
}

-(void)createHeadView{
    
    _headView =[UIView new];
    
    [self addSubview:_headView];
    _headView.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(180);
    [_headView.layer addSublayer:[AFViewModel getDefaultLayerWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)]];
    
    _headImageView =[UIImageView new];
    [_headView addSubview:_headImageView];
    _headImageView.image=ImageNamed(@"home_monitor");
    _headImageView.sd_layout
    .centerXEqualToView(_headView)
    .centerYEqualToView(_headView)
    .heightIs(60)
    .widthEqualToHeight();
    _headImageView.sd_cornerRadius=@(30);
    
    _headTitle =[UILabel new];
    [_headView addSubview:_headTitle];
    _headTitle.textAlignment=NSTextAlignmentCenter;
    _headTitle.textColor =[UIColor whiteColor];
    _headTitle.font =[UIFont systemFontOfSize:16];
    _headTitle.sd_layout
    .topSpaceToView(_headImageView, 5)
    .leftEqualToView(_headView)
    .rightEqualToView(_headView)
    .heightIs(20);
    
}

-(void)createNumMenuView{
    
    _numMenuView =[UIView new];
    _numMenuView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_numMenuView];
    _numMenuView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_headView, 0)
    .heightIs(60);
    
    _zxLabel =[UILabel new];
    _zxLabel.textAlignment=NSTextAlignmentCenter;
    _zxLabel.font=[UIFont systemFontOfSize:15];
    _zxLabel.textColor = RGB(230, 155, 0);
    
    _lxLabel =[UILabel new];
    _lxLabel.textAlignment=NSTextAlignmentCenter;
    _lxLabel.font=[UIFont systemFontOfSize:15];
    _lxLabel.textColor = RGB(230, 155, 0);
    
    _bfLabel =[UILabel new];
    _bfLabel.textAlignment=NSTextAlignmentCenter;
    _bfLabel.font=[UIFont systemFontOfSize:15];
    _bfLabel.textColor = RGB(230, 155, 0);
    
    _cfLabel =[UILabel new];
    _cfLabel.textAlignment=NSTextAlignmentCenter;
    _cfLabel.font=[UIFont systemFontOfSize:15];
    _cfLabel.textColor = RGB(230, 155, 0);
    
    _bjLabel =[UILabel new];
    _bjLabel.textAlignment=NSTextAlignmentCenter;
    _bjLabel.font=[UIFont systemFontOfSize:15];
    _bjLabel.textColor = RGB(230, 155, 0);
    
    
    UILabel * zxL =[UILabel new];
    zxL.text=@"安防设备";
    zxL.textAlignment=NSTextAlignmentCenter;
    zxL.font=[UIFont systemFontOfSize:13];
    zxL.textColor =[UIColor grayColor];
    
    UILabel * lxL =[UILabel new];
    lxL.text=@"门禁";
    lxL.textAlignment=NSTextAlignmentCenter;
    lxL.font=[UIFont systemFontOfSize:13];
    lxL.textColor =[UIColor grayColor];
    
    UILabel * bfL =[UILabel new];
    bfL.text=@"监控";
    bfL.textAlignment=NSTextAlignmentCenter;
    bfL.font=[UIFont systemFontOfSize:13];
    bfL.textColor =[UIColor grayColor];
    
    UILabel * cfL =[UILabel new];
    cfL.text=@"消防";
    cfL.textAlignment=NSTextAlignmentCenter;
    cfL.font=[UIFont systemFontOfSize:13];
    cfL.textColor =[UIColor grayColor];
    
    UILabel * bjL =[UILabel new];
    bjL.text=@"对讲";
    bjL.textAlignment=NSTextAlignmentCenter;
    bjL.font=[UIFont systemFontOfSize:13];
    bjL.textColor =[UIColor grayColor];
    
    
    [_numMenuView sd_addSubviews:@[_zxLabel,zxL,_lxLabel,lxL,_bfLabel,bfL,_cfLabel,cfL,_bjLabel,bjL]];
    
    
    _zxLabel.sd_layout
    .leftEqualToView(_numMenuView)
    .topSpaceToView(_numMenuView, 10)
    .widthRatioToView(_numMenuView, 0.2)
    .heightIs(20);
    
    _lxLabel.sd_layout
    .leftSpaceToView(_zxLabel, 0)
    .topSpaceToView(_numMenuView, 10)
    .widthRatioToView(_numMenuView, 0.2)
    .heightIs(20);
    
    _bfLabel.sd_layout
    .leftSpaceToView(_lxLabel, 0)
    .topSpaceToView(_numMenuView, 10)
    .widthRatioToView(_numMenuView, 0.2)
    .heightIs(20);
    
    _cfLabel.sd_layout
    .leftSpaceToView(_bfLabel, 0)
    .topSpaceToView(_numMenuView, 10)
    .widthRatioToView(_numMenuView, 0.2)
    .heightIs(20);
    
    _bjLabel.sd_layout
    .leftSpaceToView(_cfLabel, 0)
    .topSpaceToView(_numMenuView, 10)
    .widthRatioToView(_numMenuView, 0.2)
    .heightIs(20);
    
    zxL.sd_layout
    .centerXEqualToView(_zxLabel)
    .topSpaceToView(_zxLabel, 0)
    .widthRatioToView(_zxLabel, 1)
    .heightRatioToView(_zxLabel, 1);
    
    lxL.sd_layout
    .centerXEqualToView(_lxLabel)
    .topSpaceToView(_lxLabel, 0)
    .widthRatioToView(_lxLabel, 1)
    .heightRatioToView(_lxLabel, 1);
    
    bfL.sd_layout
    .centerXEqualToView(_bfLabel)
    .topSpaceToView(_bfLabel, 0)
    .widthRatioToView(_bfLabel, 1)
    .heightRatioToView(_bfLabel, 1);
    
    cfL.sd_layout
    .centerXEqualToView(_cfLabel)
    .topSpaceToView(_cfLabel, 0)
    .widthRatioToView(_cfLabel, 1)
    .heightRatioToView(_cfLabel, 1);
    
    bjL.sd_layout
    .centerXEqualToView(_bjLabel)
    .topSpaceToView(_bjLabel, 0)
    .widthRatioToView(_bjLabel, 1)
    .heightRatioToView(_bjLabel, 1);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
