//
//  MemberManageVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberManageVC.h"
#import "QBQuSegmentView.h"
#import "MemberApplyVC.h"
#import "MemberControlVC.h"

@interface MemberManageVC ()<UIScrollViewDelegate,QBQuSegmentViewDelegate>
@property(nonatomic,strong)QBQuSegmentView *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;

@end

@implementation MemberManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"成员管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.segmentView];
    [self setupChildVc:[MemberApplyVC class] x:0];
    [self setupChildVc:[MemberControlVC class] x:1  * SCREEN_WIDTH];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MemberManageVCNotification" object:nil userInfo:@{@"type":@(0)}];
}

- (void)setupChildVc:(Class)c x:(CGFloat)x
{
    BaseViewController *vc = [c new];
    
    [self.mainScrollView addSubview:vc.view];
    
    vc.view.frame = CGRectMake(x, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
    [self addChildViewController:vc];
    
}

-(void)QBQuSegmentView:(QBQuSegmentView *)segmentView didSelectBtnAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    
    CGFloat offsetX = index * self.view.frame.size.width;
    // 2.给对应位置添加对应子控制器
    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self showVc:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MemberManageVCNotification" object:nil userInfo:@{@"type":@(index)}];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    BaseViewController *vc = self.childViewControllers[index];
    
    vc.view.frame = CGRectMake(offsetX, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;

        // 1.添加子控制器view
        [self showVc:index];


        // 2.把对应的标题选中
        [self.segmentView titleBtnSelectedWithScrollView:scrollView];
    }

}

-(QBQuSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView =[[QBQuSegmentView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, 45) titlesA:@[@"申请审核",@"成员管理"]];
        _segmentView.backgroundColor =[UIColor whiteColor];
        _segmentView.delegate = self;
    }
    [_segmentView setLineColor:NAVI_COLOR];
    
    return _segmentView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT)];
        _mainScrollView.contentSize = CGSizeMake(2 *SCREEN_WIDTH,0 );
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}


@end
