//
//  NetDetailDistrictModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/14.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetDetailDistrictModel : NSObject
@property (nonatomic, copy) NSString *customId;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *fzmc;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) long fzgn;

@end