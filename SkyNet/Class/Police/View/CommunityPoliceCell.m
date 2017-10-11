//
//  CommunityPoliceCell.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "CommunityPoliceCell.h"
#import "CommunityPoliceModel.h"

@interface CommunityPoliceCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headImageviewHeight;

@end

@implementation CommunityPoliceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentity = @"CommunityPoliceCellCell";
    
    CommunityPoliceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    if (cell == nil){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CommunityPoliceCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    return cell;
}

-(void)setModel:(CommunityPoliceModel *)model {
    _model = model;
    if (model.imgUrl == nil) {
        self.headImageviewHeight.constant = 0;
    }else {
        self.headImageviewHeight.constant = 80;
    }
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time;
}
@end
