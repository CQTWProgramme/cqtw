//
//  LSXButton.m
//  Badminton
//
//  Created by 医联通 on 17/3/7.
//  Copyright © 2017年 LSX. All rights reserved.
//

#import "LSXButton.h"

#define  W self.frame.size.width
#define  H self.frame.size.height

@interface LSXButton() {
    UIImageView * _imgView;
    
}
@property(assign,nonatomic) CGFloat imgW;
@property(assign,nonatomic) CGFloat imgH;
@end

@implementation LSXButton

-(void)CreatSXbtnImg:(NSString *)imgName WithTitle:(NSString *)tit{

     __weak typeof(self)weakSelf = self;
    
    weakSelf.imgH=0;
    weakSelf.imgW=0;
    
    if(!weakSelf.fontSize){
        weakSelf.fontSize=17;
    }
    if(!weakSelf.textColor){
        weakSelf.textColor=[UIColor blackColor];
    }
    if(!weakSelf.Margin){
        weakSelf.Margin=5;
    }
    _imgView=[UIImageView new];
    [self addSubview:_imgView];
    
    _titLa=[UILabel new];
    _titLa.textColor=_textColor;
    _titLa.text=tit;
    _titLa.textAlignment=NSTextAlignmentCenter;
    _titLa.font=AdaptedFontSize(_fontSize);
    [self addSubview:_titLa];
    
    CGFloat marginClera=15;
    
    if([imgName rangeOfString:@"/"].location != NSNotFound){
        
        if(weakSelf.isDefImg==YES){
        
            weakSelf.imgW=[self getImageSizeWithURL:[NSURL URLWithString:imgName]].width;
            weakSelf.imgH=[self getImageSizeWithURL:[NSURL URLWithString:imgName]].height;
            
        }else{
            //计算网络图片宽高比例
            if(_type==LSXButtonTypeDefault || _type==LSXButtonTypeImgdwon){
                CGFloat bb=[self getImageSizeWithURL:[NSURL URLWithString:imgName]].height/[self getImageSizeWithURL:[NSURL URLWithString:imgName]].width;
                weakSelf.imgW=W-marginClera;
                weakSelf.imgH=bb*_imgW;
            }else if (_type==LSXButtonTypeImgrignt || _type==LSXButtonTypeImgleft){
                CGFloat bb=[self getImageSizeWithURL:[NSURL URLWithString:imgName]].width/[self getImageSizeWithURL:[NSURL URLWithString:imgName]].height;
                weakSelf.imgH=H-marginClera;
                weakSelf.imgW=bb*_imgH;
            }
        }
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imgName]];
    }else{
        //计算本地图片宽高比例
        UIImage *img=[UIImage imageNamed:imgName];
        if(weakSelf.isDefImg==YES){
            
            weakSelf.imgW=img.size.width;
            weakSelf.imgH=img.size.height;
            
        }else{
            if(_type==LSXButtonTypeDefault || _type==LSXButtonTypeImgdwon){
                
                CGFloat bb=img.size.height/img.size.width;
                weakSelf.imgW=W-marginClera;
                weakSelf.imgH=bb*_imgW;
                
            }else if (_type==LSXButtonTypeImgrignt || _type==LSXButtonTypeImgleft){
                
                CGFloat bb=img.size.width/img.size.height;
                weakSelf.imgH=H-marginClera;
                weakSelf.imgW=bb*_imgH;
            }
        }
        _imgView.image=img;
    }
    if(_type==LSXButtonTypeDefault || !_type){
    
        CGFloat p=(H-weakSelf.imgH-AdaptedHeight(_fontSize)-_Margin)/2;
        _imgView.sd_layout.leftSpaceToView(self,(W-weakSelf.imgW)/2).topSpaceToView(self,p).widthIs(weakSelf.imgW).heightIs(weakSelf.imgH);
        _titLa.sd_layout.leftSpaceToView(self,0).topSpaceToView(_imgView,_Margin).widthIs(W).heightIs(AdaptedHeight(_fontSize));
        
    }else if (_type==LSXButtonTypeImgrignt){
    
        CGFloat p=(W-weakSelf.imgW-_Margin-tit.length*AdaptedWidth(_fontSize))/2;
        _titLa.sd_layout.leftSpaceToView(self,p).topSpaceToView(self,0).widthIs(AdaptedWidth(_fontSize)*tit.length).bottomSpaceToView(self,0);
        _imgView.sd_layout.leftSpaceToView(_titLa,_Margin).topSpaceToView(self,(H-_imgH)/2).widthIs(weakSelf.imgW).heightIs(weakSelf.imgH);
        
    }else if (_type==LSXButtonTypeImgdwon){
        
         CGFloat p=(H-weakSelf.imgH-AdaptedHeight(_fontSize)-_Margin)/2;
        _titLa.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,p).widthIs(W).heightIs(AdaptedHeight(_fontSize));
        _imgView.sd_layout.leftSpaceToView(self,(W-weakSelf.imgW)/2).topSpaceToView(_titLa,_Margin).widthIs(weakSelf.imgW).heightIs(weakSelf.imgH);
    }else if (_type==LSXButtonTypeImgleft){
    
         CGFloat p=(W-weakSelf.imgW-_Margin-tit.length*AdaptedWidth(_fontSize))/2;
        
        _imgView.sd_layout.leftSpaceToView(self,p).topSpaceToView(self,(H-_imgH)/2).widthIs(weakSelf.imgW).heightIs(weakSelf.imgH);
        _titLa.sd_layout.leftSpaceToView(_imgView,_Margin).topSpaceToView(self,0).widthIs(AdaptedWidth(_fontSize)*tit.length).bottomSpaceToView(self,0);
    }
}
// 根据图片url获取图片尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    NSLog(@"---------%f-----%f",size.width,size.height);
    return size;
}
//  获取PNG图片的大小
-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
   
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
@end
