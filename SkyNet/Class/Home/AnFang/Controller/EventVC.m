//
//  EventVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EventVC.h"
#import "EventCell.h"
#define kBottomViewHeight 150
@interface EventVC ()
@property (nonatomic, strong) UIView *backCoverView;
@property (nonatomic, strong) UIView *bottomMessageView;

@end

@implementation EventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [self addBackView];
    [self addBottomView];
    self.backCoverView.hidden = YES;
    self.bottomMessageView.hidden = YES;
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
#pragma mark 下拉刷新
-(void)reloadTableView{
    
    __weak typeof(self)weakSelf =self;
    //[self getGroupData];
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        [weakSelf.myRefreshView endRefreshing];
        
    });
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    static NSString *ID = @"EventCell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.logoImageView.image=ImageNamed(@"home_monitor");
    cell.eventTitle.text=[NSString stringWithFormat:@"标题%ld",indexPath.row];
    cell.eventContent.text=[NSString stringWithFormat:@"内容内容内容%ld",indexPath.row];
    cell.createTime.text=@"2012-02-12";
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
//        [_myTableView setReloadBlock:^{
//            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
//            
//            [weakSelf reloadTableView];
//            
//        }];
        
        
        //_myTableView.tableHeaderView=_headView;
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
            
            [weakSelf reloadTableView];
            
            
        }];
        
        // 马上进入刷新状态
        [_myTableView.mj_header beginRefreshing];
        
        //        //..上拉刷新
        //        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            weakSelf.myRefreshView = weakSelf.myTableView.mj_footer;
        //            weakSelf.beginIndex = weakSelf.beginIndex + 5;
        //            weakSelf.endIndex=weakSelf.endIndex+5;
        //            [weakSelf refreshTableViewWithBeginIndex:weakSelf.beginIndex endIndex:weakSelf.endIndex];
        //
        //        }];
        //
        //        _myTableView.mj_footer.hidden = YES;
        
        
    }
    
    return _myTableView;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showMessageView];
}

@end
