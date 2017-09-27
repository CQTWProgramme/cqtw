//
//  UIImage+ImageSize.h
//  CloudMark
//
//  Created by 冉思路 on 2017/8/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageSize)
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;
//图片压缩到指定大小
-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

-(UIImage*)scaleToSize:(CGSize)size;
@end
