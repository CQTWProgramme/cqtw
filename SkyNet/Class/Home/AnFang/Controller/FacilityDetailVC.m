//
//  FacilityDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "FacilityDetailVC.h"
#import "FacilityDetailModel.h"
#import "FacilityDetailListModel.h"
#import "AFViewModel.h"
#import "KYAlertView.h"

@interface FacilityDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FacilityDetailModel *detailModel;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *backCoverView;
@property (strong, nonatomic) IBOutlet UIView *bottomMessageView;
@property (strong, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messagetypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageOnlineLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageStateLabel;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *equipmentsArray;
@end

@implementation FacilityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通道详情";
    [self createBottomView];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    self.backCoverView.hidden = YES;
    self.bottomMessageView.hidden = YES;
    [self createRightItem];
    [self getData];
    [self setupTable];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"sendfast") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(creatFastAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)creatFastAction {
    NSString *title = [NSString stringWithFormat:@"请确认是否将当前设备添加到系统快捷方式?"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            NSLog(@"取消");
            
        }else  if (index == 1) {
            
            [self addShortcut];
        }
        
    };
    [alert show];
}

- (void)addShortcut {
    AFViewModel *viewModel = [AFViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    if (self.detailModel.sbmc == nil) {
        self.detailModel.sbmc = @"";
    }
    [viewModel addShortcutDataWithDataId:self.deviceId name:self.detailModel.sbmc lx:@"3"];
}

-(NSMutableArray *)equipmentsArray {
    if (nil == _equipmentsArray) {
        _equipmentsArray = [NSMutableArray array];
    }
    return _equipmentsArray;
}

-(void)createBottomView{
    UIView *_bottomView =[UIView new];
    _bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [self.view insertSubview:_bottomView atIndex:0];
    _bottomView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(60);
    
    for (int i=0; i<3; i++) {
        NSArray * titleA=@[@"布防",@"撤防",@"消警"];
        NSArray * imageArr=@[@"bf",@"home_monitor",@"xj"];
        UILabel * label =[UILabel new];
        [_bottomView addSubview:label];
        label.text=titleA[i];
        label.textColor=[UIColor hexStringToColor:@"#3c3c3c"];
        label.textAlignment=NSTextAlignmentCenter;
        label.sd_layout
        .leftSpaceToView(_bottomView, i*SCREEN_WIDTH/3)
        .bottomSpaceToView(_bottomView, 10)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(15);
        
        
        
        UIButton * btn =[UIButton new];
        [_bottomView addSubview:btn];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        btn.tag =2000+ i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .centerXEqualToView(label)
        .widthIs(26)
        .heightEqualToWidth();
        btn.sd_cornerRadius=@(13);
        
        
    }
    
}


- (void)btnClick:(UIButton *)btn {
    NSString *title = nil;
    if (btn.tag == 2000) {
        title = @"确认一键布防吗?";
    }else if (btn.tag == 2001) {
        title = @"确认一键撤防吗?";
    }else if (btn.tag == 2002) {
        title = @"确认一键消警吗?";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            
        }else  if (index == 1) {
            AFViewModel *afViewModel = [AFViewModel new];
            [afViewModel setBlockWithReturnBlock:^(id returnValue) {
                NSString *code = returnValue[@"code"];
                if (code.integerValue == 1) {
                    if (btn.tag == 2000) {
                        [STTextHudTool showSuccessText:@"一键布防成功!"];
                    }else if (btn.tag == 2001) {
                        [STTextHudTool showSuccessText:@"一键撤防成功!"];
                    }else if (btn.tag == 2002) {
                        [STTextHudTool showSuccessText:@"一键消警成功!"];
                    }
                }else {
                    [STTextHudTool showErrorText:returnValue[@"message"]];
                }
            } WithErrorBlock:^(id errorCode) {
                
            } WithFailureBlock:^{
                
            }];
            if (btn.tag == 2000) {
                [afViewModel alarmDeviceBCFWithId:self.deviceId type:1];
            }else if (btn.tag == 2001) {
                [afViewModel alarmDeviceBCFWithId:self.deviceId type:2];
            }else if (btn.tag == 2002) {
                [afViewModel alarmDeviceBCFWithId:self.deviceId type:3];
            }
        }
        
    };
    [alert show];
}

- (void)loadData {
    MJWeakSelf
    [FacilityDetailListModel getFacilityDetailListDataById:self.deviceId currentPage:self.currentPage pageSize:self.pageSize success:^(id returnValue) {
        if (weakSelf.myRefreshView == weakSelf.tableView.mj_header) {
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSInteger totalPage = [returnValue[@"data"][@"totalPage"] integerValue];
                if (totalPage <= weakSelf.currentPage) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                }
                
                NSMutableArray *muArr = [NSMutableArray array];
                NSArray *arr = returnValue[@"data"][@"rows"];
                NSInteger dataCount = arr.count;
                if (dataCount > 0) {
                    for (NSDictionary *dic in arr) {
                        FacilityDetailListModel *model = [FacilityDetailListModel mj_objectWithKeyValues:dic];
                        [muArr addObject:model];
                    }
                }
                weakSelf.equipmentsArray = muArr;
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
            }else {
                [weakSelf.tableView.mj_header endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }else if (weakSelf.myRefreshView == weakSelf.tableView.mj_footer) {
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                
                NSInteger totalPage = [returnValue[@"data"][@"totalPage"] integerValue];
                if (weakSelf.currentPage > totalPage) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    NSMutableArray *muArr = [NSMutableArray array];
                    NSDictionary * dic = returnValue[@"data"];
                    NSArray *arr = dic[@"rows"];
                    if (arr.count > 0) {
                        for (NSDictionary *dic1 in arr) {
                            FacilityDetailListModel *model = [FacilityDetailListModel mj_objectWithKeyValues:dic1];
                            [muArr addObject:model];
                        }
                    }
                    
                    [weakSelf.equipmentsArray addObjectsFromArray:muArr];
                    [weakSelf.tableView.mj_footer endRefreshing];
                    [weakSelf.tableView reloadData];
                }
                
            }else {
                [weakSelf.tableView.mj_footer endRefreshing];
                [STTextHudTool showErrorText:returnValue[@"message"]];
            }
        }
    } failure:^(id errorCode) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [STTextHudTool showErrorText:@"操作失败"];
    }];
}

- (void)setupTable {
    MJWeakSelf
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight=44;
    self.tableView.tableFooterView=[[UIView alloc]init];
    //..下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = self.tableView.mj_header;
        weakSelf.currentPage = 1;
        weakSelf.pageSize = 10;
        [weakSelf loadData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    //..上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = self.tableView.mj_footer;
        weakSelf.currentPage += 1;
        weakSelf.pageSize=10;
        [weakSelf loadData];
    }];
}

- (IBAction)hideBottomMessageViewAction:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.backCoverView.hidden = YES;
        self.bottomMessageView.hidden = YES;
    }];
}

- (void)showMessageView {
    [UIView animateWithDuration:1.5 animations:^{
        self.backCoverView.hidden = NO;
        self.bottomMessageView.hidden = NO;
    }];
}

- (void)getData {
    [FacilityDetailModel getDetailDataById:self.deviceId 
                                   success:^(id returnValue) {
                                       self.detailModel = returnValue;
                                       self.nameLabel.text = self.detailModel.sbmc;
                                       
                                 } failure:^(id errorCode) {
                                       
                                 }];
}
#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.equipmentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    FacilityDetailListModel *model = self.equipmentsArray[indexPath.row];
    cell.textLabel.text = model.jkmc;
    return cell;
}

- (IBAction)coverTap:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.backCoverView.hidden = YES;
        self.bottomMessageView.hidden = YES;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FacilityDetailListModel *model = self.equipmentsArray[indexPath.row];
    [self showMessageWithId:model];
}

- (void)showMessageWithId:(FacilityDetailListModel *)model {
    self.messageTitleLabel.text = model.jkmc;
    [self showMessageView];
//    [FacilityDetailListModel getChannelDetailWithChannelId:model.channelId success:^(id returnValue) {
//        [self showMessageView];
//    } failure:^(id errorCode) {
//
//    }];
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
