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
@interface MyVC ()<MyViewDelegate>
@property(nonatomic,strong)MyView * myView;
@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    [self.view addSubview:self.myView];
}

//-(void)viewWillAppear:(BOOL)animated{
//
//    self.navigationController.navigationBarHidden=YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//
//    self.navigationController.navigationBarHidden=NO;
//}


-(void)selectRowWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            MyInfo * myInfo =[[MyInfo  alloc]init];
            [self.navigationController pushViewController:myInfo animated:YES];
        }
            break;
        case 1:
        {
            ModifyPasswordVC * modify =[[ModifyPasswordVC alloc]init];
            [self.navigationController pushViewController:modify animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            AboutUsVC * aboutus=[[AboutUsVC alloc]init];
            [self.navigationController pushViewController:aboutus animated:YES];
        }
            break;
       
        default:
            break;
    }





}



-(MyView *)myView{
    
    if (!_myView) {
        _myView=[[MyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT)];
        _myView.delegate=self;
    }
    return _myView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
