//
//  NSString+THCAddtion.h
//  THCFramework
//
//  Created by Jeffery He on 15/2/23.
//  Copyright (c) 2015年 Jeffery He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (THCAddtion)

#pragma mark - 计算字符串截取等功能
/**
 *  判断是否存在字符串
 *
 *  @param string 需要判断的字符串
 *
 *  @return 如果存在返回YES，反之返回NO
 */
- (BOOL)isContainsString:(NSString *)string;

/**
 *  返回字符串中指定位置的字符
 *
 *  @param index 指定的位置
 *
 *  @return 返回的字符
 */
- (unichar)charAt:(NSUInteger)index;

/**
 *  检索某个字符串的位置
 *
 *  @param str 需要检索的字符串
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)indexOfString:(NSString*)str;

/**
 *  检索某个字符串的位置
 *
 *  @param str   需要检索的字符串
 *  @param index 起始位置(闭区间)
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)indexOfString:(NSString*)str fromIndex:(int)index;

/**
 *  检索第一个字符串出现的位置
 *
 *  @param str 需要检索的字符串
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)firstIndexOfString:(NSString *)str;

/**
 *  检索第一个字符串出现的位置
 *
 *  @param str   需要检索的字符串
 *  @param index 从什么位置开始检索
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)firstIndexOfString:(NSString*)str fromIndex:(int)index;

/**
 *  检索最后一个字符串出现的位置
 *
 *  @param str 需要检索的字符串
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)lastIndexOfString:(NSString*)str;

/**
 *  检索最后一个字符串出现的位置
 *
 *  @param str   需要检索的字符串
 *  @param index 从什么位置开始检索
 *
 *  @return 返回检索后的位置
 */
- (NSUInteger)lastIndexOfString:(NSString*)str fromIndex:(int)index;

/**
 *  截子串
 *
 *  @param beginIndex 开始的位置(闭区间)
 *  @param endIndex   结束的位子(开区间)
 *
 *  @return 返回截完后的字符串
 */
- (NSString *)substringFromIndex:(NSUInteger)beginIndex toIndex:(NSUInteger)endIndex;

/**
 *  去掉json字符串中的一头一尾的双引号
 *
 *  @return 返回截完后的JSON字符串
 */
- (NSString *)removeJsonStringQuotes;

/**
 *  去掉头尾空格
 *
 *  @return 返回去掉了头尾空格的字符串
 */
- (NSString *)trim;


#pragma mark - 字符串的网络编码
/**
 *  返回encode编码后的url字符串
 *
 *  @return 返回encode编码后的url字符串
 */
- (NSString *)urlEncode;

/**
 *  返回decode编码后的url字符串
 *
 *  @return 返回decode编码后的url字符串
 */
- (NSString *)urlDecode;

#pragma mark - 计算字符串的frame
/**
 *  通过字体和size计算出字符串的CGRect
 *
 *  @param font 字体
 *  @param size size
 *
 *  @return 返回计算好的CGRect
 */
- (CGRect)measureFrameWithFont:(UIFont *)font size:(CGSize)size;
#pragma mark - MD5加密
- (NSString *)md5Encrypt;

#pragma mark - 返回json对象
- (id)JSONObject;

+ (BOOL)isEmpty:(NSString *)string;

+(BOOL)isContainsEmoji:(NSString *)string;

+ (NSString *)deviceString;
@end
