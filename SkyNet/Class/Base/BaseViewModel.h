//
//  BaseViewModel.h
//  XDXG
//
//  Created by 冉思路 on 2017/7/7.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface BaseViewModel : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

//获取网络的链接状态
- (void)netWorkStateWithNetConnectBlock:(NetWorkBlock) netConnectBlock
                             WithURlStr:(NSString *) strURl;

// 传入交互的Block块
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;


@end
