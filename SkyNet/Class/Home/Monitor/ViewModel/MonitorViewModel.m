//
//  MonitorViewModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorViewModel.h"
#import "MonitorDistrictItemModel.h"
#import "MonitorItemModel.h"
#import "MonitorSecondPointModel.h"
#import "MonitorSecondGroupModel.h"
@implementation MonitorViewModel
#pragma mark  获取用户默认分组
-(void)requestDistrictList {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTDISTRICT).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            for (NSDictionary * dic in dataArr) {
                MonitorDistrictItemModel * model =[MonitorDistrictItemModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            
            super.returnBlock(modelArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
    }];
}

#pragma mark  获取用户自定义分组
-(void)requestListWithType:(NSString *)type{
    
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"fzgn": type};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTCUSTOM).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            for (NSDictionary * dic in dataArr) {
                MonitorItemModel * model =[MonitorItemModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            super.returnBlock(modelArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
    }];
}

#pragma mark  删除用户自定义分组
-(void)requestDeleteGroup:(NSString *)customId {
    [STTextHudTool loadingWithTitle:@"删除中..."];
    NSDictionary * param =@{@"customId": customId};
    [[AFNetAPIClient sharedJsonClient].setRequest(DELETECUSTOM).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
            [STTextHudTool hideSTHud];
            [STTextHudTool showSuccessText:@"删除成功" withSecond:HudDelay];
            self.returnBlock(code);
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"删除失败" withSecond:HudDelay];
            
        }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"删除失败" withSecond:HudDelay];
        
    }];
}

#pragma mark  编辑用户自定义分组
- (void)requestEditGroup:(NSString *)groupName customId:(NSString *)customId{
    [STTextHudTool loadingWithTitle:@"编辑中..."];
    NSDictionary * param =@{@"customId":customId,
                            @"fzmc":groupName};
    [[AFNetAPIClient sharedJsonClient].setRequest(UPDATECUSTOM).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
            [STTextHudTool hideSTHud];
            [STTextHudTool showSuccessText:@"编辑成功" withSecond:HudDelay];
            self.returnBlock(code);
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"编辑失败" withSecond:HudDelay];
            
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"编辑失败" withSecond:HudDelay];
        
    }];
}

#pragma mark  获取用户自定义分组
-(void)requestDistrictDataWithDistrictId:(NSString *)districtId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"districtId": districtId,@"sbgn":@(4),@"currPage":@(currentPage),@"pageSize":@(pageSize)};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTDISTRICTDATA).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            if (dataArr.count > 0) {
                for (NSDictionary * dic in dataArr) {
                    MonitorSecondPointModel * model =[MonitorSecondPointModel mj_objectWithKeyValues:dic];
                    [modelArr addObject:model];
                }
            }
            
            super.returnBlock(modelArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
}

#pragma mark  获取自定义分组下数据
-(void)requestGroupData:(NSString *)customId{
    
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"customId": customId,@"fzgn":@(4)};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTCUSTOMData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * sumArr =[NSMutableArray new];
            NSMutableArray * customArr =[NSMutableArray new];
            NSMutableArray * sysArr =[NSMutableArray new];
            
            NSDictionary * dataDic = responseObject[@"data"];
            NSArray *csArray = dataDic[@"customDataList"];
            NSArray *syArray = dataDic[@"sysCustomList"];
            if (csArray.count > 0) {
                for (NSDictionary * dic in csArray) {
                    MonitorSecondPointModel * model =[MonitorSecondPointModel mj_objectWithKeyValues:dic];
                    [customArr addObject:model];
                }
            }
            if (syArray.count > 0) {
                for (NSDictionary * dic in syArray) {
                    MonitorSecondGroupModel * model =[MonitorSecondGroupModel mj_objectWithKeyValues:dic];
                    [sysArr addObject:model];
                }
            }
            [sumArr addObject:customArr];
            [sumArr addObject:sysArr];
            super.returnBlock(sumArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
    
    
}

-(void)requestBranchData:(NSString *)branchId currPage:(NSInteger)currPage pageSize:(NSInteger)pageSize{
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"branchId": branchId,@"iklx":@"4",@"currPage":@(currPage),@"pageSize":@(pageSize)};
    [[AFNetAPIClient sharedJsonClient].setRequest(SelectChannelPageByBranch).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        super.returnBlock(responseObject);
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
    }];
}
@end
