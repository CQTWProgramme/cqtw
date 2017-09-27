//
//  RequestParaTool.h
//  ChainModelTest
//
//  Created by 冉思路 on 2017/7/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestParaTool;

typedef RequestParaTool *(^requestBlock)(id para);
@interface RequestParaTool : NSObject
//主体
@property(nonatomic,strong)NSMutableDictionary * mobileReq;

//header
@property(nonatomic,strong)NSMutableDictionary * mobileReqHeader;
@property(nonatomic,strong)NSMutableDictionary * appInfo;
@property(nonatomic,strong)NSMutableDictionary * authInfo;

//body
@property(nonatomic,strong)NSMutableDictionary * mobileReqBody;
@property(nonatomic,strong)NSMutableDictionary * servReqInfo;
@property(nonatomic,strong)NSMutableDictionary * parameter;



//***************************分割线***************************


//appInfo
- (requestBlock)appid;
- (requestBlock)appCode;
- (requestBlock)verCode;
- (requestBlock)platform;
- (requestBlock)verName;
- (requestBlock)userKey;
- (requestBlock)chnlCode;

//authInfo
- (requestBlock)timeStamp;
- (requestBlock)authKey;
- (requestBlock)token;



//servReqInfo
- (requestBlock)system;
- (requestBlock)method;

//parameter
- (requestBlock)paraDic;

@end
