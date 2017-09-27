//
//  EquipmentVC.m
//  SkyNet
//
//  Created by 冉思路 on 2017/9/26.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "EquipmentVC.h"
#import "EquipCell.h"
@interface EquipmentVC ()

@end

@implementation EquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.myTableView];
}


#pragma mark 下拉刷新
-(void)reloadTableView{
    
    __weak typeof(self)weakSelf =self;
    //[self getGroupData];
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        [weakSelf.myRefreshView endRefreshing];
        
    });
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
        
        
        static NSString *ID = @"EquipCell";
        EquipCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        cell = [[EquipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       cell.equitTitle.text=[NSString stringWithFormat:@"设备%ld",indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        
        return cell;
        
    
    
    return cell;
    
}



-(UITableView *)myTableView{
    
    MJWeakSelf
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = BACKGROUND_COLOR;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight=44;
        _myTableView.tableFooterView=[[UIView alloc]init];
//        [_myTableView setReloadBlock:^{
//            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
//            
//                [weakSelf reloadTableView];
//            
//        }];
        
        
        //_myTableView.tableHeaderView=_headView;
        //..下拉刷新
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.myRefreshView = weakSelf.myTableView.mj_header;
            
                [weakSelf reloadTableView];
            
            
        }];
        
        // 马上进入刷新状态
        [_myTableView.mj_header beginRefreshing];
        
        //        //..上拉刷新
        //        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            weakSelf.myRefreshView = weakSelf.myTableView.mj_footer;
        //            weakSelf.beginIndex = weakSelf.beginIndex + 5;
        //            weakSelf.endIndex=weakSelf.endIndex+5;
        //            [weakSelf refreshTableViewWithBeginIndex:weakSelf.beginIndex endIndex:weakSelf.endIndex];
        //
        //        }];
        //
        //        _myTableView.mj_footer.hidden = YES;
        
        
    }
    
    return _myTableView;
    
    
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
