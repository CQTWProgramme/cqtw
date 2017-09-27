//
//  AFItemCell.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AFItemCell.h"
#define CELLHEIGHT 70.f  //设置行高
@interface AFItemCell()

@property (nonatomic, weak) UIButton *editBtn; //底层编辑按钮
@property (nonatomic, weak) UIButton *deleteBtn; //底层删除按钮
@property (nonatomic, assign) BOOL isOpenLeft; //是否已经打开左滑动
@property (nonatomic, weak) UISwipeGestureRecognizer *rightSwipe; //向右清扫手势
@property (nonatomic, weak) UIView *containerView; //容器view
@property (nonatomic, weak) UIView *underlineView; //下划线

@property(nonatomic,strong)UIImageView * afImageView;

@end
@implementation AFItemCell



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"AFItemCell";
    
    AFItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[AFItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initSubControls]; //初始化子控件
    }
    return self;
}



//初始化子控件
- (void)initSubControls{
    
    //1、添加底层层的电话和删除按钮
    UIButton *editBtn = [[UIButton alloc] init];
    [self.contentView addSubview:editBtn];
    self.editBtn = editBtn;
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setBackgroundColor:[UIColor orangeColor]];
    //绑定打电话事件
    [self.editBtn addTarget:self action:@selector(editAfItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.editBtn];
    
    UIButton *deleteBtn = [[UIButton alloc] init];
    [self.contentView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:[UIColor redColor]];
    //绑定删除会员事件
    [self.deleteBtn addTarget:self action:@selector(deleteMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.deleteBtn];

    //2、添加外层显示控件
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    self.containerView.backgroundColor = [UIColor whiteColor];
    
    
    _afImageView=[UIImageView new];
    [self.containerView addSubview:_afImageView];
    
    _afContentLabel=[UILabel new];
    _afContentLabel.textColor=[UIColor darkGrayColor];
    _afContentLabel.font= [UIFont systemFontOfSize:13];
    _afContentLabel.textAlignment= NSTextAlignmentLeft;
    [self.containerView addSubview:_afContentLabel];

    
    
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
    self.afImageView.frame = CGRectMake(10, 15, 40, 40);
    self.afContentLabel.frame = CGRectMake(_afImageView.right+10, 25, SCREEN_WIDTH-_afImageView.right-20, 20);
    
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
    

}


//设置要显示的数据
- (void)setData:(AFModel *)model{
    _model = model;
    
    self.afImageView.image=ImageNamed(@"home_monitor");
    self.afContentLabel.text =model.fzmc;
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











//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        
//        
//        _afImageView=[UIImageView new];
//        _afContentLabel=[UILabel new];
//        _afContentLabel.textColor=[UIColor darkGrayColor];
//        _afContentLabel.font= [UIFont systemFontOfSize:13];
//        _afContentLabel.textAlignment= NSTextAlignmentLeft;
//        
//        
//        
//        [self.contentView sd_addSubviews:@[_afImageView, _afContentLabel]];
//        
//        
//        
//        _afImageView.sd_layout
//        .widthIs(40)
//        .heightEqualToWidth()
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 10);
//        
//        _afContentLabel.sd_layout
//        .centerYEqualToView(_afImageView)
//        .leftSpaceToView(_afImageView, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .heightIs(20);
//        
//        
//        
//    }
//    return self;
//}

@end
