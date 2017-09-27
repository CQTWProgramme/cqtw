//
//  ProvinceModel.h
//  MoneyTree
//
//  Created by duck on 16/4/15.
//  Copyright © 2016年 yqs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property (nonatomic,strong) NSString * code;//邮政编码
@property (nonatomic,strong) NSString *pCode;//上级邮编
@property (nonatomic,strong) NSString *name;//省名字
@property (nonatomic,strong) NSArray  *citys;//省内城市数组
@end
