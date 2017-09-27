//
//  MyView.h
//  SkyNet
//
//  Created by 冉思路 on 2017/8/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyViewDelegate <NSObject>

//上拉刷新
-(void)selectRowWithIndex:(NSInteger)index;



@end

@interface MyView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView * headView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,weak)id<MyViewDelegate>delegate;
@end
