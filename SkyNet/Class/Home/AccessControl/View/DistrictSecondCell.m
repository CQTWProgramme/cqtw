//
//  DistrictSecondCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "DistrictSecondCell.h"
#import "SelectDistrictSecondModel.h"

#define CELLHEIGHT 44.f  //设置行高

@interface DistrictSecondCell()
@property (nonatomic, weak) UIView *underlineView; //下划线
@property(nonatomic,strong)UILabel *disContentLabel;
@property(nonatomic,strong)UIImageView *rightArrow;
@end

@implementation DistrictSecondCell

+ (instancetype)districtSecondCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"DistrictSecondCellID";
    
    DistrictSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[DistrictSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    UIView *underlineView = [[UIView alloc] init];
    [self.contentView addSubview:underlineView]; //将下划线添加到容器containerView上
    self.underlineView = underlineView;
    self.underlineView.backgroundColor = [UIColor lightGrayColor];
    
}

//子控件布局
- (void)layoutSubviews{
    
    self.rightArrow.frame = CGRectMake(SCREEN_WIDTH - 20, 14.5, 10, 15);
    self.disContentLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-30, 44);
    self.underlineView.frame = CGRectMake(0, CELLHEIGHT - 0.5, SCREEN_WIDTH, 0.5);
}

-(void)setModel:(SelectDistrictSecondModel *)model {
    _model = model;
    self.disContentLabel.text = _model.mc;
}

@end
