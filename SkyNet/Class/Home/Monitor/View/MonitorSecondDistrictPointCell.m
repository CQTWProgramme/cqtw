//
//  MonitorSecondDistrictPointCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorSecondDistrictPointCell.h"
#import "MonitorSecondPointModel.h"

@implementation MonitorSecondDistrictPointCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"MonitorSecondDistrictPointCell";
    
    MonitorSecondDistrictPointCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MonitorSecondDistrictPointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

@end
