//
//  LatticePointDetailVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/27.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "LatticePointDetailVC.h"
#import "LatticePointDetailHeaderView.h"
#import "LatticePointDetailModel.h"
#import <MapKit/MapKit.h>
#import "EditInstallerVC.h"
#import "KYAlertView.h"
#import "AFViewModel.h"

@interface LatticePointDetailVC ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate> {
    MKMapView *_mapView;
}
@property (nonatomic, strong)LatticePointDetailHeaderView *headerView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) LatticePointDetailModel *myModel;
@end

@implementation LatticePointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网点详情";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self createRightItem];
    [self setupHeadData];
    [self setupdata];
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setBackgroundImage:ImageNamed(@"sendfast") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(creatFastAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)creatFastAction {
    NSString *title = [NSString stringWithFormat:@"请确认是否将当前网点添加到系统快捷方式?"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            NSLog(@"取消");
            
        }else  if (index == 1) {
            
            [self addShortcut];
        }
        
    };
    [alert show];
}

- (void)addShortcut {
    AFViewModel *viewModel = [AFViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    if (self.headerView.title == nil) {
        self.headerView.title = @"";
    }
    [viewModel addShortcutDataWithDataId:self.branchId name:self.headerView.title lx:@"1"];
}

//获取头部数据
-(void)setupHeadData {
    MJWeakSelf
    [LatticePointDetailModel getLatticePointDetailHeadDataById:self.branchId success:^(id returnValue) {
        
        for (NSDictionary *dic in returnValue) {
            NSString *type = dic[@"type"];
            long long count = [dic[@"count"] longLongValue];
            if ([type containsString:@"安防"]) {
                weakSelf.headerView.zxLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
            if ([type containsString:@"门禁"]) {
                weakSelf.headerView.lxLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
            if ([type containsString:@"视频"]) {
                weakSelf.headerView.bfLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
            if ([type containsString:@"WIFI"]) {
                weakSelf.headerView.bjLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
            if ([type containsString:@"消防"]) {
                weakSelf.headerView.cfLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
            if ([type containsString:@"语音"]) {
                weakSelf.headerView.yyLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            }
        }
    } failure:^(id errorCode) {
        
    }];
}

- (void)setupdata {
    [LatticePointDetailModel getLatticePointDetailDataById:self.branchId success:^(id returnValue) {
        self.myModel = returnValue;
        [self setupHeaderView];
        [self setupTableView];
        [self setupMapView];
    } failure:^(id errorCode) {
        
    }];
}

- (void)setupHeaderView {
    LatticePointDetailHeaderView *headerView = [[LatticePointDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    headerView.title = self.myModel.wdmc;
    self.headerView = headerView;
}

- (void)setupTableView {
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headerView;
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH, 6 * 44 + 250) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
    }
    return _myTableView;
}

- (void)setupMapView{
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.myTableView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.myTableView.bottom)];
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = YES;
    _mapView.scrollEnabled = YES;
    _mapView.delegate = self;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(29.35,106.33);
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    
    MKCoordinateRegion region = {coordinate,span};
    
    [_mapView setRegion:region];
    
    MKPointAnnotation *annomation = [[MKPointAnnotation alloc] init];
    annomation.coordinate = coordinate;
    [_mapView addAnnotation:annomation];
    
    [self.view addSubview:_mapView];
}

#pragma mark 显示标注视图
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *annotationID = @"annotation";
    MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationID];
    if (!view)
    {
        view = [[MKPinAnnotationView alloc]init];
    }
    view.annotation = annotation;
    view.pinColor = MKPinAnnotationColorRed;
    view.canShowCallout = YES;
    return view;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"网点编号";
        cell.detailTextLabel.text = self.myModel.wdbh;
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"网所属行政区";
        cell.detailTextLabel.text = self.myModel.districtMc;
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"安装人员";
        cell.detailTextLabel.text = self.myModel.azry;
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"运维值班中心";
        cell.detailTextLabel.text = self.myModel.alarmoperMc;
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"主管部门值班中心";
        cell.detailTextLabel.text = self.myModel.alarmchargeMc;
    }else if (indexPath.row == 5) {
        cell.textLabel.text = @"位置";
        cell.detailTextLabel.text = self.myModel.wdwz;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    EditInstallerVC *installerVC = [[EditInstallerVC alloc] init];
//    [self.navigationController pushViewController:installerVC animated:YES];
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
