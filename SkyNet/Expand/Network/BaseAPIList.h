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
#define BASE_URL    @"http://bs.cqtianwang.com:1111/"

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


//广告轮播图
#define ADVER_LIST                        POST_INTERFACE(@"api/bean/getAdverList")

//快捷方式列表
#define SHORTCUT_LIST                      POST_INTERFACE(@"api/bean/getShortcutList")


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

//添加自定义分组下数据
#define ADDCUSTOMDATA                        POST_INTERFACE(@"api/bean/addCustomData")


//获取用户自定义分组下数据
#define SELECTCUSTOMData                      POST_INTERFACE(@"api/basic/selectCustomData")




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
