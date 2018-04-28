//
//  HouseBindListCell.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "HouseBindListCell.h"
#import "HouseBindListModel.h"
@interface HouseBindListCell ()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * areaLabel;
@property(nonatomic,strong) UILabel * houseLabel;
@property(nonatomic,strong) UILabel * stateLabel;
@end

@implementation HouseBindListCell

+ (instancetype)myHouseBindListCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"myHouseBindListCellID";
    
    HouseBindListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[HouseBindListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initSubControls]; //初始化子控件
    }
    return self;
}

//子控件布局
- (void)layoutSubviews{
    self.areaLabel.frame = CGRectMake(10, 10, 200, 20);
    self.houseLabel.frame = CGRectMake(10, 35, 200, 20);
    self.stateLabel.frame = CGRectMake(SCREEN_WIDTH - 50, 20, 40, 20);
    self.underlineView.frame = CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5);
}

//初始化子控件
- (void)initSubControls{
    _areaLabel=[UILabel new];
    _areaLabel.textColor=[UIColor blueColor];
    _areaLabel.font= [UIFont systemFontOfSize:15];
    _areaLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_areaLabel];
    
    _houseLabel=[UILabel new];
    _houseLabel.textColor=[UIColor lightGrayColor];
    _houseLabel.font= [UIFont systemFontOfSize:13];
    _houseLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_houseLabel];
    
    _stateLabel=[UILabel new];
    _stateLabel.textColor=[UIColor whiteColor];
    _stateLabel.layer.cornerRadius = 5;
    _stateLabel.layer.masksToBounds = YES;
    _stateLabel.font= [UIFont systemFontOfSize:13];
    _stateLabel.textAlignment= NSTextAlignmentCenter;
    [self.contentView addSubview:_stateLabel];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

-(void)setModel:(HouseBindListModel *)model {
    _model = model;
    self.areaLabel.text = _model.disName;
    self.houseLabel.text =_model.houseName;
    if (_model.auditState == 1) {
        self.stateLabel.text = @"审核中";
    }else if (_model.auditState == 2) {
        self.stateLabel.text = @"已通过";
    }else if (_model.auditState == 3) {
        self.stateLabel.text = @"未通过";
    }
}

@end
