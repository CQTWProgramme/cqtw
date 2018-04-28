//
//  HouseBindListDetailVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "HouseBindListDetailVC.h"
#import "HouseBindListModel.h"

@interface HouseBindListDetailVC ()

@end

@implementation HouseBindListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"智能人脸门禁";
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    MJWeakSelf
    UIView *topBackImageView = [[UIView alloc] init];
    topBackImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBackImageView];
    
    UILabel *topTitleLabel = [[UILabel alloc] init];
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    [topBackImageView addSubview:topTitleLabel];
    topTitleLabel.text = self.model.disName;
    
    UILabel *topContentLabel = [[UILabel alloc] init];
    topContentLabel.textAlignment = NSTextAlignmentCenter;
    [topBackImageView addSubview:topContentLabel];
    topContentLabel.text = self.model.houseName;
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"pass"];
    [topBackImageView addSubview:topImageView];
    
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.text = @"申请信息";
    sectionLabel.textColor = [UIColor lightGrayColor];
    sectionLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:sectionLabel];
    
    [topBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@(130));
    }];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topBackImageView.mas_right).with.offset(-10);
        make.top.equalTo(topBackImageView.mas_top).with.offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackImageView);
        make.right.equalTo(topBackImageView);
        make.top.equalTo(topBackImageView.mas_top).with.offset(40);
        make.height.equalTo(@(20));
    }];
    
    [topContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackImageView);
        make.right.equalTo(topBackImageView);
        make.top.equalTo(topTitleLabel.mas_bottom).with.offset(10);
        make.height.equalTo(@(20));
    }];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(topBackImageView.mas_bottom).with.offset(10);
        make.height.equalTo(@(20));
    }];
    
    for (NSInteger i = 0; i < 6; i++) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:contentView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [contentView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        [contentView addSubview:contentLabel];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.height.equalTo(@(40));
            make.top.equalTo(sectionLabel.mas_bottom).with.offset(i * 41);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).with.offset(20);
            make.top.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.width.equalTo(@(80));
        }];
        
        if (i == 4) {
            contentLabel.layer.cornerRadius = 5;
            contentLabel.layer.masksToBounds = YES;
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLabel.mas_right).with.offset(40);
                make.centerY.equalTo(contentView);
                make.width.equalTo(@(60));
                make.height.equalTo(@(20));
            }];
        }else {
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLabel.mas_right).with.offset(40);
                make.top.equalTo(contentView);
                make.bottom.equalTo(contentView);
                make.right.equalTo(contentView);
            }];
        }
        if (i == 0) {
            titleLabel.text = @"申请人:";
            contentLabel.text = self.model.name;
        }else if (i == 1) {
            titleLabel.text = @"申请类型:";
            if (self.model.type == 1) {
                contentLabel.text = @"业主";
            }else if (self.model.type == 2) {
                contentLabel.text = @"家庭成员";
            }else {
                contentLabel.text = @"租赁户";
            }
        }else if (i == 2) {
            titleLabel.text = @"申请时间:";
            contentLabel.text = self.model.applyTime;
        }else if (i == 3) {
            titleLabel.text = @"审核时间:";
            contentLabel.text = self.model.auditTime;
        }else if (i == 4) {
            titleLabel.text = @"审核状态:";
            if (self.model.auditState == 1) {
                contentLabel.text = @"审核中";
                contentLabel.backgroundColor = RGB(114, 203, 80);
            }else if (self.model.auditState == 2) {
                contentLabel.text = @"已通过";
                contentLabel.backgroundColor = RGB(203, 80, 80);
            }else {
                contentLabel.text = @"未通过";
                contentLabel.backgroundColor = RGB(114, 203, 80);
            }
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.textColor = [UIColor whiteColor];
        }else if (i == 5) {
            titleLabel.text = @"审核备注:";
            contentLabel.text = self.model.reason;
        }
    }
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.backgroundColor = [UIColor blueColor];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(20);
        make.height.equalTo(@(40));
        make.top.equalTo(sectionLabel.mas_bottom).with.offset(6 * 41 + 30);
    }];
}

- (void)sureAction {
    [self.navigationController popViewControllerAnimated:YES];
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
