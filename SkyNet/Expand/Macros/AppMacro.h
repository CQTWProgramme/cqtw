//
//  AppMacro.h
//  MoneyTree
//
//  Created by duck on 16/3/17.
//  Copyright © 2016年 yqs. All rights reserved.
//
/**
 *  app相关的宏定义
 */




#ifndef AppMacro_h
#define AppMacro_h

//App版本号
#define appVersion1 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]


//手机系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]



#define NET_ERROR  @"请检查网络"

#endif /* AppMacro_h */
