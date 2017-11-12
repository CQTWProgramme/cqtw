//
//  RecordVisitorCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RecordVisitorCell.h"

#define CELLHEIGHT 80.0f

@interface RecordVisitorCell()
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *stateLabel;
@property (nonatomic, strong)UIView *underlineView;
@end

@implementation RecordVisitorCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"RecordVisitorCell";
    
    RecordVisitorCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[RecordVisitorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _nameLabel=[UILabel new];
    _nameLabel.textColor=[UIColor darkGrayColor];
    _nameLabel.font= [UIFont systemFontOfSize:13];
    _nameLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    
    
    _addressLabel=[UILabel new];
    _addressLabel.textColor=[UIColor darkGrayColor];
    _addressLabel.font= [UIFont systemFontOfSize:13];
    _addressLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_addressLabel];
    
    _stateLabel=[UILabel new];
    _stateLabel.textColor=[UIColor darkGrayColor];
    _stateLabel.font= [UIFont systemFontOfSize:13];
    _stateLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_stateLabel];
    
    UIView *underlineView = [[UIView alloc] init];
    [self.contentView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
}

//子控件布局
- (void)layoutSubviews{
    
    self.nameLabel.frame = CGRectMake(10, 15, 150, 15);
    self.addressLabel.frame = CGRectMake(10, self.nameLabel.bottom + 5, SCREEN_WIDTH-20, 10);
     self.stateLabel.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 40, 80);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);

}

-(void)setModel:(RecordVisitorModel *)model {
    _model = model;
    self.nameLabel.text = _model.name;
    self.addressLabel.text = _model.name;
}
@end
