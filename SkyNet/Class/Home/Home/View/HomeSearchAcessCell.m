//
//  HomeSearchAcessCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchAcessCell.h"
#import "SearchResultAccessModel.h"

#define CELLHEIGHT 70.f  //设置行高
@interface HomeSearchAcessCell()
@property (nonatomic, weak) UIView *underlineView; //下划线
@property (nonatomic,strong)UIImageView * afImageView;
@property (nonatomic, strong) UILabel *afContentLabel;
@property (nonatomic,strong)UIImageView * arrowImageView;
@end

@implementation HomeSearchAcessCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"HomeSearchAcessCell";
    
    HomeSearchAcessCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[HomeSearchAcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _afImageView=[UIImageView new];
    [self.contentView addSubview:_afImageView];
    
    _arrowImageView=[UIImageView new];
    [self.contentView addSubview:_arrowImageView];
    
    _afContentLabel=[UILabel new];
    _afContentLabel.textColor=[UIColor darkGrayColor];
    _afContentLabel.font= [UIFont systemFontOfSize:13];
    _afContentLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_afContentLabel];
    
    UIView *underlineView = [[UIView alloc] init];
    [self.contentView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone; //设置单元格选中样式
}

//子控件布局
- (void)layoutSubviews{
    
    self.afImageView.frame = CGRectMake(10, 15, 40, 40);
    self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH - 20, 26, 10, 18);
    self.afContentLabel.frame = CGRectMake(_afImageView.right+10, 25, SCREEN_WIDTH-_afImageView.right-30, 20);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
    
}

-(void)setModel:(SearchResultAccessModel *)model {
    _model = model;
    self.arrowImageView.image = ImageNamed(@"home_rightArrow");
    self.afImageView.image=ImageNamed(@"icon_af");
    self.afContentLabel.text = _model.wdmc;
}

@end
