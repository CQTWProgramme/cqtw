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
/**
 根据功能(模糊)查询类型,功能查询网点,设备,通道数据(分页)
 */
-(void)getBdcDataLikeWithType:(NSString *)type gn:(NSString *)gn query:(NSString *)query currPage:(NSString *)currPage pageSize:(NSString *)pageSize;
@end
