//
//  THCTextView.h
//  THCFramework
//
//  Created by Jeffery He on 15/2/22.
//  Copyright (c) 2015年 Jeffery He. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class
 @abstract 含有placeHolder的TextView
 */
@interface THCTextView : UITextView

/*!
 @property
 @abstract placeHolder的字符串
 */
@property (nonatomic, copy) NSString *placeHolder;

/*!
 @property
 @abstract placeHoder的颜色
 */
@property (nonatomic, strong) UIColor *holderColor;

@end
