//
//  ChooseDistrictThirdVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ChooseDistrictThirdVC.h"

@interface ChooseDistrictThirdVC ()

@end

@implementation ChooseDistrictThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"门禁";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
