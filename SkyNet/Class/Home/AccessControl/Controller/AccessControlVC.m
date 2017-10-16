//
//  AccessControlVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessControlVC.h"
#import "QBQuSegmentView.h"
#import "AccessMainVC.h"
#import "AccessRecordVC.h"
#import "MemberManageVC.h"
#import "AccessControlDetailVC.h"

#define BottomButtonH 80

@interface AccessControlVC ()<UIScrollViewDelegate,QBQuSegmentViewDelegate>
@property(nonatomic,strong)QBQuSegmentView *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@end

@implementation AccessControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门禁";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.segmentView];
    [self setupBottomButton];
    
    [self setupChildVc:[AccessMainVC class] x:0];
    [self setupChildVc:[AccessRecordVC class] x:1  * SCREEN_WIDTH];
}

- (void)setupBottomButton {
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.layer.cornerRadius = BottomButtonH / 2;
    bottomButton.layer.masksToBounds = YES;
    bottomButton.backgroundColor = [UIColor redColor];
    bottomButton.frame = CGRectMake((SCREEN_WIDTH - BottomButtonH) / 2, SCREEN_HEIGHT - 90, BottomButtonH, BottomButtonH);
    [bottomButton setTitle:@"访客" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(toDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bottomButton];
}

- (void)toDetailAction {
    AccessControlDetailVC *detailVC = [[AccessControlDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"成员管理" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(memberMangeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

//成员管理
- (void)memberMangeAction {
    MemberManageVC *manageVC = [[MemberManageVC alloc] init];
    [self.navigationController pushViewController:manageVC animated:YES];
}

-(QBQuSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView =[[QBQuSegmentView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, 45) titlesA:@[@"门禁",@"记录"]];
        _segmentView.backgroundColor =[UIColor whiteColor];
        _segmentView.delegate = self;
    }
    [_segmentView setLineColor:NAVI_COLOR];
    
    return _segmentView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT - 100)];
        _mainScrollView.contentSize = CGSizeMake(2 *SCREEN_WIDTH,0 );
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

@end
