//
//  MemberApplyCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberApplyCell.h"

#define CELLHEIGHT 80.f  //设置行高
@interface MemberApplyCell ()
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UILabel     * detailLabel;
@property (nonatomic, weak) UIButton *editBtn; //底层编辑按钮
@property (nonatomic, weak) UIButton *deleteBtn; //底层删除按钮
@property (nonatomic, assign) BOOL isOpenLeft; //是否已经打开左滑动
@property (nonatomic, weak) UISwipeGestureRecognizer *rightSwipe; //向右清扫手势
@property (nonatomic, weak) UIView *containerView; //容器view
@property (nonatomic, weak) UIView *underlineView; //下划线
@end

@implementation MemberApplyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"MemberApplyCell";
    
    MemberApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MemberApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

//初始化子控件
- (void)initSubControls{
    
    //1、添加底层层的电话和删除按钮
    UIButton *editBtn = [[UIButton alloc] init];
    [self.contentView addSubview:editBtn];
    self.editBtn = editBtn;
    [self.editBtn setTitle:@"通过" forState:UIControlStateNormal];
    [self.editBtn setBackgroundColor:[UIColor orangeColor]];
    //绑定打电话事件
    [self.editBtn addTarget:self action:@selector(editAfItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.editBtn];
    
    UIButton *deleteBtn = [[UIButton alloc] init];
    [self.contentView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [self.deleteBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:[UIColor redColor]];
    //绑定删除会员事件
    [self.deleteBtn addTarget:self action:@selector(deleteMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.deleteBtn];
    
    //2、添加外层显示控件
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    self.containerView.backgroundColor = [UIColor whiteColor];
    
    _contentLabel=[UILabel new];
    _contentLabel.textColor=[UIColor darkGrayColor];
    _contentLabel.font= [UIFont systemFontOfSize:13];
    _contentLabel.textAlignment= NSTextAlignmentLeft;
    [self.containerView addSubview:_contentLabel];
    
    _detailLabel=[UILabel new];
    _detailLabel.textColor=[UIColor darkGrayColor];
    _detailLabel.font= [UIFont systemFontOfSize:10];
    _detailLabel.textAlignment= NSTextAlignmentLeft;
    [self.containerView addSubview:_detailLabel];
    
    
    UIView *underlineView = [[UIView alloc] init];
    [self.containerView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
    
    //3、给容器containerView绑定左右滑动清扫手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft; //设置向左清扫
    [self.containerView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;//设置向右清扫
    [self.containerView addGestureRecognizer:rightSwipe];
    self.rightSwipe = rightSwipe;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone; //设置单元格选中样式
    [self.contentView bringSubviewToFront:self.containerView]; //设置containerView显示在最上层
}

//子控件布局
- (void)layoutSubviews{
    
    
    CGFloat telWidth = SCREEN_WIDTH * 0.2; //设置编辑按钮宽度
    CGFloat deleteWidth = SCREEN_WIDTH * 0.2; //设置删除按钮宽度
    
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH * 0.6, 0, telWidth, CELLHEIGHT);
    self.deleteBtn.frame = CGRectMake(SCREEN_WIDTH * 0.8, 0, deleteWidth, CELLHEIGHT);
    
    self.containerView.frame = self.contentView.bounds;
    self.contentLabel.frame = CGRectMake(10, 15, self.containerView.width - 20, 20);
    self.detailLabel.frame = CGRectMake(10, self.contentLabel.bottom + 10, SCREEN_WIDTH-20, 15);
    
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
}

#pragma  mark - 事件操作
//拨打电话： 需要在真机测试效果
- (void)editAfItem: (UIButton *)sender{
    //如果实现了编辑block回调，则调用block
    if (self.editAFItem)
        self.editAFItem();
}

//删除会员
- (void)deleteMember: (UIButton *)sender{
    //如果实现了删除block回调，则调用block
    if (self.deleteAFItem)
        self.deleteAFItem();
}

//左滑动和右滑动手势
- (void)swipe: (UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft){
        if (self.isOpenLeft) return; //已经打开左滑，不再执行
        
        //开始左滑： 先调用block关闭其他可能左滑的cell
        if (self.closeOtherCellSwipe)
            self.closeOtherCellSwipe();
        
        [UIView animateWithDuration:0.5 animations:^{
            sender.view.center = CGPointMake(0, CELLHEIGHT * 0.5);
        }];
        self.isOpenLeft = YES;
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        [self closeLeftSwipe]; //关闭左滑
    }
}

//关闭左滑，恢复原状
- (void)closeLeftSwipe{
    if (!self.isOpenLeft) return; //还未打开左滑，不需要执行右滑
    
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.center = CGPointMake(SCREEN_WIDTH * 0.5, CELLHEIGHT * 0.5);
    }];
    self.isOpenLeft = NO;
}

@end
