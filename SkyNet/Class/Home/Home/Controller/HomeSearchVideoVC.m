//
//  HomeSearchVideoVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/11/16.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "HomeSearchVideoVC.h"

@interface HomeSearchVideoVC ()

@end

@implementation HomeSearchVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResult:) name:@"GetSearchResultNotification" object:nil];
}

- (void)getResult:(NSNotification *)notification {
    NSString *searchText = [notification.userInfo objectForKey:@"searchText"];
    NSInteger type = [[notification.userInfo objectForKey:@"type"] integerValue];
    if (type == 2) {
        NSLog(@"searchText------%@",searchText);
    }
}

@end