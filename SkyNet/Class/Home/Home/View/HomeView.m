//
//  HomeView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeView.h"
#import "MenuItem.h"
#import "HomeCell.h"
#import "HeadCell.h"
#import "ShortcutModel.h"
#import "AdvModel.h"
#define HOME_ADVH  150 //轮播图高度
#define HOME_MENU_H  100 //菜单高度
@implementation HomeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=BACKGROUND_COLOR;
        [self initUI];
        
    }
    
    return self;
    
}


-(void)initUI{
    
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"天网安防";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont systemFontOfSize:20];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    titleLabel.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self, STATUS_BAR_HEIGHT+8)
    .widthIs(100)
    .heightIs(30);
    
    
    _headView =[UIView new];
    _headView.backgroundColor=BACKGROUND_COLOR;
    [self addSubview:_headView];
    _headView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .heightIs(HOME_ADVH+HOME_MENU_H+10);

    
    [self setupAdScrollView];
    
    [self setupFlowItemContentView];
    
    [self addSubview:self.myTableView];

    
    
    
}


#pragma mark 添加轮播图
-(void)setupAdScrollView{
    
    _adScrollView = [SDCycleScrollView new];
    [_headView addSubview:_adScrollView];
    _adScrollView.sd_layout
    .leftSpaceToView(_headView, 0)
    .topSpaceToView(_headView, 0)
    .rightSpaceToView(_headView, 0)
    .heightIs(HOME_ADVH);
    
    
}


#pragma mark 添加flowItemContentView
- (void)setupFlowItemContentView
{
    
    _menuScrollView=[UIScrollView new];
    _menuScrollView.backgroundColor=[UIColor whiteColor];
    _menuScrollView.showsHorizontalScrollIndicator=NO;
    [_headView addSubview:_menuScrollView];
    _menuScrollView.sd_layout
    .leftEqualToView(_headView)
    .topSpaceToView(_adScrollView, 0)
    .rightEqualToView(_headView)
    .heightIs(HOME_MENU_H);
    
    
    
    
    [self setupFlowItemViews:nil];
    
   
}


#pragma mark 加载菜单按钮
- (void)setupFlowItemViews:(NSArray *)itemArr
{
    
    
    CGFloat rowNumber=3;
    CGFloat horizonMargin=20;
    CGFloat horizonEdgeInset =30;
    CGFloat itemW =(SCREEN_WIDTH-2*horizonEdgeInset-2*horizonMargin)/rowNumber;
    NSArray * titleArr =@[@"安防",@"监控",@"门禁",@"安防",@"监控",@"门禁"];
    NSArray * imageArr =@[@"home_security",@"home_monitor",@"home_door",@"home_security",@"home_monitor",@"home_door"];
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        
        MenuItem * item =[MenuItem new];
        item.backgroundColor=[UIColor clearColor];
        item.nameLabel.text=titleArr[i];
        item.itemImageView.image=ImageNamed(imageArr[i]);
        item.tag=1000+i;
        [item addTarget:self action:@selector(menuSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScrollView addSubview:item];
        
        item.sd_layout
        .leftSpaceToView(_menuScrollView,horizonEdgeInset+i*(horizonMargin+itemW))
        .topSpaceToView(_menuScrollView, 0)
        .widthIs(itemW)
        .bottomSpaceToView(_menuScrollView, 0);
        
        [temp addObject:item];
    }
    
    
    // 设置scrollview的contentsize自适应
    [_menuScrollView setupAutoContentSizeWithRightView:[temp lastObject] rightMargin:horizonEdgeInset];
    
}

-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,HOME_ADVH+HOME_MENU_H+10, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-(HOME_ADVH+HOME_MENU_H+10)) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
//        [_myTableView setReloadBlock:^{
//            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
//            
//            if(weakSelf.delegate){
//                
//                [weakSelf.delegate reloadTableView];
//            }
//        }];
        
        
        //_myTableView.tableHeaderView=_headView;
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
            
            if(weakSelf.delegate){
                
                [weakSelf.delegate reloadTableView];
            }
            
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _shortDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        
        
            static NSString *ID = @"HeadCell";
            HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            cell = [[HeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            
            return cell;
        
    }
   
    static NSString *ID = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    if (_shortDataArr.count>0) {
        
        ShortcutModel * shortcutModel =_shortDataArr[indexPath.row -1];
        cell.signImageView.image=ImageNamed(@"home_monitor");
        cell.contentLabel.text =shortcutModel.name;
    }
   
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0) {
        
        return 40;
    }
    
    
    
    
    return 70;
}


#pragma mark 加载轮播图
-(void)loadAdScrollImage:(NSArray *)imageUrlArr{
    
    
    MJWeakSelf
    NSMutableArray * imageArr =[NSMutableArray new];
    
    for (AdvModel * model in imageUrlArr) {
        
        [imageArr addObject:model.tpdz];
        
    }
    
    
    weakSelf.adScrollView.imageURLStringsGroup = [imageArr copy];
    
    weakSelf.adScrollView.clickItemOperationBlock=^(NSInteger currentIndex){
        
//        AdScorllModel * model =weakSelf.bannerTopArr[currentIndex];
//        
//        if (weakSelf.delegate) {
//            
//            if (model.ioslink&&![model.ioslink isEqualToString:@""]) {
//                [weakSelf.delegate pushToWebView:model.ioslink isShowTitleBar:model.isshowtitlebar title:model.title];
//            }
//            
//            
//        }
        
        
    };
    
}


-(void)menuSelect:(UIButton *)sender{
    
    if (self.delegate) {
        [self.delegate menuClick:sender.tag-1000];
    }
    
}

@end
