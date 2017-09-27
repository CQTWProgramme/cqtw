//
//  FacilityDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "FacilityDetailVC.h"
#import "FacilityDetailModel.h"

@interface FacilityDetailVC ()
@property (nonatomic, strong) FacilityDetailModel *detailModel;
@end

@implementation FacilityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData {
    [FacilityDetailModel getDetailDataById:self.deviceId 
                                   success:^(id returnValue) {
        
                                       self.detailModel = returnValue;
                                 } failure:^(id errorCode) {
                                       
                                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
