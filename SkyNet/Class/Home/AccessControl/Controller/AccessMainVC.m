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
#import "MineAccessVC.h"

#define BottomButtonH 80

static NSString *bottomCellID = @"AccessMainBottomCellID";
static NSString *topCellID = @"AccessMainTopCellID";
static const NSString *doorKey = @"DoorKey";
@interface AccessMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *buttonScrollerView;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *doorScrollerView;

@property (strong, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *topDataArray;
@property (nonatomic, strong) ACVillageDoorModel *door;
@property (nonatomic, strong) ACVillageModel *village;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (weak, nonatomic) IBOutlet UIView *topContentView;
@property (nonatomic, assign) BOOL isCertificate;
@property (nonatomic, strong) ACVillageModel *neareastVillage;
@end

@implementation AccessMainVC

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)topDataArray {
    if (nil == _topDataArray) {
        _topDataArray = [NSMutableArray array];
    }
    return _topDataArray;
}

-(void)viewDidAppear:(BOOL)animated {
    [self isNeedCertification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    self.buttonScrollerView.showsHorizontalScrollIndicator = NO;
    [self createRightItem];
    [self setupBottomButton];
    [self setupLocation];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResultAction:) name:@"AccessControlVCNotification" object:nil];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"我的门禁" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(memberMangeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

//成员管理
- (void)memberMangeAction {
    MineAccessVC *mineAccessVC = [[MineAccessVC alloc] init];
    mineAccessVC.isCertificate = self.isCertificate;
    [self.navigationController pushViewController:mineAccessVC animated:YES];
}

//- (void)getResultAction:(NSNotification *)notification {
//    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
//    if (type == 0) {
//        [self isNeedCertification];
//    }
//}

- (void)isNeedCertification {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSDictionary *dic = returnValue;
        NSString *code = [dic objectForKey:@"request"];
        NSString *data = [dic objectForKey:@"data"];
        if (code.integerValue == 1) {
            if ([data isEqualToString:@"0"]) {
                self.isCertificate = NO;
                [self showCertificationAlert];
            }else {
                self.isCertificate = YES;
                self.topContentView.hidden = NO;
                self.bottomCollectionView.hidden = NO;
                [self.locationManager startUpdatingLocation];
            }
        }else {
            [STTextHudTool showErrorText:@"请求失败"];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"请求失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"请求失败"];
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
        //[self.locationManager startUpdatingLocation];
    }]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)setupLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
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
         CLLocation *newLocation = locations[0];
         self.latitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.latitude)];
         self.longitude = [NSString stringWithFormat:@"%@",@(newLocation.coordinate.longitude)];
         [self.locationManager stopUpdatingLocation];
         [self setupTopCollectionView];
         [self setupColectionView];
     }else {
         [STTextHudTool showErrorText:@"定位失败"];
     }
 }

- (void)loadDataWithLatitude:(NSString *)latitude Longitude:(NSString *)longitude {
    MJWeakSelf
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
         weakSelf.selectedIndex = 0;
        [weakSelf.bottomCollectionView.mj_header endRefreshing];
        if (weakSelf.dataArray.count > 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.dataArray = returnValue;
        NSMutableArray *disArray = [NSMutableArray array];
        if (weakSelf.dataArray.count > 0) {
            for (ACVillageModel *model in weakSelf.dataArray) {
                NSNumber *number = [NSNumber numberWithDouble:[weakSelf getDistanceWithLongitude:model.wdjd latitude:model.wdwd]];
                [disArray addObject:number];
            }
            [weakSelf setupScrollerViewWithIndex:0];
            [weakSelf.bottomCollectionView reloadData];
        }
        NSNumber *neareast = [disArray valueForKeyPath:@"@min.doubleValue"];
        NSInteger index = [disArray indexOfObject:neareast];
        weakSelf.neareastVillage = weakSelf.dataArray[index];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [viewModel requestDataWithLatitude:latitude Longitude:longitude];
}

-(CLLocationDistance )getDistanceWithLongitude:(NSString *)longitude latitude:(NSString *)latitude {
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    
    return [orig distanceFromLocation:dist];
}

- (void)setupScrollerViewWithIndex:(NSInteger)index {
    //重置Scroller
    for (UIView *button in self.buttonScrollerView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button removeFromSuperview];
        }
    }
    //添加按钮
    ACVillageModel *model = self.dataArray[index];
    self.village = model;
    [self.topDataArray removeAllObjects];
    [self.topDataArray addObjectsFromArray:self.village.doorInfo];
    [self.topCollectionView reloadData];
    if (model.doorInfo.count > 0) {
        CGFloat sumWidth = 5.0f;
        for (NSInteger i = 0;i<model.doorInfo.count;i++) {
            ACVillageDoorModel *door = model.doorInfo[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:door.name forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.tag = i;
            button.layer.cornerRadius = 10;
            button.layer.masksToBounds = YES;
            //objc_setAssociatedObject(button, &doorKey, door, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [button addTarget:self action:@selector(chooseDoorAction:) forControlEvents:UIControlEventTouchUpInside];
            CGSize size = [door.name sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,nil]];
            button.frame = CGRectMake(sumWidth, 10, size.width + 10, 25);
            sumWidth += size.width + 20;
            [self.buttonScrollerView addSubview:button];
            self.buttonScrollerView.contentSize = CGSizeMake(button.right + 10, 25);
            if (i == 0) {
                [button setBackgroundColor:NAVI_COLOR];
                self.selectButton = button;
                self.door = door;
            }else {
                [button setBackgroundColor:[UIColor lightGrayColor]];
            }
        }
    }
}

- (void)chooseDoorAction:(UIButton *)button {
    if (button == self.selectButton) {
        return;
    }
    //ACVillageDoorModel *door = objc_getAssociatedObject(button,&doorKey);
    self.door = self.village.doorInfo[button.tag];
    [button setBackgroundColor:NAVI_COLOR];
    [self.selectButton setBackgroundColor:[UIColor lightGrayColor]];
    self.selectButton = button;
    
    [self.buttonScrollerView setContentOffset:CGPointMake(button.left - 10, 0) animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [self.topCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.topCollectionView) {
        NSMutableArray *contentArray = [NSMutableArray array];
        for (UIView *view in self.buttonScrollerView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [contentArray addObject:view];
            }
        }
        
        NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;
        UIButton *button = contentArray[i];
        if (button == self.selectButton) {
            return;
        }
        //ACVillageDoorModel *door = objc_getAssociatedObject(button,&doorKey);
        self.door = self.village.doorInfo[button.tag];
        [button setBackgroundColor:NAVI_COLOR];
        [self.selectButton setBackgroundColor:[UIColor lightGrayColor]];
        self.selectButton = button;
        [self.buttonScrollerView setContentOffset:CGPointMake(button.left - 10, 0) animated:YES];
    }
}

- (void)setupBottomButton {
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.layer.cornerRadius = BottomButtonH / 2;
    bottomButton.layer.masksToBounds = YES;
    [bottomButton setBackgroundImage:[UIImage imageNamed:@"access_visitor"] forState:UIControlStateNormal];
    bottomButton.frame = CGRectMake(SCREEN_WIDTH - BottomButtonH - 20, SCREEN_HEIGHT - 20 - BottomButtonH, BottomButtonH, BottomButtonH);
    [bottomButton addTarget:self action:@selector(toDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)toDetailAction {
    AccessControlDetailVC *detailVC = [[AccessControlDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)setupColectionView {

    MJWeakSelf
    UICollectionViewFlowLayout *bottomLayout = [[UICollectionViewFlowLayout alloc] init];
    bottomLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 20) / 2, 60);
    bottomLayout.minimumLineSpacing = 10;
    bottomLayout.minimumInteritemSpacing = 10;
    bottomLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    bottomLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.bottomCollectionView setCollectionViewLayout:bottomLayout];
    self.bottomCollectionView.pagingEnabled = YES;
    self.bottomCollectionView.showsHorizontalScrollIndicator = NO;
    self.bottomCollectionView.showsVerticalScrollIndicator = NO;
    self.bottomCollectionView.backgroundColor = [UIColor whiteColor];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerClass:[AccessMainBottomCell class] forCellWithReuseIdentifier:bottomCellID];
    
    self.bottomCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithLatitude:self.latitude Longitude:self.longitude];
    }];
    
    [self.bottomCollectionView.mj_header beginRefreshing];
}

-(void)setupTopCollectionView {
    UICollectionViewFlowLayout *topLayout = [[UICollectionViewFlowLayout alloc] init];
    topLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 130);
    topLayout.minimumLineSpacing = 0;
    topLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.topCollectionView setCollectionViewLayout:topLayout];
    self.topCollectionView.backgroundColor = BACKGROUND_COLOR;
    self.topCollectionView.pagingEnabled = YES;
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    self.topCollectionView.showsVerticalScrollIndicator = NO;
    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    [self.topCollectionView registerClass:[AccessManiTopCell class] forCellWithReuseIdentifier:topCellID];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.bottomCollectionView) {
        return self.dataArray.count;
    }else {
        return self.topDataArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.bottomCollectionView) {
        AccessMainBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bottomCellID forIndexPath:indexPath];
        if (indexPath.row == self.selectedIndex) {
            cell.selected = YES;
        }else {
            cell.selected = NO;
        }
        cell.model = self.dataArray[indexPath.row];
        if (self.neareastVillage == self.dataArray[indexPath.row]) {
            cell.isShowLocation = YES;
        }else {
            cell.isShowLocation = NO;
        }
        cell.isLastCell = NO;
        return cell;
    }else {
        AccessManiTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellID forIndexPath:indexPath];
        ACVillageDoorModel *model = self.topDataArray[indexPath.row];
        cell.model = model;
        cell.bottomContent = [NSString stringWithFormat:@"%@km|%@|%@",@([model.meter floatValue] / 1000),self.village.areaName,model.azwz];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == self.dataArray.count) {
//        ChooseDistrictFirstVC *firstVC = [[ChooseDistrictFirstVC alloc] init];
//        [self.navigationController pushViewController:firstVC animated:YES];
//    }else {
//        self.selectedIndex = indexPath.row;
//        [self setupScrollerViewWithIndex:indexPath.row];
//        [self.bottomCollectionView reloadData];
//    }
    if (collectionView == self.bottomCollectionView) {
        self.selectedIndex = indexPath.row;
        [self setupScrollerViewWithIndex:indexPath.row];
        [self.bottomCollectionView reloadData];
    }else {
        self.door = self.topDataArray[indexPath.row];
        [self sureOpenDoorAction];
    }
}

//开门
- (IBAction)openDoorAction:(id)sender {
    MJWeakSelf
    NSString *title = [NSString stringWithFormat:@"是否确认开启%@",self.door.name];
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf sureOpenDoorAction];
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];

}

-(void)sureOpenDoorAction {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSDictionary *dic = returnValue;
        NSString *code = [dic objectForKey:@"code"];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        customView.layer.cornerRadius = 5;
        customView.layer.masksToBounds = YES;
        customView.backgroundColor = [UIColor colorWithRed:9.0/255.0 green:173.0/255.0 blue:136.0/255.0 alpha:1];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(30, 15, 30, 30);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 55, 90, 15);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [dic objectForKey:@"message"];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor whiteColor];
        
        [customView addSubview:imageView];
        [customView addSubview:titleLabel];
        if (code.integerValue == 1) {
            imageView.image = [UIImage imageNamed:@"open_success"];
            [STTextHudTool showTextTitle:nil WithCustomVew:customView];
        }else {
            imageView.image = [UIImage imageNamed:@"open_failure"];
            [STTextHudTool showTextTitle:nil WithCustomVew:customView];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel acOpenDoorWithDoorId:self.door.doorId];
}

//-(void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
