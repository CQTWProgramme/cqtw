//
//  MonitorSecondView.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorSecondView.h"
#import "MonitorSecondDistrictPointCell.h"
#import "MonitorSecondGroupModel.h"
#import "MonitorSecondCustomPointCell.h"
#import "MonitorSecondCustomGroupCell.h"
#import "MonitorSecondPointModel.h"

@implementation MonitorSecondView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.myTableView];
    }
    return self;
}

-(void)setGroupArr:(NSMutableArray *)groupArr{
    
    _groupArr=groupArr;
    
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.rowHeight=70;
    }
    
    return _myTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == 0) {
        return 1;
    }else {
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == 0) {
        return self.groupArr.count;
    }else {
        return [self.groupArr[section] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 0) {
        if (_groupArr.count>0) {
            MonitorSecondDistrictPointCell *cell = [MonitorSecondDistrictPointCell cellWithTableView:tableView];
            MonitorSecondPointModel *model = self.groupArr[indexPath.row];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (self.type == 1) {
        if (_groupArr.count > 0) {
            if ([_groupArr[indexPath.section] count] > 0) {
                if (indexPath.section == 0) {
                    MonitorSecondCustomPointCell *cell = [MonitorSecondCustomPointCell cellWithTableView:tableView];
                    MonitorSecondPointModel * model =_groupArr[indexPath.section][indexPath.row];
                    cell.model = model;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    __weak typeof(self) tempSelf = self;
                    __weak typeof(cell) tempCell = cell;
                    cell.deleteAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate deleteMonitorSecondpoint:model.customId updateCellBlock:^{
                                NSIndexPath *tempIndex = [tempSelf.myTableView indexPathForCell:tempCell];
                                [_groupArr[indexPath.section] removeObject:tempCell.model];
                                [tempSelf.myTableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                            }];
                        }
                    };
                    cell.closeOtherCellSwipe = ^{
                        for (MonitorSecondCustomPointCell *item in tempSelf.myTableView.visibleCells) {
                            [item closeLeftSwipe];
                        }
                    };
                    return cell;
                }else if (indexPath.section == 1) {
                    MonitorSecondCustomGroupCell *cell = [MonitorSecondCustomGroupCell cellWithTableView:tableView];
                    MonitorSecondGroupModel * model =_groupArr[indexPath.section][indexPath.row];
                    cell.model = model;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //设置删除cell回调block
                    __weak typeof(self) tempSelf = self;
                    __weak typeof(cell) tempCell = cell;
                    cell.deleteAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate deleteMonitorSecondGroup:model.customId updateCellBlock:^{
                                NSIndexPath *tempIndex = [tempSelf.myTableView indexPathForCell:tempCell];
                                [_groupArr[indexPath.section] removeObject:tempCell.model];
                                [tempSelf.myTableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                            }];
                        }
                    };
                    cell.editAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate editMonitorSecondGroup:model.customId groupName:model.fzmc modifyNameBlock:^(NSString * groupName){
                                model.customId = groupName;
                                [tempCell closeLeftSwipe];
                                [tempSelf.myTableView reloadData];
                            }];
                        }
                    };
                    cell.closeOtherCellSwipe = ^{
                        for (MonitorSecondCustomGroupCell *item in tempSelf.myTableView.visibleCells) {
                            [item closeLeftSwipe];
                        }
                    };
                    
                    return cell;
                }
            }
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        if (_groupArr.count > 0) {
            MonitorSecondPointModel * model =_groupArr[indexPath.row];
            if (self.delegate) {
                [self.delegate selectPoint:model];
            }
        }
    }else if (self.type == 1) {
        if (_groupArr.count > 0) {
            if ([_groupArr[indexPath.section] count] > 0) {
                if (indexPath.section == 0) {
                    MonitorSecondPointModel * model =_groupArr[indexPath.section][indexPath.row];
                    if (self.delegate) {
                        [self.delegate selectPoint:model];
                    }
                }else if (indexPath.section == 1) {
                    MonitorSecondGroupModel *model = _groupArr[indexPath.section][indexPath.row];
                    if (self.delegate) {
                        [self.delegate selectGroup:model];
                    }
                }
            }
        }
    }
}

@end
