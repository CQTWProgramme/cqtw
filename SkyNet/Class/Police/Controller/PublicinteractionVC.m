//
//  PublicinteractionVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "PublicinteractionVC.h"
#import "THCTextView.h"

@interface PublicinteractionVC ()
@property (strong, nonatomic) IBOutlet UIButton *complaintBtn;
@property (strong, nonatomic) IBOutlet UIButton *reportBtn;
@property (strong, nonatomic) IBOutlet UIButton *suggestBtn;
@property (strong, nonatomic) IBOutlet THCTextView *contentTextView;

@end

@implementation PublicinteractionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布互动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBackButtonTitle:@"取消"];
    [self createRightItem];
    [self setupTextView];
    [self setupBtnView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupTextView {
    self.contentTextView.placeHolder = @"请输入内容";
}

- (void)setupBtnView {
    self.complaintBtn.selected = NO;
    self.complaintBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.reportBtn.selected = NO;
    self.reportBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.suggestBtn.selected = NO;
    self.suggestBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
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

- (IBAction)reportTap:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.layer.borderColor = [UIColor greenColor].CGColor;
    }else {
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
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
