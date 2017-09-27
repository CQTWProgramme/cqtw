//
//  UtilsMacro.h
//  MoneyTree
//
//  Created by duck on 16/3/17.
//  Copyright © 2016年 yqs. All rights reserved.
//
/**
 *  方便使用的宏定义
 */
#ifndef UtilsMacro_h
#define UtilsMacro_h


//自定义高效率的 NSLog
#ifdef DEBUG
#define SLLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define SLLog(...)

#endif


//弱引用/强引用
#define SLWeakSelf(type)  __weak typeof(type) weak##type = type;
#define SLStrongSelf(type)  __strong typeof(type) type = weak##type;


//获取通知中心
#define SLNotificationCenter [NSNotificationCenter defaultCenter]

//获取rootController
#define Key_Window  [UIApplication sharedApplication].keyWindow.rootViewController


//获取设备大小
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define  SLFont(f) [UIFont systemFontOfSize:(f)]

//NavBar高度
#define NavigationBar_HEIGHT 44

//状态栏高度
#define STATUS_BAR_HEIGHT 20

//状态栏高度
#define TABBAR_HEIGHT 49


//定义UIImage对象
#define ImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//获取 hex 颜色
#define HexColor(hex) [UIColor colorWithHexString:[NSString stringWithFormat:@"%@",hex]];




//常用颜色系
#define BACKGROUND_COLOR RGBA(236,236,236,1)//背景色
#define NAVI_COLOR RGBA(22,82,244,1)//导航背景色

#define DefineWeakSelf __weak __typeof(self) weakSelf = self




#define HudDelay  2
#endif /* UtilsMacro_h */
