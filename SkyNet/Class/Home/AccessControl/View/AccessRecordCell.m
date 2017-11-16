//
//  AccessRecordCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessRecordCell.h"
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LightGreenColor RGBColor(9.0f, 173.0f, 136.0f)
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
    if (_model.auditState == 1) {
        self.stateLabel.text = @"审核中";
    }else if (_model.auditState == 2) {
        self.stateLabel.backgroundColor = LightGreenColor;
        self.stateLabel.text = @"已通过";
    }else if (_model.auditState == 3) {
        self.stateLabel.text = @"未通过";
    }
}
@end
