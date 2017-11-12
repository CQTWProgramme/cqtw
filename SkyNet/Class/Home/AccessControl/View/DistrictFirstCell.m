//
//  DistrictFirstCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "DistrictFirstCell.h"
#import "SelectDistrictFirstModel.h"

#define CELLHEIGHT 70.f  //设置行高

@interface DistrictFirstCell()
@property (nonatomic, weak) UIView *underlineView; //下划线
@property(nonatomic,strong)UILabel *disContentLabel;
@property(nonatomic,strong)UILabel *disDetailLabel;
@property(nonatomic,strong)UIImageView *rightArrow;
@end

@implementation DistrictFirstCell

+ (instancetype)districtFirstCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"DistrictFirstCellID";
    
    DistrictFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[DistrictFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _rightArrow=[UIImageView new];
    _rightArrow.image = [UIImage imageNamed:@"more"];
    [self.contentView addSubview:_rightArrow];
    
    _disContentLabel=[UILabel new];
    _disContentLabel.textColor=[UIColor darkGrayColor];
    _disContentLabel.font= [UIFont systemFontOfSize:13];
    _disContentLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_disContentLabel];
    
    _disDetailLabel=[UILabel new];
    _disDetailLabel.textColor=[UIColor lightGrayColor];
    _disDetailLabel.font= [UIFont systemFontOfSize:10];
    _disDetailLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_disDetailLabel];
    
    
    
    UIView *underlineView = [[UIView alloc] init];
    [self.contentView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
}

//子控件布局
- (void)layoutSubviews{
    
    self.rightArrow.frame = CGRectMake(SCREEN_WIDTH - 20, 27.5, 10, 15);
    self.disContentLabel.frame = CGRectMake(10, 15, SCREEN_WIDTH-30, 15);
    self.disDetailLabel.frame = CGRectMake(10, self.disContentLabel.bottom + 5, SCREEN_WIDTH-30, 10);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
}

-(void)setModel:(SelectDistrictFirstModel *)model {
    _model = model;
    self.disContentLabel.text = _model.wdmc;
    self.disDetailLabel.text = _model.wdmc;
}
@end
