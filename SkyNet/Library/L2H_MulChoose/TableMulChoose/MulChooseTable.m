//
//  ChooseTableView.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "MulChooseTable.h"
#import "TableChooseCell.h"
#import "NetPointModel.h"
#define HeaderHeight 0
#define CellHeight 70

@interface MulChooseTable()
@property(nonatomic,assign)BOOL ifhHaveHeader;
@end

@implementation MulChooseTable{
    UIView *headerView;
}

+(MulChooseTable *)ShareTableWithFrame:(CGRect)frame HeaderTitle:(NSString *)title{
   MulChooseTable * shareInstance = [[MulChooseTable alloc] initWithFrame:frame HaveHeader:YES HeaderTitle:title];
    return  shareInstance;
}

+(instancetype)ShareTableWithFrame:(CGRect)frame{
    static MulChooseTable *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MulChooseTable alloc] initWithFrame:frame HaveHeader:NO HeaderTitle:nil];
    });
    return  shareInstance;
}

-(instancetype)initWithFrame:(CGRect)frame HaveHeader:(BOOL)ifhHave HeaderTitle:(NSString *)title{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateTable];
        _ifhHaveHeader = ifhHave;
    }
    return self;
}

/**
 创建TableView
 */
-(void)CreateTable{
    _choosedArr = [[NSMutableArray alloc]initWithCapacity:0];
    _MyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    _MyTable.dataSource = self;
    _MyTable.delegate = self;
    _MyTable.separatorStyle = UITableViewStylePlain;
    [self addSubview:_MyTable];
}

/**
 创建Header
 */
-(UIView *)CreateHeaderView_HeaderTitle:(NSString *)title{
    if (!headerView) {
        headerView = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeaderHeight)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel * HeaderTitleLab = [[UILabel alloc]init];
        HeaderTitleLab.text = title;
        [headerView addSubview:HeaderTitleLab];
        [HeaderTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(15);
            make.top.equalTo(headerView.mas_top).offset(0);
            make.height.mas_equalTo(headerView.mas_height);
        }];
        UIButton *chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseIcon.tag = 10;
        [chooseIcon setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
        [chooseIcon setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
        chooseIcon.userInteractionEnabled = NO;
        [headerView addSubview:chooseIcon];
        [chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(HeaderTitleLab.mas_right).offset(10);
            make.right.equalTo(headerView.mas_right).offset(-15);
            make.top.equalTo(headerView.mas_top);
            make.height.mas_equalTo(headerView.mas_height);
            make.width.mas_equalTo(50);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChooseAllClick:)];
        [headerView addGestureRecognizer:tap];
    }
   
    return headerView;
}




#pragma UITableViewDelegate - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_ifhHaveHeader) {
        UIView * view = [self CreateHeaderView_HeaderTitle:@"全选"];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_ifhHaveHeader) {
        return HeaderHeight;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"cellId%ld",(long)indexPath.row];
    TableChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NetPointModel * model=_dataArr[indexPath.row];
    cell.titleLabel.text = model.wdmc;
    if (_ifAllSelecteSwitch) {
        [cell UpdateCellWithState:_ifAllSelected];
        if (indexPath.row == _dataArr.count-1) {
            _ifAllSelecteSwitch  = NO;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableChooseCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NetPointModel * model=_dataArr[indexPath.row];
    [cell UpdateCellWithState:!cell.isSelected];
    if (cell.isSelected) {
        [_choosedArr addObject:model];
    }
    else{
        [_choosedArr removeObject:model];
    }
    
    if (_choosedArr.count<_dataArr.count) {
        _ifAllSelected = NO;
        UIButton * chooseIcon = (UIButton *)[headerView viewWithTag:10];
        chooseIcon.selected = _ifAllSelected;
    }
    // _block(_choosedArr);
}


-(void)getSelectArr:(ChooseBlock)block{
    
    block(_choosedArr);
    
}

/**
 全选操作
 */
-(void)ChooseAllClick:(UITapGestureRecognizer *)tapGes{
    _ifAllSelecteSwitch = YES;
    UIButton * chooseIcon = (UIButton *)[headerView viewWithTag:10];
    [chooseIcon setSelected:!_ifAllSelected];
    _ifAllSelected = !_ifAllSelected;
    if (_ifAllSelected) {
        [_choosedArr removeAllObjects];
        [_choosedArr addObjectsFromArray:_dataArr];
    }
    else{
        [_choosedArr removeAllObjects];
    }
    [_MyTable reloadData];
    //_block(@"All",_choosedArr);
    
}


-(void)ReloadData{
    [self.MyTable reloadData];
}

@end
