//
//  DataEntryIdCardCell.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/23.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDImagePickModel;
@interface DataEntryIdCardCell : UICollectionViewCell
@property (nonatomic, strong) IDImagePickModel *model;
@property (nonatomic, copy) void (^deleteImg)(); //删除对应图片
@end
