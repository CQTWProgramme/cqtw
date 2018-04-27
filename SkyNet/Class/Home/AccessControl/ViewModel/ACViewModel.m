//
//  ACViewModel.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ACViewModel.h"
#import "ACVillageModel.h"
#import "CertificateInfoModel.h"
#import "SelectDistrictFirstModel.h"
#import "SelectDistrictSecondModel.h"
#import "MemberControlModel.h"
#import "VillageApplyModel.h"
#import "RecordVisitorModel.h"
#import "MemberApplyModel.h"
#import "AccessDetailModel.h"

@implementation ACViewModel
-(void)requestDataWithLatitude:(NSString *)latitude Longitude:(NSString *)longitude {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"longitude": longitude,@"latitude":latitude};
    [[AFNetAPIClient sharedJsonClient].setRequest(GetUserAndBranchData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray * dataArr =responseObject[@"data"];
                if (dataArr.count > 0) {
                    for (NSDictionary * dic in dataArr) {
                        ACVillageModel * model =[ACVillageModel mj_objectWithKeyValues:dic];
                        [modelArr addObject:model];
                    }
                }
            }
            super.returnBlock(modelArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
    }];
}

-(void)IsNeedRealNameConfirm {
    [[AFNetAPIClient sharedJsonClient].setRequest(IsNeedCertification).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSString * code=responseObject[@"code"];
        NSString *data = @"";
        if (code.integerValue==1) {
            long longData = [responseObject[@"data"] longValue];
            data = [NSString stringWithFormat:@"%@",@(longData)];
        }
        NSDictionary *dic = @{@"request":code,@"data":data};
        super.returnBlock(dic);
    } progress:^(NSProgress *progress) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)uploadImgWithFileImg:(NSData *)fileImg type:(NSInteger )type idCardNumber:(NSString *)idCardNumber {
    [STTextHudTool loadingWithTitle:@"图片上传中..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSDictionary * param =@{@"type":@(type),@"IdCardNumber":idCardNumber};
    [manager POST:UploadImage parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            [formData appendPartWithFileData:fileImg name:@"fileImg" fileName:fileName mimeType:@"image/jpeg"]; //
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showErrorText:@"上传成功"];
            NSString *pathStr = responseObject[@"data"];
            super.returnBlock(pathStr);
        }else {
            [STTextHudTool showErrorText:@"上传失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [STTextHudTool showErrorText:@"上传失败"];
    }];
}

-(void)getMessageWithFileImg:(NSData *)fileImg {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager POST:GetIdCardInfo parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        [formData appendPartWithFileData:fileImg name:@"fileImg" fileName:fileName mimeType:@"image/jpeg"]; //
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSDictionary *dic = responseObject[@"data"];
            CertificateInfoModel *model = [CertificateInfoModel mj_objectWithKeyValues:dic];
            super.returnBlock(model);
        }else {
            [STTextHudTool showErrorText:@"获取信息失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [STTextHudTool showErrorText:@"获取信息失败"];
    }];
}

-(void)certificationConfirmWithName:(NSString *)name sex:(NSString *)sex peoples:(NSString *)peoples birth:(NSString *)birth address:(NSString *)address idCardNumber:(NSString *)idCardNumber cardType:(NSString *)cardType idCardPage:(NSString *)idCardPage idCardPage1:(NSString *)idCardPage1 lifePhoto:(NSString *)lifePhoto facePhotos:(NSString *)facePhotos {
    [STTextHudTool loadingWithTitle:@"提交中..."];
    NSDictionary * param =@{@"name": name,@"sex":sex,@"peoples": peoples,@"birth":birth,@"address": address,@"idCardNumber":idCardNumber,@"cardType": cardType,@"idCardPage":idCardPage,@"idCardPage1": idCardPage1,@"lifePhoto":lifePhoto,@"facePhotos":facePhotos};
    [[AFNetAPIClient sharedJsonClient].setRequest(SaveUserInfo).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        super.returnBlock(code);
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"信息提交失败"];
        
    }];
}

-(void)selectBranchListDataWithDisName:(NSString *)disName {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"disName": disName};
    [[AFNetAPIClient sharedJsonClient].setRequest(selectBranchList).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            NSArray *data = responseObject[@"data"];
            if (data.count > 0) {
                for (NSDictionary *dic in data) {
                    SelectDistrictFirstModel *model = [SelectDistrictFirstModel mj_objectWithKeyValues:dic];
                    [mutableArr addObject:model];
                }
            }
            
            super.returnBlock(mutableArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"信息提交失败"];
        
    }];
}

-(void)selectChildListDataWithParentId:(NSString *)parentId {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"parentId": parentId};
    [[AFNetAPIClient sharedJsonClient].setRequest(selectChildList).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"][@"entranceAreasChildList"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"][@"entranceAreasChildList"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        SelectDistrictSecondModel *model = [SelectDistrictSecondModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)acOpenDoorWithDoorId:(NSString *)doorId {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"doorId": doorId};
    [[AFNetAPIClient sharedJsonClient].setRequest(openDoor).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        NSDictionary *dic = @{@"code":code,@"message":message};
        super.returnBlock(dic);
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)getApplyUserInfoDataWithUserHouseId:(NSInteger)userHouseId {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"userHouseId": @(userHouseId)};
    [[AFNetAPIClient sharedJsonClient].setRequest(getApplyUserInfo).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            //            NSMutableArray *mutableArr = [NSMutableArray array];
            //            if (responseObject[@"data"][@"entranceAreasChildList"] != [NSNull null]) {
            //                NSArray *data = responseObject[@"data"][@"entranceAreasChildList"];
            //                if (data.count > 0) {
            //                    for (NSDictionary *dic in data) {
            //                        SelectDistrictSecondModel *model = [SelectDistrictSecondModel mj_objectWithKeyValues:dic];
            //                        [mutableArr addObject:model];
            //                    }
            //                }
            //            }
            //            super.returnBlock(mutableArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)getBranchAreasInfoData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(getBranchAreasInfo).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        AccessDetailModel *model = [AccessDetailModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)getAuditApprovalOrRefusedToDataWithUserHouseId:(NSString *)userHouseId type:(NSInteger)type reason:(NSString *)reason {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"userHouseId": userHouseId,@"type": @(type),@"reason": reason};
    [[AFNetAPIClient sharedJsonClient].setRequest(auditApprovalOrRefusedTo).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            //            NSMutableArray *mutableArr = [NSMutableArray array];
            //            if (responseObject[@"data"][@"entranceAreasChildList"] != [NSNull null]) {
            //                NSArray *data = responseObject[@"data"][@"entranceAreasChildList"];
            //                if (data.count > 0) {
            //                    for (NSDictionary *dic in data) {
            //                        SelectDistrictSecondModel *model = [SelectDistrictSecondModel mj_objectWithKeyValues:dic];
            //                        [mutableArr addObject:model];
            //                    }
            //                }
            //            }
            //            super.returnBlock(mutableArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)acGetMemberManagementData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(getMemberManagementData).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        MemberControlModel *model = [MemberControlModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:[NSString stringWithFormat:@"错误代码:%@",@(error.code)]];
        
    }];
}

-(void)acGetApplyAuditData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(getApplyAuditData).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        MemberApplyModel *model = [MemberApplyModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }];
}

-(void)acGetVisitorsRecord {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(getVisitorsRecord).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        RecordVisitorModel *model = [RecordVisitorModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"获取申请人数据失败"];
        
    }];
}

-(void)acCreateVisitorsWithAreasId:(NSString *)areasId name:(NSString *)name phone:(NSString *)phone startTime:(NSString *)startTime endTime:(NSString *)endTime bz:(NSString *)bz facePicture:(NSData *)facePicture {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"areasId": areasId,@"name": name,@"phone": phone,@"startTime": startTime,@"endTime": endTime,@"bz": bz};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager POST:createVisitors parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (facePicture != nil) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            [formData appendPartWithFileData:facePicture name:@"facePicture" fileName:fileName mimeType:@"image/jpeg"]; //
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showErrorText:@"生成成功"];
            NSDictionary *dic = responseObject[@"data"];
            super.returnBlock(dic);
        }else {
            [STTextHudTool showErrorText:@"生成失败"];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [STTextHudTool showErrorText:@"生成失败"];
    }];
}

-(void)getOpenDoorHistoryData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(openDoorHistory).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [STTextHudTool hideSTHud];
        super.returnBlock(responseObject);
    } progress:^(NSProgress *progress) {
        [STTextHudTool hideSTHud];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [STTextHudTool hideSTHud];
    }]; 
}

-(void)getMyHouseListData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(myHouseList).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [STTextHudTool hideSTHud];
        super.returnBlock(responseObject);
    } progress:^(NSProgress *progress) {
        [STTextHudTool hideSTHud];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [STTextHudTool hideSTHud];
    }]; 
}

-(void)selectAppUserHouseData {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(selectAppUserHouse).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray *mutableArr = [NSMutableArray array];
            if (responseObject[@"data"] != [NSNull null]) {
                NSArray *data = responseObject[@"data"];
                if (data.count > 0) {
                    for (NSDictionary *dic in data) {
                        VillageApplyModel *model = [VillageApplyModel mj_objectWithKeyValues:dic];
                        [mutableArr addObject:model];
                    }
                }
            }
            super.returnBlock(mutableArr);
        }else {
            [STTextHudTool showErrorText:responseObject[@"message"]];
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"获取住宅申请数据失败"];
        
    }]; 
}

-(void)acSaveUserHouseWithAreasId:(NSString *)areasId type:(NSInteger)type ly:(NSInteger)ly bz:(NSString *)bz {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"areasId": areasId,@"type": @(type),@"ly": @(ly),@"bz": bz};
    [[AFNetAPIClient sharedJsonClient].setRequest(saveUserHouse).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        super.returnBlock(code);
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool showErrorText:@"开门失败"];
        
    }]; 
}
@end
