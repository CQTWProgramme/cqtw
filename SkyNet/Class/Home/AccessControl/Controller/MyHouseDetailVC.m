//
//  MyHouseDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MyHouseDetailVC.h"
#import "QBQuSegmentView.h"
#import "HouseOwnerVC.h"
#import "FamilyMemberVC.h"
#import "RenterVC.h"
#import "ACViewModel.h"
#import "MyHouseDetailModel.h"
#import "HouseDetailMemberModel.h"

@interface MyHouseDetailVC ()<UIScrollViewDelegate,QBQuSegmentViewDelegate>
@property(nonatomic,strong)QBQuSegmentView *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong)MyHouseDetailModel *model;
@property (nonatomic, strong)NSMutableArray *ownerArray;
@property (nonatomic, strong)NSMutableArray *memberArray;
@property (nonatomic, strong)NSMutableArray *renterArray;
@end

@implementation MyHouseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"房屋详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    
    [self loadData];
}

-(NSMutableArray *)ownerArray {
    if (nil == _ownerArray) {
        _ownerArray = [NSMutableArray array];
    }
    return _ownerArray;
}

-(NSMutableArray *)memberArray {
    if (nil == _memberArray) {
        _memberArray = [NSMutableArray array];
    }
    return _memberArray;
}

-(NSMutableArray *)renterArray {
    if (nil == _renterArray) {
        _renterArray = [NSMutableArray array];
    }
    return _renterArray;
}
-(void)loadData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            self.model = [MyHouseDetailModel mj_objectWithKeyValues:returnValue[@"data"]];
            self.areaNameLabel.text = self.model.disName;
            self.roomNameLabel.text = self.model.houseName;
            self.locationLabel.text = self.model.areasName;
            if (self.model.nameAndTypeList.count > 0) {
                for (NSDictionary *dic in self.model.nameAndTypeList) {
                    HouseDetailMemberModel *model = [HouseDetailMemberModel mj_objectWithKeyValues:dic];
                    if (model.type == 1) {
                        [self.ownerArray addObject:model];
                    }else if (model.type == 3) {
                        [self.memberArray addObject:model];
                    }else if (model.type == 4) {
                        [self.renterArray addObject:model];
                    }
                }
            }
            [self.view addSubview:self.mainScrollView];
            [self.view addSubview:self.segmentView];

            [self setupChildVc:[HouseOwnerVC class] x:0];
            [self setupChildVc:[FamilyMemberVC class] x:1  * SCREEN_WIDTH];
            [self setupChildVc:[RenterVC class] x:2  * SCREEN_WIDTH];
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"加载失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"加载失败"];
    }];
    if (self.areasId == nil) {
        self.areasId = @"";
    }
    [viewModel acGetHouseDetialWithAreasId:self.areasId];
}

-(void)QBQuSegmentView:(QBQuSegmentView *)segmentView didSelectBtnAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    
    CGFloat offsetX = index * self.view.frame.size.width;
    // 2.给对应位置添加对应子控制器
    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self showVc:index];
}

- (void)setupChildVc:(Class)c x:(CGFloat)x
{
    if (x == 0) {
        HouseOwnerVC *vc = [HouseOwnerVC new];
        vc.dataArray = self.ownerArray;
        [self.mainScrollView addSubview:vc.view];
        
        vc.view.frame = CGRectMake(x, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
        [self addChildViewController:vc];
    }else if (x== SCREEN_WIDTH) {
        FamilyMemberVC *vc = [FamilyMemberVC new];
        vc.dataArray = self.memberArray;
        [self.mainScrollView addSubview:vc.view];
        
        vc.view.frame = CGRectMake(x, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
        [self addChildViewController:vc];
    }else {
        RenterVC *vc = [RenterVC new];
        vc.dataArray = self.renterArray;
        [self.mainScrollView addSubview:vc.view];
        
        vc.view.frame = CGRectMake(x, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
        [self addChildViewController:vc];
    }
}


// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    BaseViewController *vc = self.childViewControllers[index];
    
    vc.view.frame = CGRectMake(offsetX, 45, SCREEN_WIDTH, self.mainScrollView.height-45);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        // 1.添加子控制器view
        [self showVc:index];
        
        
        // 2.把对应的标题选中
        [self.segmentView titleBtnSelectedWithScrollView:scrollView];
    }
    
}

-(QBQuSegmentView *)segmentView{
    if (!_segmentView) {
        NSString *ownerTitle = [NSString stringWithFormat:@"业主(%@)",@(self.ownerArray.count)];
        NSString *memberTitle = [NSString stringWithFormat:@"家庭成员(%@)",@(self.memberArray.count)];
        NSString *renterTitle = [NSString stringWithFormat:@"租户(%@)",@(self.renterArray.count)];
        _segmentView =[[QBQuSegmentView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT + 150, SCREEN_WIDTH, 45) titlesA:@[ownerTitle,memberTitle,renterTitle]];
        _segmentView.backgroundColor =[UIColor whiteColor];
        _segmentView.delegate = self;
    }
    [_segmentView setLineColor:NAVI_COLOR];
    
    return _segmentView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,STATUS_BAR_HEIGHT+NavigationBar_HEIGHT + 150, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT - 150)];
        _mainScrollView.contentSize = CGSizeMake(3 *SCREEN_WIDTH,0 );
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.scrollEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
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
