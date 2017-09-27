//
//  MulChooseCell.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "TableChooseCell.h"
#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TableChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, ColorRGB(0xf7f7f7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self MakeView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)MakeView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.SelectIconBtn];
    [self.contentView addSubview:self.logoImageView];
    
    _logoImageView.sd_layout
    .widthIs(40)
    .heightEqualToWidth()
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10);
    
    _titleLabel.sd_layout
    .centerYEqualToView(_logoImageView)
    .leftSpaceToView(_logoImageView, 10)
    .rightSpaceToView(self.contentView, 60)
    .heightIs(20);

    
    _SelectIconBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    
}



-(UIImageView *)logoImageView{
    
    if (!_logoImageView) {
        _logoImageView=[UIImageView new];
        _logoImageView.image=ImageNamed(@"home_monitor");
    }
    return _logoImageView;
    
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIButton *)SelectIconBtn{
    if (!_SelectIconBtn) {
        _SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
        _SelectIconBtn.userInteractionEnabled = NO;
    }
    return _SelectIconBtn;
}


-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
