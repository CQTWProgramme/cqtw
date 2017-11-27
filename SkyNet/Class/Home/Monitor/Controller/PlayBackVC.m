//
//  PlayBackVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PlayBackVC.h"

#define kViewHeight SCREEN_HEIGHT - NavigationBar_HEIGHT - STATUS_BAR_HEIGHT - 324
@interface PlayBackVC ()

@end

@implementation PlayBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    UIView *startTimeView = [[UIView alloc] initWithFrame:CGRectMake(40, (kViewHeight - 120) / 2, SCREEN_WIDTH - 80, 40)];
    startTimeView.userInteractionEnabled = YES;
    [self.view addSubview:startTimeView];
    startTimeView.layer.cornerRadius = 20;
    startTimeView.layer.masksToBounds = YES;
    startTimeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    startTimeView.layer.borderWidth = 1.0;
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkStartTime:)];
    [startTimeView addGestureRecognizer:startTap];
    
    UILabel *startTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (startTimeView.width - 20) / 2, startTimeView.height)];
    startTitleLabel.userInteractionEnabled = YES;
    startTitleLabel.font = [UIFont systemFontOfSize:13];
    startTitleLabel.text = @"请选择开始时间";
    startTitleLabel.textColor = [UIColor lightGrayColor];
    [startTimeView addSubview:startTitleLabel];
    [startTitleLabel addGestureRecognizer:startTap];
    
    UILabel *startContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(startTitleLabel.right, 0, (startTimeView.width - 20) / 2, startTimeView.height)];
    startContentLabel.userInteractionEnabled = YES;
    startContentLabel.font = [UIFont systemFontOfSize:13];
    startContentLabel.text = @"";
    startContentLabel.textAlignment = NSTextAlignmentRight;
    startContentLabel.textColor = [UIColor lightGrayColor];
    [startTimeView addSubview:startContentLabel];
    [startContentLabel addGestureRecognizer:startTap];
    
    UIView *endTimeView = [[UIView alloc] initWithFrame:CGRectMake(40, startTimeView.bottom + 40, SCREEN_WIDTH - 80, 40)];
    endTimeView.userInteractionEnabled = YES;
    [self.view addSubview:endTimeView];
    endTimeView.layer.cornerRadius = 20;
    endTimeView.layer.masksToBounds = YES;
    endTimeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    endTimeView.layer.borderWidth = 1.0;
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkEndTime:)];
    [endTimeView addGestureRecognizer:endTap];
    
    UILabel *endTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (endTimeView.width - 20) / 2, endTimeView.height)];
    endTitleLabel.userInteractionEnabled = YES;
    endTitleLabel.font = [UIFont systemFontOfSize:13];
    endTitleLabel.text = @"请选择开始时间";
    endTitleLabel.textColor = [UIColor lightGrayColor];
    [endTimeView addSubview:endTitleLabel];
    [endTitleLabel addGestureRecognizer:endTap];
    
    UILabel *endContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(endTitleLabel.right, 0, (endTimeView.width - 20) / 2, endTimeView.height)];
    endContentLabel.userInteractionEnabled = YES;
    endContentLabel.font = [UIFont systemFontOfSize:13];
    endContentLabel.text = @"";
    endContentLabel.textAlignment = NSTextAlignmentRight;
    endContentLabel.textColor = [UIColor lightGrayColor];
    [endTimeView addSubview:endContentLabel];
    [endContentLabel addGestureRecognizer:endTap];
    
}

- (void)checkStartTime:(UITapGestureRecognizer *)startTap {
    [STTextHudTool showErrorText:@"该功能暂未开通"];
}

- (void)checkEndTime:(UITapGestureRecognizer *)endTap {
    [STTextHudTool showErrorText:@"该功能暂未开通"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
