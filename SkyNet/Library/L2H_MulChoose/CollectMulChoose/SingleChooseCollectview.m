//
//  SingleChooseCollectview.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "SingleChooseCollectview.h"
#import "CollectviewChooseCell.h"
#define ItemHeight 70
#define HeaderHeight 50
#define CellId @"CellId"
static NSString *HeaderId = @"HeaderId";

@interface SingleChooseCollectview()
@property(nonatomic,strong)NSDictionary * cellDic;//设置cell的identifier，防止重用
@end


@implementation SingleChooseCollectview


+(instancetype)ShareCollectviewWithFrame:(CGRect)frame{
    SingleChooseCollectview * collect = [[SingleChooseCollectview alloc] initWithCollectFrame:frame];
    return  collect;
}

-(instancetype)initWithCollectFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateCollectView];
    }
    return self;
}


-(void)CreateCollectView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;//列距
    flowLayout.minimumLineSpacing = 10;
    _MyCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
    _MyCollectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [_MyCollectView registerClass:[CollectviewChooseCell class] forCellWithReuseIdentifier:CellId];
    _MyCollectView.showsVerticalScrollIndicator = NO;
    _MyCollectView.scrollEnabled = YES;
    _MyCollectView.delegate = self;
    _MyCollectView.dataSource = self;
    [self addSubview:_MyCollectView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3,ItemHeight);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", CellId, [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        [_MyCollectView registerClass:[CollectviewChooseCell class]  forCellWithReuseIdentifier:identifier];
    }
    CollectviewChooseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    cell.titleLab.text = [_dataArr objectAtIndex:indexPath.row];
    if ([self.chooseContent isEqualToString:cell.titleLab.text]) {
        [cell UpdateCellWithState:YES];
    }
    else{
        [cell UpdateCellWithState:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentSelectIndex!=nil&&_currentSelectIndex != indexPath) {
        CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:_currentSelectIndex];
        [cell UpdateCellWithState:NO];
    }
    CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    _currentSelectIndex = indexPath;
    self.chooseContent = cell.titleLab.text;
    _block(self.chooseContent,indexPath);
}

-(void)ReloadData{
    [self.MyCollectView reloadData];
}

@end
