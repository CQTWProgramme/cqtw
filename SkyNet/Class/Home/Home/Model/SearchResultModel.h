//
//  SearchResultModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/24.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject
@property(nonatomic,strong)NSString * branchId;
@property(nonatomic,strong)NSString * wdmc;
@property(nonatomic,strong)NSString * districtId;
@property(nonatomic,strong)NSString * wdbh;
@property(nonatomic,strong)NSString * wdjd;
@property(nonatomic,strong)NSString * wdwd;
@property(nonatomic,strong)NSString * wdwz;
@property(nonatomic,assign)long wdlx;
@property(nonatomic,strong)NSString * azry;
@property(nonatomic,strong)NSString * alarmoperId;
@property(nonatomic,strong)NSString * alarmchargeId;
@property(nonatomic,strong)NSString * bz;
@property(nonatomic,strong)NSString * xgsj;
@property (nonatomic, copy) NSString *ly;
@property (nonatomic, copy) NSString *streetId;
@end
