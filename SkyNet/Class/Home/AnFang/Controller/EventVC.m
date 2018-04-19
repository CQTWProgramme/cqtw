//
//  EventVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EventVC.h"
#import "EventCell.h"
#import "EvevtListModel.h"

#define kBottomViewHeight 150
@interface EventVC ()
@property (nonatomic, strong) UIView *backCoverView;
@property (nonatomic, strong) UIView *bottomMessageView;
@property (nonatomic, strong) NSMutableArray *equipmentsArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation EventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 0;
    self.pageSize = 10;
    [self.view addSubview:self.myTableView];
    [self addBackView];
    [self addBottomView];
    self.backCoverView.hidden = YES;
    self.bottomMessageView.hidden = YES;
}

-(NSMutableArray *)equipmentsArray {
    if (nil == _equipmentsArray) {
        _equipmentsArray = [NSMutableArray array];
    }
    return _equipmentsArray;
}

//加载设备数据
- (void)loadData {
    MJWeakSelf
    [EvevtListModel getEventListDataById:self.branchId currentPage:self.currentPage pageSize:self.pageSize success:^(id returnValue) {
        if (weakSelf.myRefreshView == weakSelf.myTableView.mj_header) {
            [STTextHudTool hideSTHud];
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSMutableArray *muArr = [NSMutableArray array];
                NSDictionary * dic = returnValue[@"data"];
                NSArray *arr = dic[@"rows"];
                if (arr.count > 0) {
                    for (NSDictionary *dic1 in arr) {
                        EvevtListModel *model = [EvevtListModel mj_objectWithKeyValues:dic1];
                        [muArr addObject:model];
                    }
                }
                weakSelf.equipmentsArray = returnValue;
                [weakSelf.myTableView.mj_header endRefreshing];
                [weakSelf.myTableView reloadData];
            }else {
                [weakSelf.myTableView.mj_header endRefreshing];
                [STTextHudTool showErrorText:@"message"];
            }
        }else if (weakSelf.myRefreshView == weakSelf.myTableView.mj_footer) {
            [STTextHudTool hideSTHud];
            NSString * code=returnValue[@"code"];
            if (code.integerValue==1) {
                NSMutableArray *muArr = [NSMutableArray array];
                NSDictionary * dic = returnValue[@"data"];
                NSArray *arr = dic[@"rows"];
                if (arr.count > 0) {
                    for (NSDictionary *dic1 in arr) {
                        EvevtListModel *model = [EvevtListModel mj_objectWithKeyValues:dic1];
                        [muArr addObject:model];
                    }
                }
                if ([muArr count]==0) {
                    
                    [STTextHudTool showText:@"暂无更多内容"];
                }
                [weakSelf.equipmentsArray addObjectsFromArray:muArr];
                [weakSelf.myTableView.mj_footer endRefreshing];
                [weakSelf.myTableView reloadData];
            }else {
                [weakSelf.myTableView.mj_header endRefreshing];
                [STTextHudTool showErrorText:@"message"];
            }
        }
    } failure:^(id errorCode) {
        
    }];
}

- (void)addBackView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backCoverView];
}

- (void)addBottomView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.bottomMessageView];
}

-(UIView *)bottomMessageView {
    if (nil == _bottomMessageView) {
        _bottomMessageView = [[UIView alloc] init];
        _bottomMessageView.backgroundColor = [UIColor whiteColor];
        _bottomMessageView.frame = CGRectMake(0, SCREEN_HEIGHT - kBottomViewHeight, SCREEN_WIDTH, kBottomViewHeight);
        
        //添加子view
        //1.名称
        UILabel *headLabel = [[UILabel alloc] init];
        headLabel.frame = CGRectMake(20, 10, 100, 16);
        headLabel.font = [UIFont systemFontOfSize:14];
        headLabel.text = @"异常情况1";
        headLabel.textColor = [UIColor blackColor];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.frame = CGRectMake(20, 30, 180, 14);
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.text = @"发生时间:2017-08-15 12:30";
        timeLabel.textColor = [UIColor lightGrayColor];
        
        UIButton *cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancellBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancellBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 0, 44, 44);
        [cancellBtn addTarget:self action:@selector(cancellAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.frame = CGRectMake(10, 50, SCREEN_WIDTH - 20, 80);
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.textColor = [UIColor lightGrayColor];
        contentLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        
        [_bottomMessageView addSubview:headLabel];
        [_bottomMessageView addSubview:timeLabel];
        [_bottomMessageView addSubview:cancellBtn];
        [_bottomMessageView addSubview:lineView];
        [_bottomMessageView addSubview:contentLabel];
    }
    return _bottomMessageView;
}


- (void)cancellAction {
    [UIView animateWithDuration:1.0 animations:^{
        self.backCoverView.hidden = YES;
        self.bottomMessageView.hidden = YES;
    }];
}

- (void)showMessageView {
    [UIView animateWithDuration:1.0 animations:^{
        self.backCoverView.hidden = NO;
        self.bottomMessageView.hidden = NO;
    }];
}

-(UIView *)backCoverView {
    if (nil == _backCoverView) {
        _backCoverView = [[UIView alloc] init];
        _backCoverView.frame = CGRectMake(0, NavigationBar_HEIGHT + STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - kBottomViewHeight - STATUS_BAR_HEIGHT);
        _backCoverView.backgroundColor = [UIColor blackColor];
        _backCoverView.alpha = 0.3;
    }
    return _backCoverView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.equipmentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"EventCell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.logoImageView.image=ImageNamed(@"home_monitor");
    EvevtListModel *model = self.equipmentsArray[indexPath.row];
    cell.eventTitle.text=model.alarmdesc;
    cell.eventContent.text=model.alarmdesc;
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:model.createtime /1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *formatterLocal = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
    [formatter setLocale:formatterLocal];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    cell.createTime.text= dateString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}



-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=70;
        _myTableView.tableFooterView=[[UIView alloc]init];

        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = _myTableView.mj_header;
            weakSelf.currentPage = 0;
            weakSelf.pageSize = 10;
            [weakSelf.equipmentsArray removeAllObjects];
            [weakSelf loadData];
        }];
        // 马上进入刷新状态
        [_myTableView.mj_header beginRefreshing];
        
        //..上拉刷新
        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = _myTableView.mj_footer;
            weakSelf.currentPage = weakSelf.currentPage + 1;
            weakSelf.pageSize=10;
            [weakSelf loadData];
        }];
        _myTableView.mj_footer.hidden = NO;
        
    }
    
    return _myTableView;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showMessageView];
}

@end
