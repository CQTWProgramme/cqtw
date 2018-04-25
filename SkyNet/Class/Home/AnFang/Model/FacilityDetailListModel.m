//
//  FacilityDetailListModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "FacilityDetailListModel.h"

@implementation FacilityDetailListModel
+ (void)getFacilityDetailListDataById:(NSString *)deviceId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure {
    NSDictionary * param =@{@"deviceId": deviceId,@"currPage":@(currentPage),@"pageSize":@(pageSize),@"jklx":@"1"};
    [[AFNetAPIClient sharedJsonClient].setRequest(FacilityDetailBranchListData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } progress:^(NSProgress *progress) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

+ (void)getChannelDetailWithChannelId:(NSString *)channelId success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure{
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"channelId": channelId};
    [[AFNetAPIClient sharedJsonClient].setRequest(FacilityDetailChannelData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        [STTextHudTool hideSTHud];
        
    }];
}
@end
