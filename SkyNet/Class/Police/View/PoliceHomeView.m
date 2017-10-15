//
//  PoliceHomeView.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PoliceHomeView.h"
#import "PoliceHomeMenuItem.h"
#import "PoliceHomeCell.h"
#import "PoliceHomeModel.h"
#import "AdvModel.h"
#define HOME_ADVH  150 //轮播图高度
#define HOME_MENU_H  100 //菜单高度
#define SECTION_HEADER_H  40 //scetion头部高度

@implementation PoliceHomeView

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
    .heightIs(HOME_ADVH+HOME_MENU_H+SECTION_HEADER_H);
    
    
    [self setupAdScrollView];
    
    [self setupFlowItemContentView];
    
    [self setupSectionHeader];
    
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

- (void)setupSectionHeader {
    UIView *sectionHeader = [[UIView alloc] init];
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont systemFontOfSize:13];
    headerLabel.text = @"最新资讯";
    [sectionHeader addSubview:headerLabel];
    [_headView addSubview:sectionHeader];
    
    sectionHeader
    .sd_layout.leftSpaceToView(_headView, 0)
    .rightSpaceToView(_headView, 0)
    .bottomSpaceToView(_headView, 0)
    .heightIs(SECTION_HEADER_H);
    
    headerLabel.sd_layout
    .topSpaceToView(sectionHeader, 0)
    .bottomSpaceToView(sectionHeader, 0)
    .rightSpaceToView(sectionHeader, 0)
    .leftSpaceToView(sectionHeader, 10);
}

#pragma mark 加载菜单按钮
- (void)setupFlowItemViews:(NSArray *)itemArr
{
    CGFloat rowNumber=4;
    CGFloat horizonMargin=20;
    CGFloat horizonEdgeInset =10;
    CGFloat itemW =(SCREEN_WIDTH-2*horizonEdgeInset-2*horizonMargin)/rowNumber;
    NSArray * titleArr =@[@"社区警务",@"网上办事",@"线索举报",@"警民互动"];
    NSArray * imageArr =@[@"home_security",@"home_monitor",@"home_door",@"home_security"];
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        PoliceHomeMenuItem * item =[PoliceHomeMenuItem new];
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
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,HOME_ADVH+HOME_MENU_H+SECTION_HEADER_H, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-(HOME_ADVH+HOME_MENU_H+SECTION_HEADER_H)) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
//
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
    
    static NSString *ID = @"PoliceHomeCellID";
    PoliceHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[PoliceHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (_shortDataArr.count>0) {
        
        PoliceHomeModel * model =_shortDataArr[indexPath.row];
        cell.signImageView.image=ImageNamed(@"home_monitor");
        cell.contentLabel.text =model.content;
        cell.timeLabel.text = model.time;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
