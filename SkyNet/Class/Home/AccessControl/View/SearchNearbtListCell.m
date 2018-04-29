//
//  SearchNearbtListCell.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "SearchNearbtListCell.h"
#import "SearchNearbyListModel.h"
@interface SearchNearbtListCell ()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * meterLabel;
@property(nonatomic,strong) UIImageView * arrow;
@end

@implementation SearchNearbtListCell
+ (instancetype)searchNearbtListCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"SearchNearbtListCellID";
    
    SearchNearbtListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[SearchNearbtListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    MJWeakSelf
    self.underlineView.frame = CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5);
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).with.offset(10);
    }];
    
    [self.meterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(0);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
    }];
}

//初始化子控件
- (void)initSubControls{
    _nameLabel=[UILabel new];
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.font= [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    _meterLabel=[UILabel new];
    _meterLabel.textColor=[UIColor blueColor];
    _meterLabel.font= [UIFont systemFontOfSize:13];
    _meterLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_meterLabel];
    
    _arrow=[UIImageView new];
    _arrow.image = [UIImage imageNamed:@"home_rightArrow"];
    [self.contentView addSubview:_arrow];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

-(void)setModel:(SearchNearbyListModel *)model {
    _model = model;
    self.nameLabel.text = _model.disName;
    self.meterLabel.text = [NSString stringWithFormat:@"(%@)",@([_model.meter floatValue]/1000)];
}
@end
