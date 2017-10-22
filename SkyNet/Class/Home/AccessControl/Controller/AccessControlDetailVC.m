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

@end

@implementation AccessControlDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"访客登记";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupColectionView];
}

- (void)addNewGroup {
    AddVisitorVC *addVC = [[AddVisitorVC alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
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
            return 5;
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
        cell.content = [NSString stringWithFormat:@"%@-%@小区",@(indexPath.section),@(indexPath.row)];
        cell.isLastCell = NO;
        return cell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (collectionView == self.topCollectionView) {
        AddVisitorVC *addVC = [[AddVisitorVC alloc] init];
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (collectionView == self.bottomCollectionView) {
        NSLog(@"点击了bottom");
    }
}


@end
