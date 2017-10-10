//
//  AccessControlDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessControlDetailVC.h"
#import "ACDetailItemCell.h"

static NSString *cellID = @"ACDetailItemCellID";
@interface AccessControlDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation AccessControlDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupColectionView];
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
