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
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
    }];
}

-(void)IsNeedRealNameConfirm {
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(IsNeedCertification).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            long longData = [responseObject[@"data"] longValue];
            NSString *data = [NSString stringWithFormat:@"%@",@(longData)];
            super.returnBlock(data);
        }
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
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
@end
