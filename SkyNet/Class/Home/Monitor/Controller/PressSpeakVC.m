//
//  PressSpeakVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PressSpeakVC.h"

#define kViewHeight SCREEN_HEIGHT - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT - 324
@interface PressSpeakVC ()

@end

@implementation PressSpeakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    UIButton *speakButton = [UIButton buttonWithType:UIButtonTypeCustom];
    speakButton.frame = CGRectMake((SCREEN_WIDTH - (kViewHeight - 80)) / 2, 40, kViewHeight - 80, kViewHeight - 80);
    [self.view addSubview:speakButton];
    [speakButton setBackgroundImage:[UIImage imageNamed:@"monitor_speak"] forState:UIControlStateNormal];
    [speakButton addTarget:self action:@selector(spearkAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)spearkAction:(UIButton *)button {
    [STTextHudTool showErrorText:@"该功能暂未开放"];
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
