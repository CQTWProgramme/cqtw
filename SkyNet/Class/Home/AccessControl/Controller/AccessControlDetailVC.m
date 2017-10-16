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
#import "AccessManiTopCell.h"
#import "AccessMainBottomCell.h"

static NSString *topCellID = @"DetailAccessManiTopCellID";
static NSString *bottomCellID = @"DetailAccessMainBottomCellID";
@interface AccessControlDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *topTilteLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *topPageControl;

@end

@implementation AccessControlDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门禁";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupColectionView];
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
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 80) / 3, 80);
    layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.topCollectionView setCollectionViewLayout:layout];
    self.topCollectionView.pagingEnabled = YES;
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    [self.topCollectionView registerClass:[AccessManiTopCell class] forCellWithReuseIdentifier:topCellID];
    
    [self.bottomCollectionView setCollectionViewLayout:layout];
    self.bottomCollectionView.pagingEnabled = YES;
    self.bottomCollectionView.showsHorizontalScrollIndicator = NO;
    self.bottomCollectionView.backgroundColor = [UIColor whiteColor];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerClass:[AccessMainBottomCell class] forCellWithReuseIdentifier:bottomCellID];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.topCollectionView) {
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.topPageControl.currentPage = page;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    if (collectionView == self.topCollectionView) {
    //        return 3;
    //    }else if (collectionView == self.bottomCollectionView) {
    //        return 1;
    //    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    if (collectionView == self.topCollectionView) {
    //        return 9;
    //    }else if (collectionView == self.bottomCollectionView) {
    //        return 3;
    //    }
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.topCollectionView) {
        AccessManiTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellID forIndexPath:indexPath];
        cell.content = [NSString stringWithFormat:@"%@-%@门",@(indexPath.section),@(indexPath.row)];
        return cell;
    }else if (collectionView == self.bottomCollectionView) {
        AccessMainBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bottomCellID forIndexPath:indexPath];
        cell.content = [NSString stringWithFormat:@"%@-%@小区",@(indexPath.section),@(indexPath.row)];
        return cell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (collectionView == self.topCollectionView) {
        NSLog(@"点击了top");
    }else if (collectionView == self.bottomCollectionView) {
        NSLog(@"点击了bottom");
    }
}


@end
