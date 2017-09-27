//
//  CityModel.h
//  MoneyTree
//
//  Created by duck on 16/4/15.
//  Copyright © 2016年 yqs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (nonatomic,strong) NSString * code;//邮政编码
@property (nonatomic,strong) NSString *pCode;//上级邮编
@property (nonatomic,strong) NSString *name;//城市名字
@property (nonatomic,strong) NSArray  *countys;//城市内区域数组
@end
