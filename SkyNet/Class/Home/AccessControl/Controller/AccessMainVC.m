//
//  AccessMainVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessMainVC.h"
#import "AccessMainBottomCell.h"
#import "AccessManiTopCell.h"
#import "AccessControlDetailVC.h"
#import "ChooseDistrictFirstVC.h"

#define BottomButtonH 80

static NSString *topCellID = @"AccessManiTopCellID";
static NSString *bottomCellID = @"AccessMainBottomCellID";
@interface AccessMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *topTitleLabel;

@end

@implementation AccessMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupColectionView];
    [self setupBottomButton];
}

- (void)setupBottomButton {
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.layer.cornerRadius = BottomButtonH / 2;
    bottomButton.layer.masksToBounds = YES;
    [bottomButton setBackgroundImage:[UIImage imageNamed:@"access_visitor"] forState:UIControlStateNormal];
    bottomButton.frame = CGRectMake(SCREEN_WIDTH - BottomButtonH - 20, SCREEN_HEIGHT - 135 - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT, BottomButtonH, BottomButtonH);
    [bottomButton addTarget:self action:@selector(toDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)toDetailAction {
    AccessControlDetailVC *detailVC = [[AccessControlDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)setupColectionView {
    UICollectionViewFlowLayout *topLayout = [[UICollectionViewFlowLayout alloc] init];
    topLayout.itemSize = CGSizeMake(120, 80);
    topLayout.minimumLineSpacing = 10;
    topLayout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
    topLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionViewFlowLayout *bottomLayout = [[UICollectionViewFlowLayout alloc] init];
    bottomLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 60) / 3, 60);
    bottomLayout.minimumLineSpacing = 15;
    bottomLayout.minimumInteritemSpacing = 15;
    bottomLayout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
    bottomLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.topCollectionView setCollectionViewLayout:topLayout];
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    self.topCollectionView.backgroundColor = [UIColor clearColor];
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    [self.topCollectionView registerClass:[AccessManiTopCell class] forCellWithReuseIdentifier:topCellID];
    
    [self.bottomCollectionView setCollectionViewLayout:bottomLayout];
    self.bottomCollectionView.pagingEnabled = YES;
    self.bottomCollectionView.showsHorizontalScrollIndicator = NO;
    self.bottomCollectionView.backgroundColor = [UIColor whiteColor];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerClass:[AccessMainBottomCell class] forCellWithReuseIdentifier:bottomCellID];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.topCollectionView) {
        return 1;
    }else if (collectionView == self.bottomCollectionView) {
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.topCollectionView) {
        return 6;
    }else if (collectionView == self.bottomCollectionView) {
        return 6;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.topCollectionView) {
        AccessManiTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellID forIndexPath:indexPath];
        cell.content = [NSString stringWithFormat:@"%@-%@门",@(indexPath.section),@(indexPath.row)];
        return cell;
    }else if (collectionView == self.bottomCollectionView) {
        AccessMainBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bottomCellID forIndexPath:indexPath];
        if (indexPath.row < 5) {
            cell.content = [NSString stringWithFormat:@"%@-%@小区",@(indexPath.section),@(indexPath.row)];
            cell.isLastCell = NO;
        }else {
            cell.isLastCell = YES;
        }
        return cell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    if (collectionView == self.topCollectionView) {
        NSLog(@"点击了top");
    }else if (collectionView == self.bottomCollectionView) {
        ChooseDistrictFirstVC *firstVC = [[ChooseDistrictFirstVC alloc] init];
        [self.navigationController pushViewController:firstVC animated:YES];
    }
}

@end
