//
//  HomeViewModel.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel


/**
 获取广告位轮播图
 */
-(void)requestAdverList;


/**
 获取快捷方式列表
 */
-(void)requestShortcutList;
@end
