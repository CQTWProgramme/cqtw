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

@end
