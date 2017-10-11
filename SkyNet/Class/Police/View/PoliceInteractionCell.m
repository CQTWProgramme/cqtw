//
//  PoliceInteractionCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PoliceInteractionCell.h"

@implementation PoliceInteractionCell

+ (instancetype)interCellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"PoliceInteractionCellID";
    
    PoliceInteractionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PoliceInteractionCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
