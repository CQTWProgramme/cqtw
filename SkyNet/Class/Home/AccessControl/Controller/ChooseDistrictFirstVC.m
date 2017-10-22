//
//  ChooseDistrictFirstVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ChooseDistrictFirstVC.h"
#import "ChooseDistrictSecondVC.h"

@interface ChooseDistrictFirstVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISearchBar * mySearchBar;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation ChooseDistrictFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.title=@"门禁";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mySearchBar];
    [self.view addSubview:self.myTableView];
}

#pragma mark 搜索框懒加载
-(UISearchBar * )mySearchBar{
    if (!_mySearchBar) {
        _mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+NavigationBar_HEIGHT, SCREEN_WIDTH,44)];
        
        [_mySearchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        
        _mySearchBar.tintColor=[UIColor groupTableViewBackgroundColor];
        
        // [_mySearchBar setSearchBarPlaceholdePositon];
        _mySearchBar.delegate = self;
        [_mySearchBar setPlaceholder:@"请输入小区名称"];
        [_mySearchBar setContentMode:UIViewContentModeLeft];
        _mySearchBar.showsCancelButton=YES;
        
    }

    return _mySearchBar;
}

-(UITableView *)myTableView {
    if (nil == _myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.mySearchBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.mySearchBar.bottom) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=70;
    }
    return _myTableView;
}

#pragma tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ChooseDistrictFirstVCcellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"测试";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = @"测试测试测试测试测试测试测试";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChooseDistrictSecondVC *secondVC = [[ChooseDistrictSecondVC alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
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
