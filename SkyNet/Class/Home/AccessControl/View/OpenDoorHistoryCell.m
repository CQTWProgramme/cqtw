//
//  OpenDoorHistoryCell.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "OpenDoorHistoryCell.h"
#import "OpenDoorHistoryModel.h"

@interface OpenDoorHistoryCell ()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UILabel * rightLabel;
@property(nonatomic,strong) UILabel * stateLabel;
@property(nonatomic,strong) UIView *myContentView;
@end

@implementation OpenDoorHistoryCell

+ (instancetype)openDoorHistoryCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"OpenDoorHistoryCellID";
    
    OpenDoorHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[OpenDoorHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _stateLabel=[UILabel new];
    _stateLabel.layer.cornerRadius = 5;
    _stateLabel.layer.masksToBounds = YES;
    _stateLabel.textColor=[UIColor whiteColor];
    _stateLabel.font= [UIFont systemFontOfSize:13];
    _stateLabel.textAlignment= NSTextAlignmentCenter;
    [self.contentView addSubview:_stateLabel];
    
//    _myContentView = [UIView new];
//    [self.contentView addSubview:_myContentView];
    
    _titleLabel=[UILabel new];
    _titleLabel.textColor=[UIColor darkGrayColor];
    _titleLabel.font= [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel=[UILabel new];
    _timeLabel.textColor=[UIColor darkGrayColor];
    _timeLabel.font= [UIFont systemFontOfSize:13];
    _timeLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    _rightLabel=[UILabel new];
    _rightLabel.textColor=[UIColor darkGrayColor];
    _rightLabel.font= [UIFont systemFontOfSize:13];
    _rightLabel.textAlignment= NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

//子控件布局
- (void)layoutSubviews{
    self.stateLabel.frame = CGRectMake(10, 30, 40, 20);
    self.titleLabel.frame = CGRectMake(55, 15, 100, 20);
    self.timeLabel.frame = CGRectMake(55, 45, 150, 20);
    self.rightLabel.frame = CGRectMake((SCREEN_WIDTH - 110), 30, 100, 20);
    self.underlineView.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
//    [self.myContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.contentView);
//        make.left.equalTo(weakSelf.stateLabel).width.offset(5);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.myContentView);
//        make.top.equalTo(weakSelf.myContentView);
//    }];
//    
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.myContentView);
//        make.bottom.equalTo(weakSelf.myContentView);
//        make.bottom.equalTo(weakSelf.titleLabel).width.offset(10);
//    }];
//    
//    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.contentView);
//        make.right.equalTo(weakSelf.contentView).width.offset(10);
//    }];
    
}

-(void)setOpenDoorModel:(OpenDoorHistoryModel *)openDoorModel {
    _openDoorModel = openDoorModel;
    self.titleLabel.text=_openDoorModel.openDoorWz;
    self.timeLabel.text=_openDoorModel.time;
    self.rightLabel.text=_openDoorModel.disName;
    if (_openDoorModel.isSuccess) {
        self.stateLabel.text = @"成功";
        self.stateLabel.backgroundColor = RGB(114, 203, 80);
    }else {
        self.stateLabel.text = @"失败";
        self.stateLabel.backgroundColor = RGB(203, 80, 80);
    }
}


@end
