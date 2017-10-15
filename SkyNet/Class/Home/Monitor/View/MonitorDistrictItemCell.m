//
//  MonitorDistrictItemCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorDistrictItemCell.h"
#define CELLHEIGHT 70.f  //设置行高

@interface MonitorDistrictItemCell ()
@property (nonatomic, weak) UIView *underlineView; //下划线

@property(nonatomic,strong)UIImageView * afImageView;
@end

@implementation MonitorDistrictItemCell

+ (instancetype)districtCellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"MonitorDistrictItemCell";
    
    MonitorDistrictItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MonitorDistrictItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    self.afContentLabel.frame = CGRectMake(_afImageView.right+10, 25, SCREEN_WIDTH-_afImageView.right-20, 20);
    
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
    
}


//设置要显示的数据
- (void)setData:(MonitorDistrictItemModel *)model{
    _model = model;
    
    self.afImageView.image=ImageNamed(@"home_monitor");
    self.afContentLabel.text =model.qymc;
}


@end
