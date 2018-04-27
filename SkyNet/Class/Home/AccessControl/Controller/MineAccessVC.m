//
//  MineAccessVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/26.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MineAccessVC.h"
#import "MineAccessBtnView.h"
#import "ACViewModel.h"
#import "DataEntryVC.h"
#import "AccessRecordVC.h"
#import "MyFaceVC.h"
#import "MyHousrListVC.h"

@interface MineAccessVC ()
@property(nonatomic, strong) NSArray *btnSourceArr;
@end

@implementation MineAccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的门禁";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupUI];
}

- (void)setupUI {
    __weak typeof(self) weakSelf = self;
    NSInteger col = 3;
    NSInteger btnCount = self.btnSourceArr.count;
    NSInteger row = 0;
    if ((btnCount % 3) == 0) {
        row = btnCount / 3;
    }else {
        row = (btnCount / 3) + 1;
    }
    CGFloat btnW = (SCREEN_WIDTH -2) / col;
    CGFloat btnH = btnW;
    
    for (NSInteger i = 0; i < row; i++) {
        for (NSInteger j = 0; j < col; j++) {
            NSDictionary *sourceDic = self.btnSourceArr[(i * col) + j];
            MineAccessBtnView *btnView = [[MineAccessBtnView alloc] init];
            btnView.accessImageView.image = [UIImage imageNamed:sourceDic[@"image"]];
            btnView.accessLabel.text = sourceDic[@"title"];
            btnView.btnActionBlock = ^{
                switch ((i * col) + j) {
                    case 0:
                        [weakSelf toMyFaceVC];
                        break;
                    case 1:
                        //点击进行实名认证
                        [weakSelf isNeedCertification];
                        break;
                    case 2:
                        //记录
                        [weakSelf toRecordVC];
                        break;
                    case 3:
                        NSLog(@"点击了4");
                        break;
                    case 4:
                        [weakSelf toHouseListVC];
                        break;
                    case 5:
                        NSLog(@"点击了6");
                        break;
                    default:
                        break;
                }
            };
            [self.view addSubview:btnView];
            CGFloat left = j * (btnW + 1);
            CGFloat top = i * (btnH + 1);
            [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(btnW));
                make.height.equalTo(@(btnH));
                make.left.equalTo(@(left));
                make.top.equalTo(@(top + 64));
            }];
        }
    }
}

-(NSArray *)btnSourceArr {
    if (nil == _btnSourceArr) {
        _btnSourceArr = @[@{@"title":@"我的人脸",@"image":@"your_face"},@{@"title":@"实名认证",@"image":@"your_info"},@{@"title":@"开门记录",@"image":@"your_door_his"},@{@"title":@"成员审核",@"image":@"your_audit"},@{@"title":@"我的房屋",@"image":@"your_house_list"},@{@"title":@"我绑定记录",@"image":@"add_house"}];
        
    }
    return _btnSourceArr;
}

- (void)toMyFaceVC {
    MyFaceVC *myfaceVC = [[MyFaceVC alloc] init];
    [self.navigationController pushViewController:myfaceVC animated:YES];
}

- (void)toRecordVC {
    AccessRecordVC *recordVC = [[AccessRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

-(void)toHouseListVC {
    MyHousrListVC *listVC = [[MyHousrListVC alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)isNeedCertification {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSDictionary *dic = returnValue;
        NSString *code = [dic objectForKey:@"request"];
        NSString *data = [dic objectForKey:@"data"];
        if (code.integerValue == 1) {
            if ([data isEqualToString:@"0"]) {
                [self showCertificationAlert];
            }else {
                
            }
        }else {
            [STTextHudTool showErrorText:@"请求失败"];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"请求失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"请求失败"];
    }];
    [viewModel IsNeedRealNameConfirm];
}

- (void)showCertificationAlert {
    MJWeakSelf
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否现在上传身份信息,以便进行房屋认证?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        DataEntryVC *dataVC = [[DataEntryVC alloc] init];
        [weakSelf.navigationController pushViewController:dataVC animated:YES];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
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
