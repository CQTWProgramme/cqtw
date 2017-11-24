//
//  AFViewModel.h
//  SkyNet
//
//  Created by 冉思路 on 2017/9/13.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@interface AFViewModel : BaseViewModel


/**
 获取用户自定义分组

 @param type 1.安防 2.安检
 */
-(void)requestListWithType:(NSString *)type;

/**
 获取用户默认分组
 
 */
-(void)requestDistrictList;

/**
 获取用户默认分组下数据
 @param districtId 默认分组id
 */
-(void)requestDistrictDataWithDistrictId:(NSString *)districtId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize;
/**
 删除自定义分组

 @param customId 自定义分组id
 */
-(void)requestDeleteGroup:(NSString *)customId;

/**
 查询网点下设备状态分类数量
 
 @param branchId 网点id
 */
-(void)requestDeviceStateByBranch:(NSString *)branchId;

/**
 编辑自定义分组名字

 @param groupName 自定义分组名字
 @param customId  自定义分组id
 */
-(void)requestEditGroup:(NSString *)groupName customId:(NSString *)customId;





/**
 创建自定义分组

 @param groupName 自定义分组名字
 @param fzgn 自定义分组所属模块
 @param fid 自定义分组父节点
 */
-(void)requestAddNewGroup:(NSString *)groupName withFzgn:(NSInteger)fzgn withFid:(NSString *)fid;




/**
 根据功能(模糊)查询类型,功能查询网点,设备,通道数据(
 @param gn 模块功能
 @param query 模糊条件/无条件查询所有
 @param currPage 数据页码;默认第一页
 @param pageSize 数据条数;默认10条
 */
-(void)requestNoCustomBranchDataWithGn:(NSString *)gn
                                 query:(NSString *)query
                              currPage:(NSInteger)currPage
                              pageSize:(NSInteger)pageSize;





/**
 添加自定义分组下数据

 @param customId 分组id
 @param dxlx 分组下数据对象类型; 0=网点 1=设备 2=接口; dxlx对应ids数据结构;
 @param ids 对象数据字符组; 可多个数据,以 ’-’ 分割;如50001-50002
 */
-(void)requestAddCustomData:(NSString *)customId
                       dxlx:(NSString *)dxlx
                        ids:(NSString *)ids;


/**
 处理添加自定义数据

 @param inputArr 添加的数据
 @return 处理后的字符串数据
 */

-(NSString *)componentsInput:(NSArray *)inputArr;





/**
 网点一键布防,撤防,消警
 
 @param branchId 网点id
 @param type 操作类型;1=布防;2=撤防;3=消警

 */
-(void)alarmBranchBCFWithId:(NSString *)branchId type:(NSInteger)type;

/**
 获取自定义分组下数据
 
 @param customId 自定义分组id
 */
-(void)requestGroupData:(NSString *)customId;

/**
 渐变色
 @param frame 区域大小
 */
+(CAGradientLayer *)getDefaultLayerWithFrame:(CGRect)frame;
@end
