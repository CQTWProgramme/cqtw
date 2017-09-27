//
//  NextGroupVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "NextGroupVC.h"

@interface NextGroupVC ()

@end

@implementation NextGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"安防";
     [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
   
}

-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
   // [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
   
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
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
