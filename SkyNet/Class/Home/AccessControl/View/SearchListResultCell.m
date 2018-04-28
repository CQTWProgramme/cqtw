//
//  SearchListResultCell.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "SearchListResultCell.h"
#import "SearchListResultModel.h"
@interface SearchListResultCell ()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UIImageView * arrow;
@end

@implementation SearchListResultCell

+ (instancetype)searchListResultCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"SearchListResultCellID";
    
    SearchListResultCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[SearchListResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(0);
    }];
}

//初始化子控件
- (void)initSubControls{
    _nameLabel=[UILabel new];
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.font= [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    _arrow=[UIImageView new];
    _arrow.image = [UIImage imageNamed:@"home_rightArrow"];
    [self.contentView addSubview:_arrow];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

-(void)setModel:(SearchListResultModel *)model {
    _model = model;
    self.nameLabel.text = _model.wdmc;
}

@end
