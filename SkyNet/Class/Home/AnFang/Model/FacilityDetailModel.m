//
//  FacilityDetailModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "FacilityDetailModel.h"

@implementation FacilityDetailModel

+ (void)getDetailDataById:(NSString *)deviceId success:(BaseSuccessBlock)success failure:(BaseFailureBlock)failure{
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"deviceId": deviceId};
    [[AFNetAPIClient sharedJsonClient].setRequest(FacilityDetailData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSDictionary * dataDic = responseObject[@"data"];
            FacilityDetailModel *model = [FacilityDetailModel mj_objectWithKeyValues:dataDic];
            success(model);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        [STTextHudTool hideSTHud];
        
    }];
}
@end
