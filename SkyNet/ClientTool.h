//
//  ClientTool.h
//  Drug
//
//  Created by 冉思路 on 2016/12/13.
//  Copyright © 2016年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginVC.h"
@interface ClientTool : NSObject

+ (ClientTool *)sharedManager;

/**
 *  键盘自动布局
 */
+(void)autoKeyboard;


/**
 *  设置rootViewController 为 登录
 */
+(UIViewController *)setupLogVC;




/**
 *  设置rootViewController 为 Tabbar
 */
+(UITabBarController *)setupTabBar;



/**
 *  设置定位
 */
-(void)setupLocationManager;



/**
 *  是否显示密码
 */
+(BOOL)isEysPasswordShow;



/**
 *  保存是否显示密码
 */
+(void)saveEyePassword:(BOOL)show;


/**
 *  保存taken
 */
+(void)saveToken:(NSString *)token;


/**
 *  获取taken
 */
+(NSString *)getToken;

@end
