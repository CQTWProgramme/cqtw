//
//  EvevtListModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EvevtListModel.h"

@implementation EvevtListModel
+ (void)getEventListDataById:(NSString *)branchId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"branchId": branchId,@"currPage":@(currentPage),@"pageSize":@(pageSize)};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTBranchLatelyAlarmData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSArray *dataArray = responseObject[@"data"][@"rows"];
            NSMutableArray *temp = [NSMutableArray array];
            if (dataArray.count > 0) {
                for (NSDictionary *dic in dataArray) {
                    EvevtListModel *model = [EvevtListModel mj_objectWithKeyValues:dic];
                    [temp addObject:model];
                }
                success(temp);
            }else {
                success([NSMutableArray array]);
            }
        }else {
            [STTextHudTool showErrorText:@"操作失败"];
        }
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        [STTextHudTool hideSTHud];
        
    }];
}
@end
