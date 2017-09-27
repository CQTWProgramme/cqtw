//
//  MessageVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/20.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MessageVC.h"
#import "QBQuSegmentView.h"
#import "SystemMsgVC.h"
#import "AlarmMsgVC.h"
#import "MsgBaseVC.h"
@interface MessageVC ()<UIScrollViewDelegate,QBQuSegmentViewDelegate>

@property(nonatomic,strong)QBQuSegmentView *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    [self.view addSubview:self.mainScrollView];
    
    
    [self.view addSubview:self.segmentView];
    
    [self setupChildVc:[SystemMsgVC class] x:0];
    [self setupChildVc:[AlarmMsgVC class] x:1  * SCREEN_WIDTH];
    
    
}

- (void)setupChildVc:(Class)c x:(CGFloat)x
{
    MsgBaseVC *vc = [c new];
    
    [self.mainScrollView addSubview:vc.view];
    
    vc.view.frame = CGRectMake(x, 45, SCREEN_WIDTH, self.mainScrollView.height-45-TABBAR_HEIGHT);
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
    
    MsgBaseVC *vc = self.childViewControllers[index];
    
    vc.view.frame = CGRectMake(offsetX, 45, SCREEN_WIDTH, self.mainScrollView.height-45-TABBAR_HEIGHT);
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
        _segmentView =[[QBQuSegmentView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, 45) titlesA:@[@"系统消息",@"告警消息"]];
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
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
