//
//  AnDetailVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AnDetailVC.h"
#import "AnDetailView.h"
@interface AnDetailVC ()
@property(nonatomic,strong)AnDetailView * anDetailView;
@end

@implementation AnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    MJWeakSelf
    self.title=@"安防详情";
     [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    
    
    [self.view addSubview:self.anDetailView];
}


-(void)createRightItem{
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"home_search") forState:UIControlStateNormal];
    
    // [rightBtn addTarget:self action:@selector(addNewGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}

-(AnDetailView *)anDetailView{
    
    if (!_anDetailView) {
       _anDetailView =[[AnDetailView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NavigationBar_HEIGHT) currentVC:self];
        //_afView.delegate=self;
    }
    return _anDetailView;
    
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
