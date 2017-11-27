//
//  PTZControlVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PTZControlVC.h"
#define kViewHeight SCREEN_HEIGHT - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT - 324
@interface PTZControlVC ()

@end

@implementation PTZControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    UIImageView *ptzBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -(kViewHeight - 80)) / 2, 40, kViewHeight - 80, kViewHeight - 80)];
    ptzBackImageView.image = [UIImage imageNamed:@"ptz-bg"];
    ptzBackImageView.userInteractionEnabled = YES;
    [self.view addSubview:ptzBackImageView];
    
    UIButton *ptzLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    ptzLeft.frame = CGRectMake(0, (ptzBackImageView.height - ptzBackImageView.height / 3) / 2, ptzBackImageView.width / 3, ptzBackImageView.height / 3);
    [ptzBackImageView addSubview:ptzLeft];
    [ptzLeft setImage:[UIImage imageNamed:@"ptz-left"] forState:UIControlStateNormal];
    [ptzLeft addTarget:self action:@selector(leftTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ptzRight = [UIButton buttonWithType:UIButtonTypeCustom];
    ptzRight.frame = CGRectMake(ptzBackImageView.width / 3 * 2, (ptzBackImageView.height - ptzBackImageView.height / 3) / 2, ptzBackImageView.width / 3, ptzBackImageView.height / 3);
    [ptzBackImageView addSubview:ptzRight];
    [ptzRight setImage:[UIImage imageNamed:@"ptz-right"] forState:UIControlStateNormal];
    [ptzRight addTarget:self action:@selector(rightTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ptzUp = [UIButton buttonWithType:UIButtonTypeCustom];
    ptzUp.frame = CGRectMake((ptzBackImageView.width - ptzBackImageView.width / 3) / 2, 0, ptzBackImageView.width / 3, ptzBackImageView.height / 3);
    [ptzBackImageView addSubview:ptzUp];
    [ptzUp setImage:[UIImage imageNamed:@"ptz-up"] forState:UIControlStateNormal];
    [ptzUp addTarget:self action:@selector(upTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ptzDown = [UIButton buttonWithType:UIButtonTypeCustom];
    ptzDown.frame = CGRectMake((ptzBackImageView.width - ptzBackImageView.width / 3) / 2, ptzBackImageView.height / 3 * 2, ptzBackImageView.width / 3, ptzBackImageView.height / 3);
    [ptzBackImageView addSubview:ptzDown];
    [ptzDown setImage:[UIImage imageNamed:@"ptz-down"] forState:UIControlStateNormal];
    [ptzDown addTarget:self action:@selector(downTap:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)leftTap:(UIButton *)left {
    [STTextHudTool showErrorText:@"该视频不支持PTZ"];
}

- (void)rightTap:(UIButton *)right {
    [STTextHudTool showErrorText:@"该视频不支持PTZ"];
}

- (void)upTap:(UIButton *)up {
    [STTextHudTool showErrorText:@"该视频不支持PTZ"];
}

- (void)downTap:(UIButton *)down {
    [STTextHudTool showErrorText:@"该视频不支持PTZ"];
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
