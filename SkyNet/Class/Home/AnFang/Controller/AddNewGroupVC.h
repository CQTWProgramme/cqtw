//
//  AddNewGroupVC.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewController.h"

@interface AddNewGroupVC : BaseViewController
//分组父节点(默认为0)
@property (nonatomic, copy) NSString *fid;
//分组所属模块
@property (nonatomic, assign) NSInteger fzgn;
@end
