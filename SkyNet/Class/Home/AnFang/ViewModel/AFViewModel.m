//
//  AFViewModel.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AFViewModel.h"
#import "AFModel.h"
#import "NetPointModel.h"
#import "NetDetailModel.h"
@implementation AFViewModel


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
                
                AFModel * model =[AFModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            
            super.returnBlock(modelArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
    
    
}


#pragma mark   删除自定义分组
-(void)requestDeleteGroup:(NSString *)customId{
    
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

#pragma mark 编辑自定义分组名字
-(void)requestEditGroup:(NSString *)groupName customId:(NSString *)customId{
    
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


#pragma mark 创建自定义分组
-(void)requestAddNewGroup:(NSString *)groupName{
    
    [STTextHudTool loadingWithTitle:@"正在添加..."];
    NSDictionary * param =@{@"fzgn":@"1",
                            @"fzmc":groupName,
                            @"fid":@"0"};
    [[AFNetAPIClient sharedJsonClient].setRequest(ADDCUSTOM).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
            [STTextHudTool hideSTHud];
            [STTextHudTool showSuccessText:@"添加成功" withSecond:HudDelay];
            self.returnBlock(responseObject);
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:responseObject[@"message"] withSecond:HudDelay];
            
        }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"添加失败" withSecond:HudDelay];
        
    }];
    
}



#pragma mark 根据功能(模糊)查询类型,功能查询网点,设备,通道数据

-(void)requestBdcDataLike:(NSString *)type
                            gn:(NSString *)gn
                            query:(NSString *)query
                            currPage:(NSInteger)currPage
                            pageSize:(NSInteger)pageSize
{
    
    
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"type":type,
                            @"gn":gn,
                            @"query":query,
                            @"currPage":[NSString stringWithFormat:@"%ld",currPage],
                            @"pageSize":[NSString stringWithFormat:@"%ld",pageSize]};
    [[AFNetAPIClient sharedJsonClient].setRequest(BDCDATALIKE).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
            [STTextHudTool hideSTHud];
            
            self.returnBlock(responseObject[@"data"]);
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"加载失败" withSecond:HudDelay];
            
        }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"加载失败" withSecond:HudDelay];
        
    }];

    
}

#pragma mark 添加自定义分组下数据
-(void)requestAddCustomData:(NSString *)customId
                       dxlx:(NSString *)dxlx
                        ids:(NSString *)ids
{
    [STTextHudTool loadingWithTitle:@"添加数据中..."];
    NSDictionary * param =@{@"customId":customId,
                            @"dxlx":dxlx,
                            @"ids":ids};
    [[AFNetAPIClient sharedJsonClient].setRequest(ADDCUSTOMDATA).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            
            [STTextHudTool hideSTHud];
            
            self.returnBlock(responseObject);
        }else{
            [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"添加数据失败" withSecond:HudDelay];
            
        }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        [STTextHudTool showErrorText:@"添加数据失败" withSecond:HudDelay];
        
    }];
    
}


#pragma mark  获取自定义分组下数据
-(void)requestGroupData:(NSString *)customId{
    
    [STTextHudTool loadingWithTitle:@"加载中..."];
    NSDictionary * param =@{@"customId": customId};
    [[AFNetAPIClient sharedJsonClient].setRequest(SELECTCUSTOMData).RequestType(Post).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            for (NSDictionary * dic in dataArr) {
                
                NetDetailModel * model =[NetDetailModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            
            super.returnBlock(modelArr);
        }
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
    
    
}


#pragma mark 处理添加自定义数据
-(NSString *)componentsInput:(NSArray *)inputArr{
    
    NSMutableArray * nameArr =[NSMutableArray new];
    for (NetPointModel * model in inputArr) {
        [nameArr addObject:model.wdbh];
    }
    
    
    if (nameArr.count==0) {
        
        return @"";
    }
    
    return [nameArr componentsJoinedByString:@"-"];
    
}


#pragma mark 渐变色
+(CAGradientLayer *)getDefaultLayerWithFrame:(CGRect)frame{
    
    
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)RGB(124, 167, 240).CGColor,
                             (id)RGB(105, 158, 247).CGColor,
                             (id)RGB(55, 124, 232).CGColor];
    
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f) ,@(0.4f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    return gradientLayer;
    
}
@end
