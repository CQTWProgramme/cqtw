//
//  ACDistrictItemCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ACDistrictItemCell.h"
#import "ACDistrictModel.h"
#define CELLHEIGHT 70.f  //设置行高
@interface ACDistrictItemCell ()
@property (nonatomic, weak) UIView *underlineView; //下划线
@property(nonatomic,strong)UILabel     * afContentLabel;
@property(nonatomic,strong)UIImageView * afImageView;
@end

@implementation ACDistrictItemCell

+ (instancetype)districtCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"ACDistrictItemCell";
    
    ACDistrictItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[ACDistrictItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
}

//子控件布局
- (void)layoutSubviews{
    
    self.afImageView.frame = CGRectMake(10, 15, 40, 40);
    self.afContentLabel.frame = CGRectMake(_afImageView.right+10, 25, SCREEN_WIDTH-_afImageView.right-20, 20);
    
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
    
    
}

-(void)setDistrictModel:(ACDistrictModel *)districtModel {
    _districtModel = districtModel;
    self.afImageView.image=ImageNamed(@"home_monitor");
    self.afContentLabel.text =districtModel.qymc;
}

@end
