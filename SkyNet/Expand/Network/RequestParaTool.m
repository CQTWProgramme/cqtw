//
//  RequestParaTool.m
//  ChainModelTest
//
//  Created by 冉思路 on 2017/7/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "RequestParaTool.h"

#define APP_ID ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])
#define APP_VER_CODE         ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define APP_VER_NAME            @"1.0"
#define APP_CHANNEL_CODE        @"xdxg"
#define APP_SYSTEM_CODE         @""
#define APP_CODE               @"xdxg"

@implementation RequestParaTool


-(instancetype)init{
    
    self=[super init];
    if (self) {
        self.mobileReq =[NSMutableDictionary new];
        self.mobileReqHeader=[NSMutableDictionary new];
        self.appInfo=[NSMutableDictionary new];
        self.authInfo=[NSMutableDictionary new];
        self.mobileReqBody=[NSMutableDictionary new];
        self.servReqInfo=[NSMutableDictionary new];
        self.parameter=[NSMutableDictionary new];
        
        
        [self.mobileReq setValue:[self setupMobileReqHeader] forKey:@"mobileReqHeader"];
        [self.mobileReq setValue:[self setupMobileReqBody] forKey:@"mobileReqBody"];
    }
    
    return self;
    
}

-(NSMutableDictionary *)setupMobileReqHeader{
    
    
    [self.mobileReqHeader  setValue:[self setupAppInfo] forKey:@"appInfo"];
    [self.mobileReqHeader  setValue:[self setupAuthInfo] forKey:@"authInfo"];
    
    
    return self.mobileReqHeader;
    
}

-(NSMutableDictionary *)setupMobileReqBody{
    
    [self.mobileReqBody  setValue:[self setupServReqInfo] forKey:@"servReqInfo"];
    [self.mobileReqBody  setValue:[self setupParameter] forKey:@"parameter"];
    
    return self.mobileReqBody;
    
}

-(NSMutableDictionary *)setupAppInfo{
    
    [self.appInfo setValue:APP_ID forKey:@"appid"];
    [self.appInfo setValue:APP_CODE forKey:@"appCode"];
    [self.appInfo setValue:APP_VER_CODE forKey:@"verCode"];
    [self.appInfo setValue:@"ios" forKey:@"platform"];
    [self.appInfo setValue:APP_VER_NAME forKey:@"verName"];
    [self.appInfo setValue:@"" forKey:@"userKey"];
    [self.appInfo setValue:APP_CHANNEL_CODE forKey:@"chnlCode"];
    
    
    return self.appInfo;
    
}

-(NSMutableDictionary *)setupAuthInfo{
    
    [self.authInfo setValue:[self getTimeStamp] forKey:@"timeStamp"];
    [self.authInfo setValue:@"" forKey:@"authKey"];
    [self.authInfo setValue:@"" forKey:@"token"];
    
    return self.authInfo;
    
}

-(NSMutableDictionary *)setupServReqInfo{
    
    [self.servReqInfo setValue:APP_SYSTEM_CODE forKey:@"system"];
    [self.servReqInfo setValue:@"" forKey:@"method"];
    
    return self.servReqInfo;
    
}

-(NSMutableDictionary *)setupParameter{
   
    return self.parameter;
    
}

#pragma mark  appInfo
- (requestBlock)appid{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"appid"];
        
        return self;
    };
}

- (requestBlock)appCode{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"appCode"];
        
        return self;
    };
}

- (requestBlock)verCode{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"verCode"];
        
        return self;
    };
}

- (requestBlock)platform{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"platform"];
        
        return self;
    };
}

- (requestBlock)verName{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"verName"];
        
        return self;
    };
}

- (requestBlock)userKey{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"userKey"];
        
        return self;
    };
}

- (requestBlock)chnlCode{
    
    return ^(NSString * inputValue){
        
        
        [self.appInfo setObject:inputValue forKey:@"chnlCode"];
        
        return self;
    };
}




#pragma mark  authInfo
- (requestBlock)authKey{
    
    return ^(NSString * inputValue){
        
        
        [self.authInfo setObject:inputValue forKey:@"authKey"];
        
        return self;
    };
}

- (requestBlock)token{
    
    return ^(NSString * inputValue){
        
        
        [self.authInfo setObject:inputValue forKey:@"token"];
        
        return self;
    };
}


- (requestBlock)timeStamp{
    
    return ^(NSString * inputValue){
        
        
        [self.authInfo setObject:inputValue forKey:@"timeStamp"];
        
        return self;
    };
}


#pragma mark  servReqInfo
- (requestBlock)system{
    
    return ^(NSString * inputValue){
        
        
        [self.servReqInfo setObject:inputValue forKey:@"system"];
        
        return self;
    };
}

- (requestBlock)method{
    
    return ^(NSString * inputValue){
        
        
        [self.servReqInfo setObject:inputValue forKey:@"method"];
        
        return self;
    };
}


- (requestBlock)paraDic{
    
    return ^(NSDictionary * dic){
        
        [self.parameter setDictionary:dic];
       
        
        return self;
    };
}






-(NSString *)getTimeStamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

@end
