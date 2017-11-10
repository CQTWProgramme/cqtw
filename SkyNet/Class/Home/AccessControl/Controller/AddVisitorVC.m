//
//  AddVisitorVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AddVisitorVC.h"

@interface AddVisitorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *backCoverView;
@property (strong, nonatomic) IBOutlet UIView *bottomCheckView;
@property (strong, nonatomic) IBOutlet UITableView *dateCheckTableView;

@end

@implementation AddVisitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"访客登记";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self setupCheckTableView];
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

- (void)setupCheckTableView {
    self.dateCheckTableView.delegate = self;
    self.dateCheckTableView.dataSource = self;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"DateCheckTableViewcellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"一次";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"5分钟";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//提交访客登记
- (void)saveAction {
    
}
- (IBAction)dateCheckAction:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromBottom;
    animation.duration = 0.4;
    [self.backCoverView.layer addAnimation:animation forKey:nil];
    [self.bottomCheckView.layer addAnimation:animation forKey:nil];
    
    self.backCoverView.hidden = NO;
    self.bottomCheckView.hidden = NO;
}

- (IBAction)cancellAction:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.backCoverView.layer addAnimation:animation forKey:nil];
    [self.bottomCheckView.layer addAnimation:animation forKey:nil];
    self.backCoverView.hidden = YES;
    self.bottomCheckView.hidden = YES;
}

- (IBAction)doneAction:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.backCoverView.layer addAnimation:animation forKey:nil];
    [self.bottomCheckView.layer addAnimation:animation forKey:nil];
    self.backCoverView.hidden = YES;
    self.bottomCheckView.hidden = YES;
}

@end
