//
//  MemberControlModel.h
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/12.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberControlModel : NSObject
@property (nonatomic, copy) NSString *cardnumId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *houseName;
@property (nonatomic, assign) NSInteger type;

@end
