//
//  UserInfo.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/24.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *_userinfo = nil;

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userinfo = [[super allocWithZone:NULL] init];
    });
    return _userinfo;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [UserInfo shareInstance];
}

-(id)copyWithZone:(NSZone *)zone {
    return [UserInfo shareInstance];
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return [UserInfo shareInstance];
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.bz = [aDecoder decodeObjectForKey:@"bz"];
//        self.cardnumId = [aDecoder decodeObjectForKey:@"cardnumId"];
//        self.dh = [aDecoder decodeObjectForKey:@"dh"];
//        self.districtId = [aDecoder decodeObjectForKey:@"districtId"];
//        self.dlmm = [aDecoder decodeObjectForKey:@"dlmm"];
//        self.dlsj = [aDecoder decodeObjectForKey:@"dlsj"];
//        self.dlzh = [aDecoder decodeObjectForKey:@"dlzh"];
//        self.jsonconfig = [aDecoder decodeObjectForKey:@"jsonconfig"];
//        self.enablepushapp = [aDecoder decodeIntegerForKey:@"enablepushapp"];
//        self.mqTopic = [aDecoder decodeObjectForKey:@"mqTopic"];
//        self.msqUrl = [aDecoder decodeObjectForKey:@"msqUrl"];
//        self.roleId = [aDecoder decodeObjectForKey:@"roleId"];
//        self.userId = [aDecoder decodeObjectForKey:@"userId"];
//        self.wxOpenId = [aDecoder decodeObjectForKey:@"wxOpenId"];
//        self.xgsj = [aDecoder decodeObjectForKey:@"xgsj"];
//        self.yhlx = [aDecoder decodeIntegerForKey:@"yhlx"];
//        self.yhxb = [aDecoder decodeIntegerForKey:@"yhxb"];
//        self.yhzt = [aDecoder decodeIntegerForKey:@"yhzt"];
//        self.yhxm = [aDecoder decodeObjectForKey:@"yhxm"];
//    }
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_bz forKey:@"bz"];
//    [aCoder encodeObject:_cardnumId forKey:@"cardnumId"];
//    [aCoder encodeObject:_dh forKey:@"dh"];
//    [aCoder encodeObject:_districtId forKey:@"districtId"];
//    [aCoder encodeObject:_dlmm forKey:@"dlmm"];
//    [aCoder encodeObject:_dlsj forKey:@"dlsj"];
//    [aCoder encodeObject:_dlzh forKey:@"dlzh"];
//    [aCoder encodeInteger:_enablepushapp forKey:@"enablepushapp"];
//    [aCoder encodeObject:_jsonconfig forKey:@"jsonconfig"];
//    [aCoder encodeObject:_mqTopic forKey:@"mqTopic"];
//    [aCoder encodeObject:_msqUrl forKey:@"msqUrl"];
//    [aCoder encodeObject:_roleId forKey:@"roleId"];
//    [aCoder encodeObject:_userId forKey:@"userId"];
//    [aCoder encodeObject:_wxOpenId forKey:@"wxOpenId"];
//    [aCoder encodeObject:_xgsj forKey:@"xgsj"];
//    [aCoder encodeInteger:_yhlx forKey:@"yhlx"];
//    [aCoder encodeInteger:_yhxb forKey:@"yhxb"];
//    [aCoder encodeInteger:_yhzt forKey:@"yhzt"];
//    [aCoder encodeObject:_yhxm forKey:@"yhxm"];
//}

//+(void)saveUserInfo {
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *infoPath = [documentPath stringByAppendingString:@"userinfo.data"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:infoPath]) {
//        return;
//    }
//
//    NSMutableData *mutableData = [NSMutableData data];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
//    [archiver encodeObject:[UserInfo shareInstance] forKey:@"userinfo"];
//    [archiver finishEncoding];
//    [mutableData writeToFile:infoPath atomically:YES];
//
//}

//+(void)removeUserInfo {
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *infoPath = [documentPath stringByAppendingString:@"userinfo.txt"];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:infoPath]) {
//        return;
//    }
//    [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:infoPath] error:nil];
//}
@end
