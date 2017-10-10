//
//  LatticePointDetailModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LatticePointDetailModel.h"

@implementation LatticePointDetailModel
+ (void)getLatticePointDetailDataById:(NSString *)customId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"branchId": customId};
    [[AFNetAPIClient sharedJsonClient].setRequest(LatticeDetailData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSDictionary * dic = responseObject[@"data"];
            LatticePointDetailModel *model = [LatticePointDetailModel mj_objectWithKeyValues:dic];
            success(model);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        [STTextHudTool hideSTHud];
        
    }];
}
@end
