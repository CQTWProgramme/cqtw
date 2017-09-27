//
//  HomeViewModel.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeViewModel.h"
#import "ShortcutModel.h"
#import "AdvModel.h"
@implementation HomeViewModel


#define mark 获取广告位轮播图
-(void)requestAdverList{
    
    [STTextHudTool loadingWithTitle:@"加载中..."];
    [[AFNetAPIClient sharedJsonClient].setRequest(ADVER_LIST).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
         [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            for (NSDictionary * dic in dataArr) {
              
                AdvModel * model =[AdvModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            
          super.returnBlock(modelArr);
        }
            
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
  
    
    
}

#pragma mark 获取快捷方式列表
-(void)requestShortcutList{
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest(SHORTCUT_LIST).RequestType(Post).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        [STTextHudTool hideSTHud];
        NSString * code=responseObject[@"code"];
        if (code.integerValue==1) {
            NSMutableArray * modelArr =[NSMutableArray new];
            NSArray * dataArr =responseObject[@"data"];
            for (NSDictionary * dic in dataArr) {
                
                ShortcutModel * model =[ShortcutModel mj_objectWithKeyValues:dic];
                [modelArr addObject:model];
            }
            
            super.returnBlock(modelArr);
        }

        
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [STTextHudTool hideSTHud];
        
        
    }];
    
    
    
}


@end
