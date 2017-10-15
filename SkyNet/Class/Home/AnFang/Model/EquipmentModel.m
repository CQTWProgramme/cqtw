//
//  EquipmentModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/29.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EquipmentModel.h"

@implementation EquipmentModel
+ (void)getListDevicesDataById:(NSString *)branchId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize success:(BaseSuccessBlock) success failure:(BaseFailureBlock) failure {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"branchId":branchId,@"sbgn":@(1),@"currPage":@(currentPage),@"pageSize":@(pageSize),@"state":@"602"};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTDevicePageByBranch).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *muArr = [NSMutableArray array];
            NSDictionary * dic = responseObject[@"data"];
            NSArray *arr = dic[@"rows"];
            if (arr.count > 0) {
                for (NSDictionary *dic1 in arr) {
                    EquipmentModel *model = [EquipmentModel mj_objectWithKeyValues:dic1];
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
