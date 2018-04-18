//
//  AppDelegate.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/20.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AppDelegate.h"
#import "ClientTool.h"
#import <UMSocialCore/UMSocialCore.h>

//const static char* constStrServerAddrs = "223.4.33.127;54.84.132.236;112.124.0.188";
//const static short constIntServerPort = 15010;
//const static char*uuid = "63ff00caad684f7e99d451a0347a5378";
//const static char*appkey = "a2975dc17b9d4bee95c812091f284397";
//const static char*appSecret = "7e8bd859bba7486eb22e74adff4d3749";
//const static short constIntApiMoveCard = 4;
@interface AppDelegate ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [ClientTool autoKeyboard];
    [self initLocation];
    [self initiaUMSDK];
    [self initFunSdk];
    self.window.rootViewController= [ClientTool  setupLogVC];
    return YES;
}

- (void)initLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >8.0){
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)initFunSdk {
    [self funSDKSetting];
}

- (void)funSDKSetting {
    
//    SInitParam pa;
//    pa.nAppType = H264_DVR_LOGIN_TYPE_MOBILE;
//    FUN_Init(0, &pa);
//    FUN_InitNetSDK();
////
////    //设置用于存储设备信息等的数据配置文件
////
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//
//    NSString *path = [pathArray lastObject];
//
//    //设置配置文件存储目录
//
//    FUN_InitNetSDK();
//    FUN_SetFunStrAttr(EFUN_ATTR_CONFIG_PATH, [[path stringByAppendingString:@"/Configs/"] UTF8String]);
//
//    //设置升级文件存储目录
//
//    FUN_SetFunStrAttr(EFUN_ATTR_UPDATE_FILE_PATH,[[path stringByAppendingString:@"/Updates/"] UTF8String]);
//
//    //设置临时文件存储目录
//
//    FUN_SetFunStrAttr(EFUN_ATTR_TEMP_FILES_PATH,[[path stringByAppendingString:@"/Temps/"] UTF8String]);
//
//    //设置本地登录设备相关信息保存文件的位置
//
//    FUN_SysInit([[path stringByAppendingString:@"/LocalDevs.db"] UTF8String]);
//
//    //设置AP模式(app直连设备热点)下设置设备信息保存文件位置
//
//    FUN_SysInitAsAPModel([[path stringByAppendingString:@"/APDevs.db"] UTF8String]);
//
//    //设置云服务
//    FUN_XMCloundPlatformInit(uuid, appkey, appSecret, constIntApiMoveCard);
//
//    FUN_SysInit(constStrServerAddrs, constIntServerPort);
}

- (void)initiaUMSDK {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a0bdc348f4a9d2fe40000e6"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    // Custom code
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx65c9ab9cb62a599d" appSecret:@"c52b59af1585bdf5974940329dca3ddf" redirectURL:nil];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
