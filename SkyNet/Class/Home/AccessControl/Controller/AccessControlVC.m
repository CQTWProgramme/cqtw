//
//  AccessControlVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessControlVC.h"
#import "ACVIew.h"
#import "ACDistrictModel.h"
#import "ACModel.h"
#import "AccessControlDetailVC.h"
@interface AccessControlVC ()<ACViewDelegate>
@property (nonatomic, strong) ACVIew *acView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AccessControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self.view addSubview:self.acView];
}

-(NSMutableArray *)dataArr {
    if (nil == _dataArr) {
        _dataArr = [NSMutableArray array];
        
        ACDistrictModel *disModel1 = [[ACDistrictModel alloc] init];
        disModel1.qymc = @"测试1";
        ACDistrictModel *disModel2 = [[ACDistrictModel alloc] init];
        disModel2.qymc = @"测试2";
        ACDistrictModel *disModel3 = [[ACDistrictModel alloc] init];
        disModel3.qymc = @"测试3";
        
        NSArray *arr1 = @[disModel1,disModel2,disModel3];
        
        ACModel *model1 = [[ACModel alloc] init];
        model1.fzmc = @"自定义分组测试1";
        ACModel *model2 = [[ACModel alloc] init];
        model2.fzmc = @"自定义分组测试2";
        ACModel *model3 = [[ACModel alloc] init];
        model3.fzmc = @"自定义分组测试3";
        
        NSArray *arr2 = @[model1,model2,model3];
        
        [_dataArr addObject:arr1];
        [_dataArr addObject:arr2];
        
    }
    return _dataArr;
}

-(ACVIew *)acView {
    if (nil == _acView) {
        _acView =[[ACVIew alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _acView.delegate = self;
        _acView.groupArr = self.dataArr;
    }
    
    return _acView;
}

-(void)deleteACItem:(NSString *)customId updateCellBlock:(UpdateCellBlock)block {
    
}

-(void)editACItem:(NSString *)customId groupName:(NSString *)groupName modifyNameBlock:(ModifyNameBlock)block {
    
}

-(void)selectItem:(NSString *)itemId name:(NSString *)name section:(NSInteger)section {
    AccessControlDetailVC *detailVC = [[AccessControlDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addNewGroup {

}

@end
