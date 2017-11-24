//
//  HomeSearchVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchVC.h"
#import "PYSearch.h"
#import "HomeSearchAFVC.h"
#import "HomeSearchAFDevicesVC.h"
#import "HomeSearchVideoVC.h"
#import "HomeSearchAccessVC.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"

#define kSegmentViewH 44.0f
typedef NS_ENUM(NSInteger, SearchType) {
    SearchAF,
    SearchAFDevices,
    SearchVideo,
    SearchAcess
};

@interface HomeSearchVC ()<MDMultipleSegmentViewDeletegate,
MDFlipCollectionViewDelegate>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)MDMultipleSegmentView *segView;
@property(nonatomic,strong)MDFlipCollectionView *collectView;
@property(nonatomic,assign)SearchType mySearchType;
@end

@implementation HomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self setupTitleView];
    [self createSegment];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showSearchVC];
//    });
}

- (void)setupTitleView {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(35, 10, SCREEN_WIDTH - 150, 30)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleSearchAction:)];
    [searchView addGestureRecognizer:tap];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:@"home_titlesearch"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, 0, searchView.width - 40, searchView.height)];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = @"请输入搜索关键词";
    self.titleLabel = titleLabel;
    
    [searchView addSubview:imageView];
    [searchView addSubview:titleLabel];
    
    self.navigationItem.titleView = searchView;
}

- (void)titleSearchAction:(UITapGestureRecognizer *)tap {
    [self showSearchVC];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)clearAction {
    if ([self.titleLabel.text isEqualToString:@"请输入搜索关键词"]) {
        [STTextHudTool showErrorText:@"搜索内容已清空"];
        return;
    }
    self.titleLabel.text = @"请输入搜索关键词";
}

- (void)showSearchVC {
    MJWeakSelf
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"请输入搜索关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [searchViewController dismissViewControllerAnimated:YES completion:^{
            if ([searchText isEqualToString:@""]) {
                [STTextHudTool showErrorText:@"请输入搜索关键词"];
                return;
            }else {
                weakSelf.titleLabel.text = searchText;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":self.titleLabel.text,@"type":@(self.mySearchType)}];
            }
        }];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)createSegment{
    self.mySearchType = SearchAF;
    [self.view addSubview:self.segView];
    
    HomeSearchAFVC *afVC = [[HomeSearchAFVC alloc]init];
    afVC.view.backgroundColor =[UIColor whiteColor];
    
    HomeSearchAFDevicesVC * deviceVC = [[HomeSearchAFDevicesVC alloc]init];
    deviceVC.view.backgroundColor=[UIColor whiteColor];
    
    HomeSearchVideoVC *viedoVC = [[HomeSearchVideoVC alloc]init];
    viedoVC.view.backgroundColor =[UIColor whiteColor];
    
    HomeSearchAccessVC * accessVC = [[HomeSearchAccessVC alloc]init];
    accessVC.view.backgroundColor=[UIColor whiteColor];
    
    [self addChildViewController:afVC];
    [self addChildViewController:deviceVC];
    
    [self addChildViewController:viedoVC];
    [self addChildViewController:accessVC];
    
    NSArray *arr = @[afVC,deviceVC,viedoVC,accessVC];
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          _segView.bottom,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HEIGHT-_segView.bottom) withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

- (MDMultipleSegmentView *)segView {
    if (!_segView) {
        _segView = [[MDMultipleSegmentView alloc] init];
        _segView.delegate =  self;
        _segView.titleSelectColor = NAVI_COLOR;
        _segView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
        _segView.items = @[@"安防",@"安防设备",@"视频通道",@"门禁"];
    }
    return _segView;
}

- (void)changeSegmentAtIndex:(NSInteger)index
{
    [_collectView selectIndex:index];
    if (index == 0) {
        self.mySearchType = SearchAF;
    }else if (index == 1) {
        self.mySearchType = SearchAFDevices;
    }else if (index == 2) {
        self.mySearchType = SearchVideo;
    }else {
        self.mySearchType = SearchAcess;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":self.titleLabel.text,@"type":@(self.mySearchType)}];
}

- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
