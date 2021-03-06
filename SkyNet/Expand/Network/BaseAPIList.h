//
//  BaseAPIList.h
//  Bylaw
//
//  Created by 小热狗 on 16/3/6.
//  Copyright © 2016年 小热狗. All rights reserved.
//

#ifndef BaseAPIList_h
#define BaseAPIList_h



//// 服务器地址
#define SERVER_TYPE  0// 0-测试环境,2-正式环境
#if SERVER_TYPE == 0
#define BASE_URL    @"http://city.cqtianwang.com/"

#define POST_INTERFACE(API)    [NSString stringWithFormat:@"%@%@",BASE_URL,API]


#elif SERVER_TYPE == 1
#define BASE_URL    @"http://113.204.229.74:8095"
#define POST_INTERFACE(API)    [NSString stringWithFormat:@"%@%@",BASE_URL,API]


#endif


//用户操作相关接口    ********************************

//用户注册
#define USER_REGISTER                    POST_INTERFACE(@"api/sms/register")


//手机验证码
#define USER_REGISTER_CODE               POST_INTERFACE(@"api/sms/getRegisterCode")


//登录验证
#define USER_LGOIN                        POST_INTERFACE(@"sso/login")

//修改用户使用密码
#define UPDATE_PWD                        POST_INTERFACE(@"api/bean/updatePwd")

//修改用户信息
#define UPDATE_USER                        POST_INTERFACE(@"api/bean/updateUser")

//广告轮播图
#define ADVER_LIST                        POST_INTERFACE(@"api/bean/getAdverList")

//快捷方式列表
#define SHORTCUT_LIST                      POST_INTERFACE(@"api/bean/getShortcutList")

//获取用户默认分组
#define SELECTDISTRICT                      POST_INTERFACE(@"api/basic/selectDistrict")

//根据分组查询分组下网点集合
#define SELECTDISTRICTDATA                      POST_INTERFACE(@"api/basic/selectBranchByDistraict")

//获取用户自定义分组
#define SELECTCUSTOM                      POST_INTERFACE(@"api/basic/selectCustom")

//删除用户自定义分组
#define DELETECUSTOM                      POST_INTERFACE(@"api/bean/deleteCustom")

//修改自定义分组名称
#define UPDATECUSTOM                      POST_INTERFACE(@"api/bean/updateCustom")

//创建自定义分组
#define ADDCUSTOM                        POST_INTERFACE(@"api/bean/addCustom")

//根据功能(模糊)查询类型,功能查询网点,设备,通道数据(分页)
#define BDCDATALIKE                        POST_INTERFACE(@"api/bean/getBdcDataLike")

//查询未自定义分组的网点数据(分页/可模糊)
#define GetNoCustomBranch                        POST_INTERFACE(@"api/bean/getNoCustomBranch")

//添加自定义分组下数据
#define ADDCUSTOMDATA                        POST_INTERFACE(@"api/bean/addCustomData")


//获取用户自定义分组下数据
#define SELECTCUSTOMData                      POST_INTERFACE(@"api/basic/selectCustomAndData")

//获取安防详情顶部数据展示
#define AnDetailHeadData                      POST_INTERFACE(@"api/basic/selectDeviceStateByBranch")

//新增快捷按键
#define ADDSHORTCUT                      POST_INTERFACE(@"api/bean/addShortcut")

//根据网点查询用户拥有的设备及状态（分页加载）
#define SELECTDevicePageByBranch                      POST_INTERFACE(@"api/basic/selectDevicePageByBranch")

//查询网点下设备状态分类数量
#define SELECTDeviceStateByBranch                      POST_INTERFACE(@"api/basic/selectDeviceStateByBranch")

//更具网点ID查询设备类型及数量
#define SELECTDevicesData                      POST_INTERFACE(@"api/basic/selectDeviceStateByBranch")

//查询当前网点下最近(历史)报警记录
#define SELECTBranchLatelyAlarmData                      POST_INTERFACE(@"api/alarm/getLatelyAlarm")

//获取设备详情数据
#define FacilityDetailData                      POST_INTERFACE(@"api/bean/selectDeviceById")
//获取设备详情通道列表数据
#define FacilityDetailBranchListData                      POST_INTERFACE(@"api/basic/selectChannelPageByDevice")

//根据网点查询用户所有设备通道
#define SelectChannelPageByBranch                      POST_INTERFACE(@"api/basic/selectChannelPageByBranch")

//根据通道ID查询详情
#define FacilityDetailChannelData                      POST_INTERFACE(@"api/bean/getChannelById")

//获取网点详情数据
#define LatticeDetailData                      POST_INTERFACE(@"api/bean/selectBranchById")

//获取网点详情顶部展示数据
#define LatticeDetailHeadData                      POST_INTERFACE(@"api/bean/selectDeviceTypeCount")

//网点一键布防,撤防,消警
#define AlarmBranchBCF                      POST_INTERFACE(@"api/alarm/setBranchBCF")

//设备单独布防,撤防,消警
#define AlarmDeviceBCF                      POST_INTERFACE(@"api/alarm/setDeviceBCF")

//获取用户拥有小区及门信息
#define GetUserAndBranchData                      POST_INTERFACE(@"app/getUserAndBranchData")

//验证登录用户是否需要实名认证
#define IsNeedCertification                      POST_INTERFACE(@"app/isNeedCertification")

//上传图片
#define UploadImage                      POST_INTERFACE(@"app/uploadImg")

//根据身份证正面获取信息
#define GetIdCardInfo                      POST_INTERFACE(@"IdCardInfo/getIdCardInfo")

//申请门禁用户基本信息认证接口
#define SaveUserInfo                      POST_INTERFACE(@"app/saveUserInfo")

//模糊搜索小区接口
#define selectBranchList                      POST_INTERFACE(@"app/selectBranchList")

//房屋绑定申请审核接口
#define auditApprovalOrRefusedTo                      POST_INTERFACE(@"app/auditApprovalOrRefusedTo")

//根据小区及扩张区域查询子级扩展区域数据接口
#define selectChildList                      POST_INTERFACE(@"app/selectChildList")

//根据门ID开门
#define openDoor                      POST_INTERFACE(@"app/openDoor")

//用户申请房屋绑定请求接口
#define saveUserHouse                      POST_INTERFACE(@"app/saveUserHouse")

//用户申请房屋绑定请求接口
#define getHouseDetail                      POST_INTERFACE(@"app/getMyHouseMembers")

//根据经纬度获取离我最近的小区数据
#define getNearbyAreaData                      POST_INTERFACE(@"app/getBranchInfoByLgLa")

//根据经纬度获取离我最近的小区数据
#define getAreaData                      POST_INTERFACE(@"app/getBranchInfoByLgLa")

//房屋绑定审核查询
#define selectAppUserHouse                      POST_INTERFACE(@"app/selectAppUserHouse")

//增加访客请求接口
#define createVisitors                      POST_INTERFACE(@"app/createVisitors")

//开门记录
#define openDoorHistory                      POST_INTERFACE(@"app/getOpenDoorRecord")

//获取人脸信息
#define getFaceData                      POST_INTERFACE(@"app/getLifePhoto")

//更新人脸信息
#define updateFaceData                      POST_INTERFACE(@"app/updateLifePhoto")


//我的房屋
#define myHouseList                      POST_INTERFACE(@"app/getHouseInfoList")

//查询访客记录
#define getVisitorsRecord                      POST_INTERFACE(@"app/getVisitorsRecord")

//查询待审核的申请房屋绑定数据
#define getApplyAuditData                      POST_INTERFACE(@"app/getApplyAuditData")

//查询成员管理数据
#define getMemberManagementData                      POST_INTERFACE(@"app/getMemberManagementData")

//房屋绑定申请审核接口
#define auditApprovalOrRefusedTo                      POST_INTERFACE(@"app/auditApprovalOrRefusedTo")

//查询拥有小区及房屋信息
#define getBranchAreasInfo                      POST_INTERFACE(@"app/getBranchAreasInfo")

//查询申请审核人详细信息
#define getApplyUserInfo                      POST_INTERFACE(@"app/getApplyUserInfo")

//云Mark笔记操作相关接口   ********************************

//添加笔记
#define NOTE_ADDNOTE              POST_INTERFACE(@"/Note/addnote")

//删除笔记
#define NOTE_DELETENOTE                    POST_INTERFACE(@"/Note/deletenote")

//编辑笔记
#define NOTE_EDIT                          POST_INTERFACE(@"/Note/edit")

//通过用户ID查询笔记
#define NOTE_GETBYID                         POST_INTERFACE(@"/Note/getById")

//通过笔记标题和笔记文本内容模糊查询笔记
#define NOTE_GETBYLIKE                         POST_INTERFACE(@"/Note/getByLike")

//根据笔记类型查询笔记
#define NOTE_QUERYNOTESBYNOTETYPEID               POST_INTERFACE(@"/Note/queryNotesByNoteTypeId")

//根据标签ID查询笔记
#define NOTE_QUERYNOTESBYNOTETAGID                         POST_INTERFACE(@"/Note/queryNotesByTagId")



//云Mark标签操作相关接口   ********************************

//添加标签
#define TAG_ADDTAG                 POST_INTERFACE(@"/Tag/addTag")

//修改标签名称
#define TAG_CHANGENAME                         POST_INTERFACE(@"/Tag/changeName")

//删除标签
#define TAG_DELETETAG               POST_INTERFACE(@"/Tag/deleteTag")

//根据用户名称查询标签名称
#define TAG_SELECTUSERTAGS                         POST_INTERFACE(@"/Tag/selectUserTags")


//媒体(上传、下载)   ********************************

//上传
#define MEDIA_UPLOAD                         POST_INTERFACE(@"/media/upload")



#define HTTP_REQUEST  1
#define JSON_REQUEST  2


#endif /* BaseAPIList_h */
