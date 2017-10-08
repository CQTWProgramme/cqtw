//
//  EquipmentModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EquipmentModel.h"

@implementation EquipmentModel
+ (void)getListDevicesDataById:(NSString *)customId success:(BaseSuccessBlock)success failure:(BaseFailureBlock)failure {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    if (customId == nil) {
        customId = @"";
    }
    NSDictionary * param =@{@"branchId":customId,@"sbgn":@(1)};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTDevicesData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *muArr = [NSMutableArray array];
            NSArray * arr = responseObject[@"data"];
            if (arr.count > 0) {
                for (NSDictionary *dic in arr) {
                    EquipmentModel *model = [EquipmentModel mj_objectWithKeyValues:dic];
                    [muArr addObject:model];
                }
            }
            success(muArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        [STTextHudTool hideSTHud];
        
    }];
}
@end
