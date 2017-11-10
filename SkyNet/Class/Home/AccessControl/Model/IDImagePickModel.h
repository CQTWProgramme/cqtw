//
//  IDImagePickModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDImagePickModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *pickImg;
@property (nonatomic, assign) BOOL isEmpty;

@end
