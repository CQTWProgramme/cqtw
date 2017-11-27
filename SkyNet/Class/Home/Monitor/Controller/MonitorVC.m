//
//  MonitorVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorVC.h"
#import "MonitorItemCell.h"
#import "MonitorItemModel.h"
#import "MonitorSecondVC.h"
#import "MonitorDistrictItemCell.h"
#import "MonitorViewModel.h"
#import "KYAlertView.h"
#import "AddNewGroupVC.h"

typedef void (^UpdateCellBlock)();
typedef void (^ModifyNameBlock)(NSString * groupName);
@interface MonitorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation MonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"监控列表";
    [self setupTableView];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"title_add") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

-(NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadData {
    MJWeakSelf
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    MonitorViewModel *mnViewModel = [MonitorViewModel new];
    [mnViewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf.dataArray addObject:returnValue];
        [weakSelf loadCustomList];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.mytableView.mj_header  endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.mytableView.mj_header  endRefreshing];
    }];
    [mnViewModel requestDistrictList];
}

- (void)loadCustomList {
    MJWeakSelf
    MonitorViewModel *mnViewModel = [MonitorViewModel new];
    [mnViewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf.dataArray addObject:returnValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [weakSelf.mytableView reloadData];
            [weakSelf.mytableView.mj_header  endRefreshing];
        });
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.mytableView.mj_header  endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.mytableView.mj_header  endRefreshing];
    }];
    [mnViewModel requestListWithType:@"4"];
}

- (void)setupTableView{
    MJWeakSelf
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.tableFooterView=[[UIView alloc]init];
    _mytableView.rowHeight=70;
    //..下拉刷新
    _mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    // 马上进入刷新状态
    [_mytableView.mj_header beginRefreshing];

    _mytableView.mj_footer.hidden = YES;
}

#pragma tableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        if ([self.dataArray[indexPath.section] count] > 0) {
            if (indexPath.section == 0) {
                MonitorDistrictItemCell *cell = [MonitorDistrictItemCell districtCellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                MonitorDistrictItemModel *model = self.dataArray[indexPath.section][indexPath.row];
                [cell setData:model];
                return cell;
            }else if (indexPath.section == 1) {
                MonitorItemCell *cell = [MonitorItemCell cellWithTableView:tableView];
                MonitorItemModel *model = self.dataArray[indexPath.section][indexPath.row];
                [cell setData:model];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                __weak typeof(self) tempSelf = self;
                __weak typeof(cell) tempCell = cell;
                
                    //设置删除cell回调block
                    cell.deleteAFItem = ^{
                        [tempSelf deleteGroup:model.customId updateBlock:^{
                            NSIndexPath *tempIndex = [tempSelf.mytableView indexPathForCell:tempCell];
                            [tempSelf.dataArray[indexPath.section] removeObject:tempCell.model];
                            [tempSelf.mytableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                        }];
                    };
                
                    cell.editAFItem = ^{
                        [tempSelf editAFItem:model.customId groupName:model.fzmc modifyNameBlock:^(NSString * groupName){
                            [tempCell closeLeftSwipe];
                            model.fzmc = groupName;
                            [tempSelf.mytableView reloadData];
                        }];
                    };
                    
                    //设置当cell左滑时，关闭其他cell的左滑
                    cell.closeOtherCellSwipe = ^{
                        for (MonitorItemCell *item in tempSelf.mytableView.visibleCells) {
                            if ([item isKindOfClass:[MonitorItemCell class]]) {
                                if (item != tempCell) [item closeLeftSwipe];
                            }
                        }
                    };
                return cell;
            }
        }
    }

    return nil;
}

#pragma mark 删除安防自定义分组

-(void)deleteGroup:(NSString *)customId
       updateBlock:(UpdateCellBlock)block{

    MonitorViewModel * mnViewModel =[MonitorViewModel new];
    [mnViewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [mnViewModel requestDeleteGroup:customId];
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

#pragma mark 修改自定义分组名称

-(void)editGroup:(NSString *)customId
       groupName:(NSString *)groupName
 modifyNameBlock:(ModifyNameBlock)block
{
    MJWeakSelf
    MonitorViewModel * mnViewModel =[MonitorViewModel new];
    [mnViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        NSString  *code =[NSString stringWithFormat:@"%@",returnValue];
        if ([code isEqualToString:@"1"]) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                block(groupName);
            });
        }
        
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [mnViewModel requestEditGroup:groupName customId:customId];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *grouptitle = nil;
    NSString *customId = nil;
    if ([self.dataArray[indexPath.section] count] > 0) {
        if (indexPath.section == 0) {
            MonitorDistrictItemModel *model = self.dataArray[indexPath.section][indexPath.row];
            grouptitle = model.qymc;
            customId = model.districtId;
        }else if (indexPath.section == 1) {
            MonitorItemModel *model = self.dataArray[indexPath.section][indexPath.row];
            grouptitle = model.fzmc;
            customId = model.customId;
        }
    }
    MonitorSecondVC *secondVC = [[MonitorSecondVC alloc] init];
    secondVC.groupTitle = grouptitle;
    secondVC.itemId = customId;
    secondVC.type = indexPath.section;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)addNewGroup {
    AddNewGroupVC * addNewGroupVC =[AddNewGroupVC new];
    addNewGroupVC.fzgn = 4;
    addNewGroupVC.fid = @"0";
    [self.navigationController pushViewController:addNewGroupVC animated:YES];
}

@end
