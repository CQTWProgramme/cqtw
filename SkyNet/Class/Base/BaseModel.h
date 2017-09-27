//
//  BaseModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//  基本模型，提供成功和失败返回block

#import <Foundation/Foundation.h>
typedef void (^BaseSuccessBlock) (id returnValue);
typedef void (^BaseFailureBlock) (id errorCode);
@interface BaseModel : NSObject

@end
