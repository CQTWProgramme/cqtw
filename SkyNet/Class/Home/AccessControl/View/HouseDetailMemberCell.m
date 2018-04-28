//
//  HouseDetailMemberCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2018/4/28.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "HouseDetailMemberCell.h"
#import "HouseDetailMemberModel.h"
@interface HouseDetailMemberCell()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * phoneLabel;
@end

@implementation HouseDetailMemberCell

+ (instancetype)myHouseDetailMemberCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"myHouseDetailMemberCellID";
    
    HouseDetailMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[HouseDetailMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    self.nameLabel.frame = CGRectMake(10, 10, 200, 15);
    self.phoneLabel.frame = CGRectMake(10, 35, 200, 15);
    self.underlineView.frame = CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5);
}

//初始化子控件
- (void)initSubControls{
    _nameLabel=[UILabel new];
    _nameLabel.textColor=[UIColor darkGrayColor];
    _nameLabel.font= [UIFont systemFontOfSize:13];
    _nameLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    _phoneLabel=[UILabel new];
    _phoneLabel.textColor=[UIColor lightGrayColor];
    _phoneLabel.font= [UIFont systemFontOfSize:13];
    _phoneLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_phoneLabel];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

-(void)setModel:(HouseDetailMemberModel *)model {
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"*%@",_model.name];
    self.phoneLabel.text =_model.phone;
}
@end
