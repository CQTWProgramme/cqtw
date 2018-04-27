//
//  MyHouseListCell.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MyHouseListCell.h"
#import "MyHouseListModel.h"

@interface MyHouseListCell ()
@property (nonatomic, strong) UIView *underlineView; //下划线
@property(nonatomic,strong) UILabel * areaLabel;
@property(nonatomic,strong) UILabel * roomLabel;
@property(nonatomic,strong) UILabel * roleLabel;
@property(nonatomic,strong) UILabel * numLabel;
@end

@implementation MyHouseListCell

+ (instancetype)myHouseListCellWithTableView: (UITableView *)tableView {
    static NSString *reuseIdentity = @"myHouseListCellWithTableViewCellID";
    
    MyHouseListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        cell = [[MyHouseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
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
    
    _areaLabel=[UILabel new];
    _areaLabel.textColor=[UIColor blueColor];
    _areaLabel.font= [UIFont systemFontOfSize:15];
    _areaLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_areaLabel];
    
    _roomLabel=[UILabel new];
    _roomLabel.textColor=[UIColor lightGrayColor];
    _roomLabel.font= [UIFont systemFontOfSize:13];
    _roomLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_roomLabel];
    
    _roleLabel=[UILabel new];
    _roleLabel.textColor=[UIColor lightGrayColor];
    _roleLabel.font= [UIFont systemFontOfSize:13];
    _roleLabel.textAlignment= NSTextAlignmentLeft;
    [self.contentView addSubview:_roleLabel];
    
    _numLabel=[UILabel new];
    _numLabel.textColor=[UIColor whiteColor];
    _areaLabel.layer.cornerRadius = 3;
    _areaLabel.layer.masksToBounds = YES;
    _numLabel.backgroundColor = RGB(114, 203, 80);
    _numLabel.font= [UIFont systemFontOfSize:13];
    _numLabel.textAlignment= NSTextAlignmentCenter;
    [self.contentView addSubview:_numLabel];
    
    _underlineView = [UIView new];
    _underlineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_underlineView]; //将下划线添加到容器containerView上
}

//子控件布局
- (void)layoutSubviews{
    self.areaLabel.frame = CGRectMake(5, 5, 200, 15);
    self.numLabel.frame = CGRectMake(5, 47, 6, 6);
    self.roomLabel.frame = CGRectMake(25, 25, 200, 20);
    self.roleLabel.frame = CGRectMake(25, 50, 200, 20);
    self.underlineView.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
}

-(void)setMyHouseListModel:(MyHouseListModel *)myHouseListModel {
    _myHouseListModel = myHouseListModel;
    self.areaLabel.text=_myHouseListModel.disName;
    self.roomLabel.text=_myHouseListModel.houseName;
//    if (_openDoorModel.isSuccess) {
//        self.stateLabel.text = @"成功";
//        self.stateLabel.backgroundColor = RGB(114, 203, 80);
//    }else {
//        self.stateLabel.text = @"失败";
//        self.stateLabel.backgroundColor = RGB(203, 80, 80);
//    }
}

-(void)setIndex:(NSInteger)index {
    _index = index;
    self.numLabel.text = [NSString stringWithFormat:@"%@",@(index)];
}

@end
