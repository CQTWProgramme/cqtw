//
//  AccessRecordCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessRecordCell.h"

@implementation AccessRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"AccessRecordCell";
    
    AccessRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"AccessRecordCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    return cell;
}

-(void)setModel:(VillageApplyModel *)model {
    _model = model;
    self.nameLabel.text = _model.disName;
    self.addressLabel.text = _model.houseName;
    if (_model.type == 1) {
        self.stateLabel.text = @"审核中";
    }else if (_model.type == 2) {
        self.stateLabel.text = @"审核通过";
    }else if (_model.type == 3) {
        self.stateLabel.text = @"未通过";
    }
}
@end
