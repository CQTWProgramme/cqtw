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
#import "MonitorViewModel.h"
#import "VideoListModel.h"
static NSString *cellID = @"MonitorDetailListCellID";
@interface MonitorDetailListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currPage;
@property (assign, nonatomic) NSInteger pageSize;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation MonitorDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.groupTitle;
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupColectionView];
}

-(void)loadData {
    MJWeakSelf
    MonitorViewModel *viewModel = [MonitorViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (weakSelf.myRefreshView == weakSelf.myCollectionView.mj_header) {
            [STTextHudTool hideSTHud];
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSMutableArray *muArr = [NSMutableArray array];
                NSDictionary * dic = returnValue[@"data"];
                NSArray *arr = dic[@"rows"];
                if (arr.count > 0) {
                    for (NSDictionary *dic1 in arr) {
                        VideoListModel *model = [VideoListModel mj_objectWithKeyValues:dic1];
                        [muArr addObject:model];
                    }
                }
                weakSelf.dataArray = muArr;
                [weakSelf.myCollectionView.mj_header endRefreshing];
                [weakSelf.myCollectionView reloadData];
            }else {
                [weakSelf.myCollectionView.mj_header endRefreshing];
                [STTextHudTool showErrorText:@"message"];
            }
        }else if (weakSelf.myRefreshView == weakSelf.myCollectionView.mj_footer) {
            [STTextHudTool hideSTHud];
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSMutableArray *muArr = [NSMutableArray array];
                NSDictionary * dic = returnValue[@"data"];
                NSArray *arr = dic[@"rows"];
                if (arr.count > 0) {
                    for (NSDictionary *dic1 in arr) {
                        VideoListModel *model = [VideoListModel mj_objectWithKeyValues:dic1];
                        [muArr addObject:model];
                    }
                }
                if ([muArr count]==0) {
                    
                    [STTextHudTool showText:@"暂无更多内容"];
                }
                [weakSelf.dataArray addObjectsFromArray:muArr];
                [weakSelf.myCollectionView.mj_footer endRefreshing];
                [weakSelf.myCollectionView reloadData];
            }else {
                [weakSelf.myCollectionView.mj_footer endRefreshing];
                [STTextHudTool showErrorText:@"message"];
            }
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel requestBranchData:self.customId currPage:self.currPage pageSize:self.pageSize];
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupColectionView {
    MJWeakSelf
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45) / 2, (SCREEN_WIDTH - 45) / 2);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    [self.myCollectionView setCollectionViewLayout:layout];
    self.myCollectionView.backgroundColor = BACKGROUND_COLOR;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerClass:[MonitorDetailListCell class] forCellWithReuseIdentifier:cellID];
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.myRefreshView = self.myCollectionView.mj_header;
        self.currPage = 0;
        self.pageSize = 10;
        [weakSelf loadData];
    }];
    
    [self.myCollectionView.mj_header beginRefreshing];
    
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.myRefreshView = self.myCollectionView.mj_footer;
        self.currPage += 1;
        self.pageSize = 10;
        [weakSelf loadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MonitorDetailListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];;
    cell.model = self.dataArray[indexPath.row];
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
