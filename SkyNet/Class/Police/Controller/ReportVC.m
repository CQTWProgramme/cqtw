//
//  ReportVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ReportVC.h"
#import "THCTextView.h"

@interface ReportVC ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *titleTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *picScrollerView;
@property (strong, nonatomic) IBOutlet THCTextView *contentTextView;

@end

@implementation ReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要举报";
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentTextView.placeHolder = @"请输入内容";
    [self setNavBackButtonTitle:@"取消"];
    [self createRightItem];
    // Do any additional setup after loading the view from its nib.
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)saveAction {
    
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
