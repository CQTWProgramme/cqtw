//
//  CurrentLocation.h
//  MoneyTree
//
//  Created by duck on 16/4/15.
//  Copyright © 2016年 yqs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface CurrentLocation : NSObject<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) NSString *areaName;
@property(nonatomic,strong) NSString *code;
@property(nonatomic,strong) NSString * lat;
@property(nonatomic,strong) NSString * lng;

/**
 *  获取定位信息
 */
-(void)getUSerLocation;
/**
 *  通过城市名字获取城市Code
 *
 *  @param cityName 城市名字
 */
-(void)getCodeWithCityName:(NSString *)cityName;
+ (CurrentLocation *)sharedManager;

@end
