//
//  AccessControlDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessControlDetailVC.h"
#import "ACDetailItemCell.h"
#import "AddVisitorVC.h"

static NSString *cellID = @"ACDetailItemCellID";
@interface AccessControlDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *myPageControl;

@end

@implementation AccessControlDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupColectionView];
    [self createRightItem];
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addNewGroup {
    AddVisitorVC *addVC = [[AddVisitorVC alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)setupColectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 40) / 3, (SCREEN_HEIGHT - 190 - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT) / 3);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(10 + NavigationBar_HEIGHT + STATUS_BAR_HEIGHT, 10, 50, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.myCollectionView setCollectionViewLayout:layout];
    self.myCollectionView.pagingEnabled = YES;
    self.myCollectionView.showsHorizontalScrollIndicator = NO;
    self.myCollectionView.backgroundColor = [UIColor lightGrayColor];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerClass:[ACDetailItemCell class] forCellWithReuseIdentifier:cellID];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.myCollectionView) {
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.myPageControl.currentPage = page;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACDetailItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
