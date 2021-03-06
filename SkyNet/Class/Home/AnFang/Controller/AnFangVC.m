//
//  AnFangVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AnFangVC.h"
#import "AFView.h"
#import "AFViewModel.h"
#import "KYAlertView.h"
#import "AddNewGroupVC.h"
#import "NetDetailVC.h"
#import "AnDetailVC.h"
@interface AnFangVC ()<AFViewDelegate>
@property(nonatomic,strong)AFView * afView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation AnFangVC

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"安防列表";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"AddGroupPointVCNotification" object:nil];
     [self.view addSubview:self.afView];
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"title_add") forState:UIControlStateNormal];
    
     [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}


#pragma mark 下拉刷新
-(void)reloadTableView{
    [self getAfDistrictList];
}

#pragma mark 查询安防默认分组
-(void)getAfDistrictList{
    MJWeakSelf
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        if (weakSelf.dataArray.count > 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObject:returnValue];
        [weakSelf getAfList];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.afView.myRefreshView endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.afView.myRefreshView endRefreshing];
    }];
    
    [afViewModel requestDistrictList];
    
}

#pragma mark 查询安防自定义分组
-(void)getAfList{
    MJWeakSelf
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        [weakSelf.dataArray addObject:returnValue];
        
        [weakSelf.afView setGroupArr:weakSelf.dataArray];
        [weakSelf.afView.myTableView reloadData];
        [weakSelf.afView.myRefreshView  endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.afView.myRefreshView endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.afView.myRefreshView endRefreshing];
    }];
    
    [afViewModel requestListWithType:@"1"];
    
}


#pragma mark 删除安防自定义分组

-(void)deleteGroup:(NSString *)customId
       updateBlock:(UpdateCellBlock)block{
    
    
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
          
            dispatch_async(dispatch_get_main_queue(), ^{

                block();
            });
        }
        
       
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestDeleteGroup:customId];

}

#pragma mark 修改自定义分组名称

-(void)editGroup:(NSString *)customId
       groupName:(NSString *)groupName
 modifyNameBlock:(ModifyNameBlock)block
{
    AFViewModel * afViewModel =[AFViewModel new];
    [afViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(groupName);
            });
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [afViewModel requestEditGroup:groupName customId:customId];
}


#pragma mark Action delegate


#pragma mark 删除自定义分组
-(void)deleteAFItem:(NSString *)customId updateCellBlock:(UpdateCellBlock)block{
   
    
    MJWeakSelf
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该分组" preferredStyle:UIAlertControllerStyleAlert];
   
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [weakSelf deleteGroup:customId updateBlock:block];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
    
}

#pragma mark 编辑自定义分组
-(void)editAFItem:(NSString *)customId
        groupName:(NSString *)groupName
  modifyNameBlock:(ModifyNameBlock)block
{
    
    MJWeakSelf
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"编辑分组名" message:@"请输入您要编辑的名字" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [[alert textFieldAtIndex:0] setPlaceholder:@"输入分组名"];
    UITextField *tf=[alert textFieldAtIndex:0];//获得输入框
    tf.text=groupName;
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            NSLog(@"取消");
            
        }else  if (index == 1) {
            
            NSString * inputText=tf.text;//获得值
            if ([inputText isEqualToString:@""]) {
                
                [STTextHudTool showErrorText:@"分组名不能为空" withSecond:HudDelay];

            }else{
                
                [weakSelf editGroup:customId groupName:inputText modifyNameBlock:block];
            }
            
        }
    };
    
    [alert show];
}


#pragma mark 新增分组
-(void)addNewGroup{
    
    AddNewGroupVC * addNewGroupVC =[AddNewGroupVC new];
    addNewGroupVC.fzgn = 1;
    addNewGroupVC.fid = @"0";
    addNewGroupVC.type = 0;
    [self.navigationController pushViewController:addNewGroupVC animated:YES];
}

#pragma mark 表格选择
-(void)selectItem:(NSString *)itemId name:(NSString *)name section:(NSInteger)section{
    NetDetailVC * netDetailVC =[[NetDetailVC alloc]init];
    netDetailVC.groupTitle = name;
    netDetailVC.itemId = itemId;
    netDetailVC.type = section;
    netDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:netDetailVC animated:YES];
    
}

-(AFView *)afView{
    if (!_afView) {
        _afView =[[AFView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _afView.delegate=self;
    }
    
    return _afView;
}
@end
