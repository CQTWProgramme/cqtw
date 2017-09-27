//
//  SingleChooseTableView.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "SingleChooseTable.h"
#import "TableChooseCell.h"
#define HeaderHeight 50
#define CellHeight 50
#define CellId @"CellId"
@interface SingleChooseTable()
@property(nonatomic,strong)NSDictionary * cellDic;//设置cell的identifier，防止重用
@end

@implementation SingleChooseTable

+(SingleChooseTable *)ShareTableWithFrame:(CGRect)frame{
    SingleChooseTable * table = [[SingleChooseTable alloc]initWithViewFrame:frame];
    return table;
}

-(instancetype)initWithViewFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateTable];
    }
    return self;
}

-(void)CreateTable{
    _MyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    _MyTable.dataSource = self;
    _MyTable.delegate = self;
    _MyTable.separatorStyle = UITableViewStylePlain;
    [self addSubview:_MyTable];
}

#pragma UITableViewDelegate - UITableViewDataSource
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
    cell.titleLabel.text = [_dataArr objectAtIndex:indexPath.row];
    if ([self.chooseContent isEqualToString:cell.titleLabel.text]) {
        [cell UpdateCellWithState:YES];
    }
    else{
        [cell UpdateCellWithState:NO];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentSelectIndex!=nil&&_currentSelectIndex != indexPath) {
        NSIndexPath *  beforIndexPath = [NSIndexPath indexPathForRow:_currentSelectIndex.row inSection:0];
        //如果之前decell在当前屏幕，把之前选中cell的状态取消掉
        TableChooseCell * cell = [tableView cellForRowAtIndexPath:beforIndexPath];
        [cell UpdateCellWithState:NO];
    }
    TableChooseCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    self.chooseContent = cell.titleLabel.text;
    _currentSelectIndex = indexPath;
    _block(self.chooseContent,indexPath);
}

-(void)ReloadData{
    [self.MyTable reloadData];
}

@end
