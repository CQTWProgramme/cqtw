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
#import "DataEntryVC.h"
#import <MapKit/MapKit.h>
#import "ACViewModel.h"
#import "ACVillageModel.h"
#import "DataEntryVC.h"

#define BottomButtonH 80

static NSString *topCellID = @"AccessManiTopCellID";
static NSString *bottomCellID = @"AccessMainBottomCellID";
@interface AccessMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ACVillageModel *topModel;

@end

@implementation AccessMainVC

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupColectionView];
    [self setupBottomButton];
}

-(void)viewWillAppear:(BOOL)animated {
    [self isNeedCertification];
}

- (void)isNeedCertification {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isEqualToString:@"0"]) {
            [self showCertificationAlert];
        }else {
            [self startLocation];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel IsNeedRealNameConfirm];
}

- (void)showCertificationAlert {
    MJWeakSelf
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否现在上传身份信息,以便进行房屋认证?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        DataEntryVC *dataVC = [[DataEntryVC alloc] init];
        [weakSelf.navigationController pushViewController:dataVC animated:YES];
    
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [weakSelf startLocation];
    }]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)startLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >8.0){
        [self.locationManager requestAlwaysAuthorization];
         [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }break;
            default:break;
    }
}

 - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
     if (locations) {
         [self.locationManager stopUpdatingLocation];
         CLLocation *newLocation = locations[0];
         NSString *latitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.latitude)];
         NSString *longitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.longitude)];
         [self loadDataWithLatitude:latitude Longitude:longitude];
     }else {
         [STTextHudTool showErrorText:@"定位失败"];
     }
 }

- (void)loadDataWithLatitude:(NSString *)latitude Longitude:(NSString *)longitude {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        self.dataArray = returnValue;
        if (self.dataArray.count > 0) {
            self.topModel = self.dataArray[0];
            self.topTitleLabel.text = self.topModel.wdmc;
            [self.topCollectionView reloadData];
            [self.bottomCollectionView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [viewModel requestDataWithLatitude:latitude Longitude:longitude];
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
        return self.topModel.doorInfo.count;
    }else if (collectionView == self.bottomCollectionView) {
        return self.dataArray.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.topCollectionView) {
        AccessManiTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellID forIndexPath:indexPath];
        cell.model = self.topModel.doorInfo[indexPath.row];
        return cell;
    }else if (collectionView == self.bottomCollectionView) {
        AccessMainBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bottomCellID forIndexPath:indexPath];
        
        if (indexPath.row < (self.dataArray.count - 1)) {
            cell.model = self.dataArray[indexPath.row + 1];
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
        ACVillageDoorModel *model = self.topModel.doorInfo[indexPath.row];
        [self openDoorWithModel:model];
    }else if (collectionView == self.bottomCollectionView) {
        if (indexPath.row == (self.dataArray.count - 1)) {
            ChooseDistrictFirstVC *firstVC = [[ChooseDistrictFirstVC alloc] init];
            [self.navigationController pushViewController:firstVC animated:YES];
        }else {
            
            [self.dataArray exchangeObjectAtIndex:(indexPath.row + 1) withObjectAtIndex:0];
            self.topModel = self.dataArray[0];
            self.topTitleLabel.text = self.topModel.wdmc;
            [self.topCollectionView reloadData];
            [self.bottomCollectionView reloadData];
        }
    }
}

- (void)openDoorWithModel:(ACVillageDoorModel *)model {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString *code = returnValue;
        if (code.integerValue == 1) {
            [STTextHudTool showErrorText:@"解锁成功"];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel acOpenDoorWithDoorId:model.doorId];
}
@end
