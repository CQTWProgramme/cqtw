//
//  AnDetailView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AnDetailView.h"
#import "AFViewModel.h"
#import "LxButton.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "EquipmentVC.h"
#import "EventVC.h"
@interface AnDetailView()<MDMultipleSegmentViewDeletegate,
MDFlipCollectionViewDelegate>
@property(nonatomic,strong)MDMultipleSegmentView *segView;
@property(nonatomic,strong)MDFlipCollectionView *collectView;


@end
@implementation AnDetailView

-(instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)currentVC{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.currentVC =currentVC;
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self createHeadView];
        [self createNumMenuView];
        [self createBottomView];
        [self createSegment];
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
    
    UIButton * netDetailBtn =[UIButton new];
    [_headView addSubview:netDetailBtn];
    [netDetailBtn setBackgroundColor:[UIColor clearColor]];
    netDetailBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [netDetailBtn setTitle:@"网点详情" forState:UIControlStateNormal];
    netDetailBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [netDetailBtn setTitleColor:RGB(110, 217, 252) forState:UIControlStateNormal];
    netDetailBtn.sd_layout
    .rightSpaceToView(_headView, 10)
    .topSpaceToView(_headView, 10)
    .heightIs(30)
    .widthIs(100);

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
    zxL.text=@"在线";
    zxL.textAlignment=NSTextAlignmentCenter;
    zxL.font=[UIFont systemFontOfSize:13];
    zxL.textColor =[UIColor grayColor];
    
    UILabel * lxL =[UILabel new];
    lxL.text=@"离线";
    lxL.textAlignment=NSTextAlignmentCenter;
    lxL.font=[UIFont systemFontOfSize:13];
    lxL.textColor =[UIColor grayColor];
    
    UILabel * bfL =[UILabel new];
    bfL.text=@"布防";
    bfL.textAlignment=NSTextAlignmentCenter;
    bfL.font=[UIFont systemFontOfSize:13];
    bfL.textColor =[UIColor grayColor];
    
    UILabel * cfL =[UILabel new];
    cfL.text=@"撤防";
    cfL.textAlignment=NSTextAlignmentCenter;
    cfL.font=[UIFont systemFontOfSize:13];
    cfL.textColor =[UIColor grayColor];
    
    UILabel * bjL =[UILabel new];
    bjL.text=@"报警";
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


-(void)createBottomView{
    
    _bottomView =[UIView new];
    _bottomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_bottomView];
    _bottomView.sd_layout
    .leftEqualToView(self)
    .bottomEqualToView(self)
    .rightEqualToView(self)
    .heightIs(60);
    
    for (int i=0; i<3; i++) {
        
        NSArray * titleA=@[@"布防",@"撤防",@"消警"];
        NSArray * imageArr=@[@"bf",@"home_monitor",@"xj"];
        UILabel * label =[UILabel new];
        [_bottomView addSubview:label];
        label.text=titleA[i];
        label.textColor=[UIColor hexStringToColor:@"#3c3c3c"];
        label.textAlignment=NSTextAlignmentCenter;
        label.sd_layout
        .leftSpaceToView(_bottomView, i*SCREEN_WIDTH/3)
        .bottomSpaceToView(_bottomView, 10)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(15);
        
        
        
        UIButton * btn =[UIButton new];
        [_bottomView addSubview:btn];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
         btn.tag =1000+ i;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .centerXEqualToView(label)
        .widthIs(26)
        .heightEqualToWidth();
        btn.sd_cornerRadius=@(13);
    
    
    }


    
    
    

}




-(void)createSegment{
    
    [self addSubview:self.segView];
    
    EquipmentVC * equiVC =[[EquipmentVC alloc]init];
    equiVC.view.backgroundColor =[UIColor whiteColor];
    
    EventVC * eventVC = [[EventVC alloc]init];
    eventVC.view.backgroundColor=[UIColor whiteColor];
    
    NSArray *arr = @[equiVC,eventVC];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          _segView.bottom,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HEIGHT-_segView.bottom-NavigationBar_HEIGHT-STATUS_BAR_HEIGHT-61) withArray:arr];
    _collectView.delegate = self;
    [self addSubview:_collectView];
    
    
}

- (MDMultipleSegmentView *)segView {
    if (!_segView) {
        _segView = [[MDMultipleSegmentView alloc] init];
        _segView.delegate =  self;
        _segView.frame = CGRectMake(0, 250, SCREEN_WIDTH, 44);
        _segView.items = @[@"设备",@"事件"];
    }
    return _segView;
}

- (void)changeSegmentAtIndex:(NSInteger)index
{
    [_collectView selectIndex:index];
}


- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
}



@end
