//
//  MonitorSecondVC.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//  监控二级列表

#import "BaseViewController.h"

@interface MonitorSecondVC : BaseViewController
@property(nonatomic,strong)NSString * groupTitle;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign) NSInteger type;
@end
