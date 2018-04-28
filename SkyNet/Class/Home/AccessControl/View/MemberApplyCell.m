//
//  MemberApplyCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MemberApplyCell.h"

#define CELLHEIGHT 60.f  //设置行高
@interface MemberApplyCell ()
@property(nonatomic,strong)UILabel  *disNameLabel;
@property(nonatomic,strong)UILabel  *houseLabel;
@property(nonatomic,strong)UILabel  *stateLabel;
@property (nonatomic,strong)UIView *underlineView; //下划线
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initSubControls]; //初始化子控件
    }
    return self;
}

//初始化子控件
- (void)initSubControls{
    
    _disNameLabel=[UILabel new];
    _disNameLabel.textColor=[UIColor darkGrayColor];
    _disNameLabel.font= [UIFont systemFontOfSize:15];
    _disNameLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_disNameLabel];
    
    _houseLabel=[UILabel new];
    _houseLabel.textColor=[UIColor lightGrayColor];
    _houseLabel.font= [UIFont systemFontOfSize:13];
    _houseLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_houseLabel];
    
    _stateLabel=[UILabel new];
    _stateLabel.textColor=[UIColor whiteColor];
    _stateLabel.layer.cornerRadius = 5;
    _stateLabel.layer.masksToBounds = YES;
    _stateLabel.font= [UIFont systemFontOfSize:10];
    _stateLabel.textAlignment= NSTextAlignmentCenter;
    [self.contentView addSubview:_stateLabel];
    
    _underlineView = [[UIView alloc] init];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

//子控件布局
- (void)layoutSubviews{
    self.disNameLabel.frame = CGRectMake(10, 10, 250, 20);
    self.houseLabel.frame = CGRectMake(10, 30, 250, 20);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
}

-(void)setModel:(MemberApplyModel *)model {
    _model = model;
    self.disNameLabel.text = _model.disName;
    self.houseLabel.text = _model.houseName;
    if (_model.type == 1) {
        self.stateLabel.text = @"业主";
        self.stateLabel.backgroundColor = RGB(76, 155, 245);
        self.stateLabel.frame = CGRectMake(SCREEN_WIDTH - 40, 20, 30, 20);
    }else if(_model.type == 3) {
        self.stateLabel.text = @"家庭成员";
        self.stateLabel.backgroundColor = RGB(73, 213, 116);
        self.stateLabel.frame = CGRectMake(SCREEN_WIDTH - 70, 20, 60, 20);
    }else if (_model.type == 4) {
        self.stateLabel.text = @"租户";
        self.stateLabel.backgroundColor = RGB(245, 175, 76);
        self.stateLabel.frame = CGRectMake(SCREEN_WIDTH - 40, 20, 30, 20);
    }
}
@end
