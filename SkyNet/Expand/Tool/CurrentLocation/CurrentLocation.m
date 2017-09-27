//
//  CurrentLocation.m
//  MoneyTree
//
//  Created by duck on 16/4/15.
//  Copyright © 2016年 yqs. All rights reserved.
//

#import "CurrentLocation.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@implementation CurrentLocation

//单例
+ (CurrentLocation *)sharedManager{
    static CurrentLocation *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

#pragma mark 获取定位信息
-(void)getUSerLocation{
    _locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"开始定位");
        _locationManager.delegate = self;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 200.0;
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，NSLocationAlwaysUsageDescription，值可以为空
        if (IOS_VERSION >=8.0) {//ios8+，不加这个则不会弹框
            [_locationManager requestWhenInUseAuthorization];//使用中授权
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位失败，请确定是否开启定位功能");
        _locationManager.delegate = self;
        //        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        //        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 200.0;
        //  kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
    
}


#pragma mark 定位成功
//ios 6.0sdk以上
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    
    self.lat=[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    self.lng=[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
   // CLLocation *l=[[CLLocation alloc]initWithLatitude:25.04 longitude:102.73];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //将获得的所有信息显示到label上
            //获取城市
             NSString *area;
             NSString *province = placemark.name;//
             area=province;
            if ([province isEqualToString:@"重庆市"]||[province isEqualToString:@"北京市"]||[province isEqualToString:@"天津市"]||[province isEqualToString:@"上海市"]) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 area = placemark.subLocality;
             }
             
             
             self.areaName = area;
             //[ClientTool sharedManager].localStr=area;
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}


#pragma mark 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        [self openGPSTips];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
   
    self.lat=@"";
    self.lng=@"";
    self.areaName=@"";
    

}


-(void)openGPSTips{
    UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alet show];
}



#pragma mark 判断城市名字
/**
 *  判断城市名字
 *
 *  @param theJsonName      city.json里面的城市名字
 *  @param theLocationName  定位获取的名字
 *
 *  @return 是否包含
 */
-(BOOL)theNameInJson:(NSString *)theJsonName isContainLocatinName:(NSString *)theLocationName{
    
    if ([theJsonName rangeOfString:theLocationName].location != NSNotFound) {
        
        return YES;
        
    }
    return NO;
}
@end
