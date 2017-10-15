//
//  AFView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AFView.h"
#import "AFItemCell.h"
#import "AFModel.h"
#import "AFDistrictModel.h"
#import "AFDistrictItemCell.h"
@implementation AFView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.groupArr=[[NSMutableArray alloc]init];
        [self addSubview:self.myTableView];
    }
    
    return self;
}



-(void)setGroupArr:(NSMutableArray *)groupArr{
    
    
    _groupArr=groupArr;
       
}


-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.rowHeight=70;
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
               // [_myTableView.mj_header beginRefreshing];
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



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.groupArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AFDistrictItemCell *cell = [AFDistrictItemCell districtCellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([_groupArr[indexPath.section] count] > 0) {
            AFDistrictModel *model = _groupArr[indexPath.section][indexPath.row];
            cell.districtModel = model;
        }
        return cell;
    }else {
        AFItemCell *cell = [AFItemCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) tempSelf = self;
        __weak typeof(cell) tempCell = cell;
        
        if ([_groupArr[indexPath.section] count] > 0) {
            AFModel * afModel =_groupArr[indexPath.section][indexPath.row];
            [cell setData:afModel]; //设置数据
            //设置删除cell回调block
            cell.deleteAFItem = ^{
                
                if (tempSelf.delegate) {
                    [tempSelf.delegate deleteAFItem:afModel.customId updateCellBlock:^{
                        
                        NSIndexPath *tempIndex = [tempSelf.myTableView indexPathForCell:tempCell];
                        [_groupArr removeObject:tempCell.model];
                        [tempSelf.myTableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                    }];
                }
                
                
                
            };
            
            
            cell.editAFItem = ^{
                
                if (tempSelf.delegate) {
                    [tempSelf.delegate editAFItem:afModel.customId groupName:afModel.fzmc modifyNameBlock:^(NSString * groupName){
                        
                        [tempSelf.myTableView reloadData];
                    }];
                }
                
                
                
            };
            
            //设置当cell左滑时，关闭其他cell的左滑
            cell.closeOtherCellSwipe = ^{
                for (AFItemCell *item in tempSelf.myTableView.visibleCells) {
                    if ([item isKindOfClass:[AFItemCell class]]) {
                        if (item != tempCell) [item closeLeftSwipe];
                    }                    
                }
            };
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *itemId = nil;
    NSString *name = nil;
    if (indexPath.section == 0) {
        AFDistrictModel *model = _groupArr[indexPath.section][indexPath.row];
        itemId = model.districtId;
        name = model.qymc;
    }else {
        AFModel * model =_groupArr[indexPath.section][indexPath.row];
        itemId = model.customId;
        name = model.fzmc;
    }
    if (self.delegate) {
        [self.delegate selectItem:itemId name:name section:indexPath.section];
    }
    
    
}
@end
