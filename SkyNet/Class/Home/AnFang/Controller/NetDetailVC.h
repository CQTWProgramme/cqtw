//
//  NetDetailVC.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewController.h"

@interface NetDetailVC : BaseViewController
@property(nonatomic,strong)NSString * groupTitle;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign) NSInteger type;
@end
