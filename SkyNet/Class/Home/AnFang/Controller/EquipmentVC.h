//
//  EquipmentVC.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewController.h"

@interface EquipmentVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView       * myTableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)   MJRefreshAutoFooter * myAutoFooter;
@property(nonatomic,assign)CGRect tableFrame;
@property (nonatomic, copy) NSString *customId;
@end
