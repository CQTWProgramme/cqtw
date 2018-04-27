//
//  MyVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/20.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MyVC.h"
#import "MyView.h"
#import "MyInfo.h"
#import "ModifyPasswordVC.h"
#import "AboutUsVC.h"
#import "UserInfo.h"
@interface MyVC ()<MyViewDelegate>
@property(nonatomic,strong)MyView * myView;
@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我";
    [self.view addSubview:self.myView];
}

-(void)selectRowWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            MyInfo * myInfo =[[MyInfo  alloc]init];
            myInfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myInfo animated:YES];
        }
            break;
        case 1:
        {
            ModifyPasswordVC * modify =[[ModifyPasswordVC alloc]init];
            modify.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modify animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
//            AboutUsVC * aboutus=[[AboutUsVC alloc]init];
//            [self.navigationController pushViewController:aboutus animated:YES];
        }
            break;
        default:
            break;
    }





}



-(MyView *)myView{
    MJWeakSelf
    if (!_myView) {
        _myView=[[MyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT)];
        _myView.nameLabel.text = [UserInfo shareInstance].yhxm;
        _myView.delegate=self;
        _myView.logOutBlock = ^{
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出登录?" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [ClientTool removeToken];
                [STTextHudTool loadingWithTitle:@"退出"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                [UIApplication sharedApplication].keyWindow.rootViewController= [ClientTool  setupLogVC];
            }]];
            
            [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            // 3.显示alertController:presentViewController
            [weakSelf presentViewController:alertControl animated:YES completion:nil];
        };
    }
    return _myView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
