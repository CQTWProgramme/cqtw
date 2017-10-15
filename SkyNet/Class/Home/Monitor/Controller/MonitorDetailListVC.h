//
//  MonitorDetailListVC.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//  监控详情列表

#import "BaseViewController.h"

@interface MonitorDetailListVC : BaseViewController
@property(nonatomic,strong)NSString * groupTitle;
@property (nonatomic, copy) NSString *customId;
@property (nonatomic, assign) NSInteger type;
@end
