//
//  MonitorSecondCustomGroupCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorSecondCustomGroupCell.h"
#import "MonitorSecondGroupModel.h"

@implementation MonitorSecondCustomGroupCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"MonitorSecondCustomGroupCell";
    
    MonitorSecondCustomGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MonitorSecondCustomGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

@end
