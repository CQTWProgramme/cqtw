//
//  MonitorSecondCustomPointCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorSecondCustomPointCell.h"
#import "MonitorSecondPointModel.h"
@implementation MonitorSecondCustomPointCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"MonitorSecondCustomPointCell";
    
    MonitorSecondCustomPointCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MonitorSecondCustomPointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

@end
