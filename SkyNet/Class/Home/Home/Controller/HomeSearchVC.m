//
//  HomeSearchVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchVC.h"
#import "HomeSearchAFVC.h"
#import "HomeSearchAFDevicesVC.h"
#import "HomeSearchVideoVC.h"
#import "HomeSearchAccessVC.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "SearchHistoryCell.h"
#import "MoreHistoryVC.h"

#define kSegmentViewH 44.0f
typedef NS_ENUM(NSInteger, SearchType) {
    SearchAF,
    SearchAFDevices,
    SearchVideo,
    SearchAcess
};

@interface HomeSearchVC ()<MDMultipleSegmentViewDeletegate,
MDFlipCollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)MDMultipleSegmentView *segView;
@property(nonatomic,strong)MDFlipCollectionView *collectView;
@property(nonatomic,assign)SearchType mySearchType;
@property(nonatomic, weak)UITextField *searchTextField;
@property(nonatomic, strong)UITableView *historyTabview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, copy) NSString *searchStr;
@end

@implementation HomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchStr = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self setupTitleView];
    [self creatHistoryView];
    [self createSegment];
}

- (void)setupTitleView {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(25, 10, SCREEN_WIDTH - 150, 30)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    searchView.userInteractionEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:@"home_titlesearch"];
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right, 0, searchView.width - imageView.right, searchView.height)];
    searchTextField.placeholder = @"请输入搜索关键词";
    searchTextField.clearsOnBeginEditing = YES;
    searchTextField.font = [UIFont systemFontOfSize:13];
    [searchTextField setTintColor:[UIColor blueColor]];
    self.searchTextField = searchTextField;
    [searchTextField becomeFirstResponder];
    
    [searchView addSubview:imageView];
    [searchView addSubview:searchTextField];
    
    self.navigationItem.titleView = searchView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count >= 3) {
        return 2;
    }else {
         return self.dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCell *cell = [SearchHistoryCell cellWithTableView:tableView];
    cell.content = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *content = self.dataArray[indexPath.row];
    self.searchStr = content;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":content,@"type":@(self.mySearchType)}];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)searchAction {
    if ([self.searchTextField.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请输入搜索关键词"];
    }else {
        [self addHistoryDataWithData:self.searchTextField.text];
        self.searchStr = self.searchTextField.text;
        [self resetHistoryView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":self.searchTextField.text,@"type":@(self.mySearchType)}];
    }
}

-(void)resetHistoryView {
    if ([[self getHistoryDataArray] count] >= 3) {
        [UIView animateWithDuration:0.5 animations:^{
            self.historyTabview.frame = CGRectMake(0, 64, SCREEN_WIDTH, 4 * 44 );
            self.segView.frame = CGRectMake(0, _historyTabview.bottom, SCREEN_WIDTH, 44);
            self.collectView.frame = CGRectMake(0, _segView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_segView.bottom);
        }];
        [self creatHistoryFooterView];
        [self.historyTabview reloadData];
    }else {
        NSInteger count = [[self getHistoryDataArray] count];
        [UIView animateWithDuration:0.5 animations:^{
            self.historyTabview.frame = CGRectMake(0, 64, SCREEN_WIDTH, (count + 1) * 44 );
            self.segView.frame = CGRectMake(0, _historyTabview.bottom, SCREEN_WIDTH, 44);
            self.collectView.frame = CGRectMake(0, _segView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_segView.bottom);
        }];
        self.dataArray = [self getHistoryDataArray];
        [self.historyTabview reloadData];
    }
}

-(void)creatHistoryView {
    [self writeFileToplist];
    [self.view addSubview:self.historyTabview];
    [self creatHistoryHeaderView];
    [self setHistoryTableviewHeight];
}

-(void)setHistoryTableviewHeight {
    self.dataArray = [self getHistoryDataArray];
    if (self.dataArray.count >= 3) {
        [self creatHistoryFooterView];
        self.historyTabview.frame = CGRectMake(0, 64, SCREEN_WIDTH, 4 * 44);
    }else {
        self.historyTabview.frame = CGRectMake(0, 64, SCREEN_WIDTH, self.dataArray.count * 44 + 44);
    }
    [self.historyTabview reloadData];
}

-(UITableView *)historyTabview {
    if (!_historyTabview) {
        _historyTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,0) style:UITableViewStylePlain];
        _historyTabview.backgroundColor = BACKGROUND_COLOR;
        _historyTabview.delegate = self;
        _historyTabview.dataSource = self;
        _historyTabview.rowHeight = 44.0f;
    }
    return _historyTabview;
}

-(void)creatHistoryHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
    titleLabel.text = @"最近搜索";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:titleLabel];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearButton setImage:[UIImage imageNamed:@"clear_history_ico"] forState:UIControlStateNormal];
    clearButton.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 60, 44);
    [headerView addSubview:clearButton];
    [clearButton addTarget:self action:@selector(clearAllHisroy) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height - 0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    self.historyTabview.tableHeaderView = headerView;
}

-(void)creatHistoryFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    footerView.backgroundColor = BACKGROUND_COLOR;
    footerView.tag = 1;
    footerView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreHistory:)];
    [footerView addGestureRecognizer:tap];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 90) / 2, 0, 90, 44)];
    contentLabel.textColor = [UIColor blueColor];
    contentLabel.text = @"更多历史搜索";
    contentLabel.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:contentLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(contentLabel.right + 5, (footerView.height - 10) / 2, 10, 10)];
    imageView.image = [UIImage imageNamed:@"blue_arrow_down"];
    [footerView addSubview:imageView];
    
    self.historyTabview.tableFooterView = footerView;
}

- (void)showMoreHistory:(UITapGestureRecognizer *)tap {
    MoreHistoryVC *morVC = [[MoreHistoryVC alloc] init];
    morVC.dataArray = [self getHistoryDataArray];
    morVC.historyHandle = ^(NSString *historyStr) {
        [self addHistoryDataWithData:historyStr];
        self.searchStr = historyStr;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":historyStr,@"type":@(self.mySearchType)}];
    };
    [self.navigationController pushViewController:morVC animated:YES];
}

-(void)clearAllHisroy {
    if ([[self getHistoryDataArray] count] <= 0) {
        [STTextHudTool showErrorText:@"暂无历史搜索记录"];
        return;
    }
    [self removeAllHistoryData];
    self.dataArray = [self getHistoryDataArray];
    [UIView animateWithDuration:0.5 animations:^{
        self.historyTabview.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
        self.segView.frame = CGRectMake(0, _historyTabview.bottom, SCREEN_WIDTH, 44);
        self.collectView.frame = CGRectMake(0, _segView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_segView.bottom);
    }];
    [self.historyTabview reloadData];
}

-(void)writeFileToplist {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"searchHistory.plist"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
         NSMutableArray *historyData = [[NSMutableArray alloc] init];
        [historyData writeToFile:plistPath atomically:YES];
    }
}

-(NSMutableArray *)getHistoryDataArray {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"searchHistory.plist"];
    NSMutableArray *historyData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    return historyData;
}

-(void)addHistoryDataWithData:(NSString *)data {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"searchHistory.plist"];
    NSMutableArray *historyData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if ([historyData containsObject:data]) {
        for (NSInteger i = 0; i < historyData.count; i++) {
            if ([historyData[i] isEqualToString:data]) {
                NSString *str = historyData[i];
                [historyData removeObject:historyData[i]];
                [historyData insertObject:str atIndex:0];
            }
        }
        [historyData writeToFile:plistPath atomically:YES];
    }else {
        [historyData insertObject:data atIndex:0];
        [historyData writeToFile:plistPath atomically:YES];
    }
}

-(void)removeAllHistoryData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"searchHistory.plist"];
    NSMutableArray *historyData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [historyData removeAllObjects];
    [historyData writeToFile:plistPath atomically:YES];
}

-(void)createSegment{
    self.mySearchType = SearchAF;
    [self.view addSubview:self.segView];
    
    HomeSearchAFVC *afVC = [[HomeSearchAFVC alloc]init];
    afVC.view.backgroundColor = [UIColor blueColor];
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
        _segView.frame = CGRectMake(0, self.historyTabview.bottom, SCREEN_WIDTH, 44);
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSearchResultNotification" object:nil userInfo:@{@"searchText":self.searchStr,@"type":@(self.mySearchType)}];
}

- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
