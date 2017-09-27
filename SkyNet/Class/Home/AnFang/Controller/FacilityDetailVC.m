//
//  FacilityDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "FacilityDetailVC.h"
#import "FacilityDetailModel.h"

@interface FacilityDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FacilityDetailModel *detailModel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FacilityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备详情";
    //[self getData];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)getData {
    [FacilityDetailModel getDetailDataById:self.deviceId 
                                   success:^(id returnValue) {
        
                                       self.detailModel = returnValue;
                                 } failure:^(id errorCode) {
                                       
                                 }];
}
#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"通道的名称%@",@(indexPath.row)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
