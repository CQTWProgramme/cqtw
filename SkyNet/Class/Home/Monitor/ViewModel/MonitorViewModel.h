//
//  MonitorViewModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/15.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "BaseViewModel.h"

@interface MonitorViewModel : BaseViewModel
/**
 获取用户自默认分组
 */
-(void)requestDistrictList;
/**
 获取用户自定义分组
 
 @param type 4.监控
 */
-(void)requestListWithType:(NSString *)type;
/**
 删除用户自定义分组
 
 @param customId 自定义分组id
 */
-(void)requestDeleteGroup:(NSString *)customId;
/**
 编辑自定义分组名字
 
 @param groupName 自定义分组名字
 @param customId  自定义分组id
 */
-(void)requestEditGroup:(NSString *)groupName customId:(NSString *)customId;
/**
 获取用户默认分组下数据
 @param districtId 默认分组id
 */
-(void)requestDistrictDataWithDistrictId:(NSString *)districtId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize;
/**
 获取自定义分组下数据
 
 @param customId 自定义分组id
 */
-(void)requestGroupData:(NSString *)customId;
/**
 根据网点查询用户所有设备通道（分页）
 
 @param branchId 网点id
 */
-(void)requestBranchData:(NSString *)branchId currPage:(NSInteger)currPage pageSize:(NSInteger)pageSize;
@end
