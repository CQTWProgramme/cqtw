//
//  AddGroupPointVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AddGroupPointVC.h"
#import "MulChooseTable.h"
#import "AFViewModel.h"
#import "NetPointModel.h"
@interface AddGroupPointVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * mySearchBar;
@property (nonatomic, strong) MulChooseTable * myTable;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * selectArr;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,assign) NSInteger currPage;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) NSInteger totalPage;
@end

@implementation AddGroupPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currPage=0;
    _pageSize=10;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mySearchBar];
    [self createRightItem];
    [self.view addSubview:self.myTable];
     [self setNavBackButtonImage:ImageNamed(@"back")];
    self.title=@"新增分组";
    

}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    
     [rightBtn addTarget:self action:@selector(saveNet) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}


-(void)saveNet{
    
    MJWeakSelf
    [self.myTable getSelectArr:^(NSMutableArray *chooseArr) {
        //选择自定义分组数据（多选）
        [weakSelf.selectArr removeAllObjects];
        weakSelf.selectArr =chooseArr;
        [weakSelf addCustomData];
    }];
}

#pragma mark 添加自定义分组下数据
-(void)addCustomData{
    
    MJWeakSelf
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
       
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddGroupPointVCNotification" object:nil];
           [weakSelf.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]animated:YES];
            
        }

    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    NSString *type = [NSString stringWithFormat:@"%@",@(self.type)];
    [afViewModel requestAddCustomData:_customId dxlx:type ids:[afViewModel componentsInput:self.selectArr]];
}


#pragma mark 下拉刷新，上拉加载
-(void)refreshMyTabel:(NSInteger)page pageSize:(NSInteger)pageSize withQuery:(NSString *)query{
    
    MJWeakSelf
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
       
        NSMutableArray *arrayM=[NSMutableArray new];
        for (NSDictionary * dic in returnValue[@"rows"]) {
            NetPointModel * model =[NetPointModel mj_objectWithKeyValues:dic];
            [arrayM addObject:model];
        }
        
       
        weakSelf.totalPage=[returnValue[@"totalPage"] integerValue];
        
        //..下拉刷新
        if (weakSelf.myRefreshView == weakSelf.myTable.MyTable.mj_header) {
            [weakSelf.dataArr removeAllObjects];
            weakSelf.dataArr=arrayM;
            
        }else if(weakSelf.myRefreshView ==weakSelf.myTable.MyTable.mj_footer){
            
            if (arrayM.count==0) {
                
                [STTextHudTool showText:@"暂无更多内容"];
                
            }
            
            [self.dataArr addObjectsFromArray:arrayM];
        }
        
       weakSelf.myTable.dataArr = weakSelf.dataArr;
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [weakSelf.myTable.MyTable reloadData];
            [weakSelf.myRefreshView  endRefreshing];
            
        });
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    NSString *type = [NSString stringWithFormat:@"%@",@(self.type)];
    NSString *gn = [NSString stringWithFormat:@"%@",@(self.gn)];
    [afViewModel requestBdcDataLike:type gn:gn query:query currPage:page pageSize:pageSize];
}

#pragma mark 搜索框懒加载
-(UISearchBar * )mySearchBar{
    
    if (!_mySearchBar) {
        _mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH,44)];
        
        [_mySearchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        
        _mySearchBar.tintColor=[UIColor groupTableViewBackgroundColor];
        
       // [_mySearchBar setSearchBarPlaceholdePositon];
        _mySearchBar.delegate = self;
        [_mySearchBar setPlaceholder:@"请输入你要搜索的内容"];
        [_mySearchBar setContentMode:UIViewContentModeLeft];
        _mySearchBar.showsCancelButton=YES;

    }
    return _mySearchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请输入搜索内容"];
        return;
    }
    [self.myTable.MyTable.mj_header beginRefreshing];
}

#pragma mark 表格懒加载
-(MulChooseTable *)myTable{
    
    MJWeakSelf
    if (!_myTable) {
        
        _myTable = [MulChooseTable ShareTableWithFrame:CGRectMake(0, self.mySearchBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.mySearchBar.bottom) HeaderTitle:@"全选"];
        
        //..下拉刷新
        _myTable.MyTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = _myTable.MyTable.mj_header;
            weakSelf.currPage = 0;
            weakSelf.pageSize=10;
        
            [weakSelf refreshMyTabel:weakSelf.currPage pageSize:weakSelf.pageSize withQuery:self.mySearchBar.text];
        }];
        
        // 马上进入刷新状态
        [_myTable.MyTable.mj_header beginRefreshing];
        
        //..上拉刷新
        _myTable.MyTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.myTable.MyTable.mj_footer;
            weakSelf.currPage = weakSelf.currPage + 1;
            weakSelf.pageSize=10;
           [weakSelf refreshMyTabel:weakSelf.currPage pageSize:weakSelf.pageSize withQuery:self.mySearchBar.text];
            
        }];
        
        _myTable.MyTable.mj_footer.hidden = NO;
    }
    
    return _myTable;
}


-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr =[[NSMutableArray alloc]init];
    }
    return _dataArr;
}

-(NSMutableArray *)selectArr{
         
    if(!_selectArr){
        
        _selectArr=[[NSMutableArray alloc]init];
    }
    return _selectArr;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
