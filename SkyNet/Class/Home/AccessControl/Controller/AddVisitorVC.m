//
//  AddVisitorVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AddVisitorVC.h"

@interface AddVisitorVC ()
@property (strong, nonatomic) IBOutlet UILabel *sexContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *beginTimeContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeContentLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation AddVisitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"访客登记";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
}

-(void)createRightItem{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

//提交访客登记
- (void)saveAction {
    
}

- (IBAction)sexCheckAction:(id)sender {
}

- (IBAction)beginTimeCheckAction:(id)sender {
}

- (IBAction)endTimeCheckAction:(id)sender {
}


@end
