//
//  BaseViewModel.m
//  XDXG
//
//  Created by 冉思路 on 2017/7/7.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

#pragma 获取网络可到达状态
- (void)netWorkStateWithNetConnectBlock:(NetWorkBlock)
netConnectBlock WithURlStr:(NSString *) strURl;
{
    BOOL netState = [AFNetAPIClient netWorkReachabilityWithURLString:strURl];
    netConnectBlock(netState);
}

#pragma 接收传过来的block
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}


@end
