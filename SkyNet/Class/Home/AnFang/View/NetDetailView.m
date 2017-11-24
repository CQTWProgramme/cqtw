//
//  NetDetailView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "NetDetailView.h"
#import "NetDetailCell.h"
#import "NetPointModel.h"
#import "NetDetailCustomCell.h"
#import "NetDetailDistrictCell.h"
#import "NetDetailDistrictModel.h"
@implementation NetDetailView

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
            NetDetailDistrictCell *cell = [NetDetailDistrictCell cellWithTableView:tableView];
            [cell setData:_groupArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (self.type == 1) {
        if (_groupArr.count > 0) {
            if ([_groupArr[indexPath.section] count] > 0) {
                if (indexPath.section == 0) {
                    NetDetailCustomCell *cell = [NetDetailCustomCell cellWithTableView:tableView];
                    NetDetailModel * afModel =_groupArr[indexPath.section][indexPath.row];
                    __weak typeof(self) tempSelf = self;
                    __weak typeof(cell) tempCell = cell;
                    [cell setData:afModel];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.deleteAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate deleteNetDetailItem:afModel.customId updateCellBlock:^{
                                NSIndexPath *tempIndex = [tempSelf.myTableView indexPathForCell:tempCell];
                                [_groupArr[indexPath.section] removeObject:tempCell.model];
                                [tempSelf.myTableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                            }];
                        }
                    };
                    cell.closeOtherCellSwipe = ^{
                        for (NetDetailCustomCell *item in tempSelf.myTableView.visibleCells) {
                            [item closeLeftSwipe];
                        }
                    };
                    return cell;
                }else if (indexPath.section == 1) {
                    NetDetailCell *cell = [NetDetailCell cellWithTableView:tableView];
                    NetDetailDistrictModel * afModel =_groupArr[indexPath.section][indexPath.row];
                    [cell setData:afModel];
                    //设置删除cell回调block
                    __weak typeof(self) tempSelf = self;
                    __weak typeof(cell) tempCell = cell;
                    cell.deleteAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate deleteNetDetailGroup:afModel.customId updateCellBlock:^{
                                NSIndexPath *tempIndex = [tempSelf.myTableView indexPathForCell:tempCell];
                                [_groupArr[indexPath.section] removeObject:tempCell.model];
                                [tempSelf.myTableView deleteRowsAtIndexPaths:@[tempIndex] withRowAnimation:UITableViewRowAnimationLeft];
                            }];
                        }
                    };
                    cell.editAFItem = ^{
                        if (tempSelf.delegate) {
                            [tempSelf.delegate editNetDetailGroup:afModel.customId groupName:afModel.fzmc modifyNameBlock:^(NSString * groupName){
                                afModel.fzmc = groupName;
                                [tempSelf.myTableView reloadData];
                            }];
                        }
                    };
                    cell.closeOtherCellSwipe = ^{
                        for (NetDetailCell *item in tempSelf.myTableView.visibleCells) {
                            [item closeLeftSwipe];
                        }
                    };
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            NetDetailModel * model =_groupArr[indexPath.row];
            if (self.delegate) {
                [self.delegate selectItem:model];
            }
        }
    }else if (self.type == 1) {
        if (_groupArr.count > 0) {
            if ([_groupArr[indexPath.section] count] > 0) {
                if (indexPath.section == 0) {
                    NetDetailModel * model =_groupArr[indexPath.section][indexPath.row];
                    if (self.delegate) {
                        [self.delegate selectItem:model];
                    }
                }else if (indexPath.section == 1) {
                    NetDetailDistrictModel *model = _groupArr[indexPath.section][indexPath.row];
                    if (self.delegate) {
                        [self.delegate districtSelectItem:model];
                    }
                }
            }
        }
    }
}
@end
