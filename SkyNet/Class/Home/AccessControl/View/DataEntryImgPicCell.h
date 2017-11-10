//
//  DataEntryImgPicCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/23.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataEntryImgPicCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isLast;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, copy) void (^deleteImg)(); //删除对应图片
@end
