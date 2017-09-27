//
//  ClientTool.m
//  Drug
//
//  Created by 冉思路 on 2016/12/13.
//  Copyright © 2016年 xrg. All rights reserved.
//

#import "ClientTool.h"
#import "SLTabBar.h"
#import "BaseNavigationC.h"
@implementation ClientTool

+ (ClientTool *)sharedManager{
    
    static ClientTool *clientTool = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        clientTool = [[self alloc] init];
    });
    return clientTool;
    
    
}

//键盘自动布局
+(void)autoKeyboard{
    
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:0];
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
    
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    
    
    
}


//设置rootViewController 为 登录
+(UIViewController *)setupLogVC{
    
     LoginVC * loginVC =[[LoginVC alloc]init];
     BaseNavigationC *navigationC = [[BaseNavigationC alloc] initWithRootViewController:loginVC];

    return navigationC;
    
}

//设置rootViewController 为 Tabbar
+(UITabBarController *)setupTabBar{
    
    //控制器数组
    NSArray *controllerArray = @[@"HomeVC",@"PoliceVC",@"MessageVC",@"MyVC"];
    //title数组
    NSArray * titleArray = @[@"首页",@"警务平台",@"消息",@"我的"];
    //默认图片数组
    NSArray *imageArray= @[@"tabbar_home_unselect",@"tabbar_police_unselect",@"tabbar_message_unselect",@"tabbar_my_unselect"];
    //选中图片数组
    NSArray *selImageArray = @[@"tabbar_home_selected",@"tabbar_police_selected",@"tabbar_message_selected",@"tabbar_my_selected"];
    //tabBar高度
    CGFloat tabBarHeight = TABBAR_HEIGHT;
    
    //初始化(height:传nil或<49.0均按49.0处理)
    SLTabBar *tabbar = [[SLTabBar alloc] initWithControllerArray:controllerArray titleArray:titleArray imageArray:imageArray selImageArray:selImageArray height:tabBarHeight];
    
    //设置小红点(可选)
    [tabbar showPointMarkIndex:2];

    return tabbar;
    
}



// 开始定位
-(void)setupLocationManager{
    
    [[CurrentLocation sharedManager] getUSerLocation];
}


//是否显示密码
+(BOOL)isEysPasswordShow{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:IS_EYE_PASSWORD_SHOW])
    {
        
        return NO;
        
    }
    else
    {
        return YES;
        
    }

}



//保存是否显示密码
+(void)saveEyePassword:(BOOL)show{
    
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:IS_EYE_PASSWORD_SHOW];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


//保存taken
+(void)saveToken:(NSString *)token{
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


//获取taken
+(NSString *)getToken{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
}




@end
