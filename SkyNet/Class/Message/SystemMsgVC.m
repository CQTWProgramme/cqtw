//
//  SystemMsgVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/3.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "SystemMsgVC.h"

@interface SystemMsgVC ()

@end

@implementation SystemMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array =[NSMutableArray array];
    for ( int i = 0; i< 20; i++) {
        [array addObject:@"系统消息"];
    }
    self.dataA = array;

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
