//
//  MoreHistoryVC.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^HistroyReturnHandle)(NSString *historyStr);
@interface MoreHistoryVC : BaseViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) HistroyReturnHandle historyHandle;
@end
