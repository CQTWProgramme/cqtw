//
//  MonitorDetailListVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorDetailListVC.h"
#import "MonitorDetailListCell.h"
#import "MonitorPlayVC.h"
static NSString *cellID = @"MonitorDetailListCellID";
@interface MonitorDetailListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation MonitorDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"监控详情列表";
    [self setupColectionView];
    // Do any additional setup after loading the view from its nib.
}

-(NSArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

- (void)setupColectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45) / 2, (SCREEN_WIDTH - 45) / 2);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    [self.myCollectionView setCollectionViewLayout:layout];
    self.myCollectionView.backgroundColor = [UIColor lightGrayColor];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerClass:[MonitorDetailListCell class] forCellWithReuseIdentifier:cellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MonitorDetailListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    MonitorPlayVC *playVC = [[MonitorPlayVC alloc] init];
    playVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:playVC animated:YES];
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
