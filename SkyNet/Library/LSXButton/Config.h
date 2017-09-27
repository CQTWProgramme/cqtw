//
//  Config.h
//  医联通
//
//  Created by 医联通 on 16/5/26.
//  Copyright © 2016年 eltyl. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#pragma mark - 设备型号识别
#define is_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#pragma mark - 硬件
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#pragma mark - 中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]
#define kScreenWidthRatio  (SCREEN_WIDTH / 414.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 736.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000


//黄
#define MainColor [UIColor colorWithHexString:@"#FFC914"]
//浅灰
#define GrayColor [UIColor colorWithHexString:@"999999"]
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]



#endif /* Config_h */
