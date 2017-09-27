//
//  MyView.m
//  SkyNet
//
//  Created by 冉思路 on 2017/8/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MyView.h"
#import "MyCell.h"
#define USER_TITLES  @[@"我的资料",@"修改密码",@"版本更新",@"关于我们"]
#define USER_IMAGES  @[@"user_info",@"user_modify_password",@"user_update",@"user_aboutus"]
#define HEAD_H 200
#define HEAD_IMAGE_H 90
#define TABLE_MARGIN 50
@implementation MyView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
       
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:frame];
        //imageView.image=ImageNamed(@"icon");
        imageView.backgroundColor=[UIColor whiteColor];
        [self addSubview:imageView];
        
       // self.backgroundColor=NAVI_COLOR;
        UIBezierPath * bPath = [UIBezierPath bezierPathWithRect:imageView.frame];
        UIBezierPath * aPath = [UIBezierPath bezierPath];
        [aPath moveToPoint:CGPointMake(0, HEAD_H)];
        [aPath addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, HEAD_H) controlPoint:CGPointMake(SCREEN_WIDTH/2, HEAD_H/2)];
        [aPath addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        [aPath addLineToPoint:CGPointMake(0, SCREEN_HEIGHT)];
        [aPath addLineToPoint:CGPointMake(0, HEAD_H)];
        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
        [bPath appendPath:[aPath bezierPathByReversingPath]];
        layer.path = bPath.CGPath;
        [imageView.layer setMask:layer];
        
        _headView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-HEAD_IMAGE_H/2, HEAD_H/2, HEAD_IMAGE_H, HEAD_IMAGE_H)];
        _headView.image=ImageNamed(@"user_icon");
        _headView.layer.masksToBounds=YES;
        _headView.layer.borderColor=[UIColor whiteColor].CGColor;
        _headView.layer.borderWidth=2;
        _headView.layer.cornerRadius=HEAD_IMAGE_H/2;
        [self addSubview:_headView];
        
        _nameLabel=[UILabel new];
        _nameLabel.frame=CGRectMake(10, CGRectGetMaxY(_headView.frame)+5, SCREEN_WIDTH-20, 20);
        _nameLabel.textColor=[UIColor darkGrayColor];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.text=@"1231241242";
        [self addSubview:_nameLabel];
        
        
        CGFloat tableY =CGRectGetMaxY(_nameLabel.frame)+44;
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(TABLE_MARGIN, tableY, SCREEN_WIDTH-2*TABLE_MARGIN, SCREEN_HEIGHT-tableY) style:UITableViewStylePlain];
        _myTableView.backgroundColor=[UIColor clearColor];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.rowHeight=44;
        _myTableView.tableFooterView=[[UIView alloc]init];
        [self addSubview:_myTableView];
        
    
    
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString *ID = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==4) {
        UIButton * btn =[UIButton new];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:btn];
        btn.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    
    }else{
    
    cell.logoImageView.image=ImageNamed(USER_IMAGES[indexPath.row]);
    cell.contentLabel.text =USER_TITLES[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
    
    
  
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate) {
        [self.delegate selectRowWithIndex:indexPath.row];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
  
    
        cell.backgroundColor = [UIColor clearColor];
        
    
    
}

-(void)logout{
    
}
@end
