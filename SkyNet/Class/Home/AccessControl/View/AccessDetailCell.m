//
//  AccessDetailCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AccessDetailCell.h"

#define CELLHEIGHT 80.0f

@interface AccessDetailCell()
@property (nonatomic, weak) UIView *underlineView; //下划线
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@end

@implementation AccessDetailCell

+ (instancetype)cellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"AccessDetailCell";
    
    AccessDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[AccessDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _contentLabel=[UILabel new];
    _contentLabel.textColor=[UIColor darkGrayColor];
    _contentLabel.font= [UIFont systemFontOfSize:13];
    _contentLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_contentLabel];
    
    _detailLabel=[UILabel new];
    _detailLabel.textColor=[UIColor lightGrayColor];
    _detailLabel.font= [UIFont systemFontOfSize:10];
    _detailLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_detailLabel];
    
    UIView *underlineView = [[UIView alloc] init];
    [self.contentView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
}

//子控件布局
- (void)layoutSubviews{
    
    self.contentLabel.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 15);
    self.detailLabel.frame = CGRectMake(10, self.contentLabel.bottom + 5, SCREEN_WIDTH-20, 10);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
}

-(void)setModel:(AccessDetailModel *)model {
    _model = model;
    self.contentLabel.text = _model.houseName;
    self.detailLabel.text = _model.disName;
}
@end
