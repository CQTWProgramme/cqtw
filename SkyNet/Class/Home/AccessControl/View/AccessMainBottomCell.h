//
//  AccessMainBottomCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACVillageModel;
@interface AccessMainBottomCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isLastCell;
@property (nonatomic, strong) ACVillageModel *model;
@end
