//
//  LSXButton.h
//  Badminton
//
//  Created by 医联通 on 17/3/7.
//  Copyright © 2017年 LSX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
typedef NS_ENUM(NSInteger , LSXButtonType) {
    LSXButtonTypeDefault = 0,
    LSXButtonTypeImgdwon,
    LSXButtonTypeImgrignt,
    LSXButtonTypeImgleft,
};

@interface LSXButton : UIButton

@property(nonatomic,strong)UILabel * titLa;

/**
 *  是否按原图大小加载图片  默认为no
 */
@property (nonatomic, assign , getter=isDefImageing)  BOOL isDefImg;

/**
 *  字和图片的间距  默认是 5
 */
@property (nonatomic, assign) CGFloat Margin;

/**
 *  创建按钮的类型  默认是 Default 上图下字
 */
@property (nonatomic, assign) LSXButtonType type;

/**
 *   设置字体大小  默认是 17
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 *   设置字体颜色  默认是 black
 */
@property (nonatomic, assign) UIColor * textColor;


/**
 *  1. 先创建按钮大小，，然后调用这个方法赋值，，否则会出现无法显示内容的情况
 *  2. 根据创建的按钮 fram 设置图片以及文字的位置，
 *  3. 支持网络图片 imgName 传 url地址即可  会根据图片的宽高比例适配图片大小，
 */
-(void)CreatSXbtnImg:(NSString *)imgName WithTitle:(NSString *)tit;

@end
