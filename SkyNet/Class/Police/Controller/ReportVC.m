//
//  ReportVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/11.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "ReportVC.h"
#import "THCTextView.h"

#define PIC_DELETE_KEY "ReportPicDeleteKey"

@interface ReportVC ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *titleTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *picScrollerView;
@property (strong, nonatomic) IBOutlet THCTextView *contentTextView;

@end

@implementation ReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要举报";
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentTextView.placeHolder = @"请输入内容";
    [self setNavBackButtonTitle:@"取消"];
    [self createRightItem];
    [self resumeScrollerView];
}

//重置scrollerVIew
- (void)resumeScrollerView {

    //添加选择图片按钮
    UIImageView *cameraImageView = [[UIImageView alloc] init];
    cameraImageView.frame = CGRectMake(10, 10, 40, 40);
    cameraImageView.image = [UIImage imageNamed:@"home_door"];
    cameraImageView.userInteractionEnabled = YES;
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(25, -15, 30, 30);
    [deleteBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deletePicAction:) forControlEvents:UIControlEventTouchDown];
    deleteBtn.hidden = YES;
    
    objc_setAssociatedObject(deleteBtn, PIC_DELETE_KEY, cameraImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [cameraImageView addSubview:deleteBtn];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(picLongTap:)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picTap:)];
    
    [cameraImageView addGestureRecognizer:tap];
    [cameraImageView addGestureRecognizer:longTap];
    
    [self.picScrollerView addSubview:cameraImageView];
    self.picScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 60);
}

- (void)deletePicAction:(UIButton *)button {
    
    UIImageView *deleteImageView = objc_getAssociatedObject(button, PIC_DELETE_KEY);
    
    NSMutableArray *subViewsArr = [NSMutableArray array];
    for (UIImageView *subView in self.picScrollerView.subviews) {
        if (subView.alpha != 0) {
            [subViewsArr addObject:subView];
        }
    }
    NSInteger startCount = [subViewsArr indexOfObject:deleteImageView];
    [deleteImageView removeFromSuperview];
    for (NSInteger i = startCount; i < subViewsArr.count; i++) {
        UIImageView *imageView = subViewsArr[i];
        [UIView animateWithDuration:0.6 animations:^{
            imageView.x -= 50;
        }];
    }
    
    UIImageView *lastImageView = subViewsArr[subViewsArr.count - 1];
    if (lastImageView.right > SCREEN_WIDTH) {
        self.picScrollerView.contentSize = CGSizeMake(lastImageView.right + 10, 60);
    }else {
        self.picScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 60);
    }
    
}

- (void)picTap:(UITapGestureRecognizer *)tap {
    
    UIImageView *imageView = (UIImageView *)tap.view;
    NSMutableArray *subViewsArr = [NSMutableArray array];
    for (UIImageView *subView in self.picScrollerView.subviews) {
        if (subView.alpha != 0) {
            [subViewsArr addObject:subView];
        }
    }
    if (imageView == subViewsArr[subViewsArr.count - 1]) {
        //选择照片或者拍照
        NSLog(@"选择拍照");
        NSArray *arr = @[@(1)];
        [self addPic:arr];
    }else {
        NSLog(@"提示长按删除");
    }
}

- (void)picLongTap:(UILongPressGestureRecognizer *)longTap {
    UIImageView *imageView = (UIImageView *)longTap.view;
    NSMutableArray *subViewsArr = [NSMutableArray array];
    for (UIImageView *subView in self.picScrollerView.subviews) {
        if (subView.alpha != 0) {
            [subViewsArr addObject:subView];
        }
    }
    if (imageView == subViewsArr[subViewsArr.count - 1]) {
        
    }else {
        for (UIView *subView in imageView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                subView.hidden = NO;
            }
        }
    }
}

//向scroller中添加图片
- (void)addPic:(NSArray *)picArr {
    //添加的图片的张数
    NSInteger picCount = picArr.count;
    //Scroller中原有的图片张数(包括相机图片)
    NSMutableArray *subViewsArr = [NSMutableArray array];
    for (UIImageView *subView in self.picScrollerView.subviews) {
        if (subView.alpha != 0) {
            [subViewsArr addObject:subView];
        }
    }
    
    UIImageView *addBeforeLastImageView = subViewsArr[subViewsArr.count - 1];

    for (NSInteger i = 0; i < picCount; i++) {
        UIImageView *picImageView = [[UIImageView alloc] init];
        picImageView.frame = CGRectMake(10 + (i + subViewsArr.count) * 50, 10, 40, 40);
        picImageView.userInteractionEnabled = YES;
        if (i == (picCount - 1)) {
            addBeforeLastImageView.image = [UIImage imageNamed:@"test"];
            picImageView.image = [UIImage imageNamed:@"home_door"];
        }else {
            picImageView.image = [UIImage imageNamed:@"test"];
        }
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(25, -15, 30, 30);
        [deleteBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deletePicAction:) forControlEvents:UIControlEventTouchDown];
        deleteBtn.hidden = YES;
        
        objc_setAssociatedObject(deleteBtn, PIC_DELETE_KEY, picImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [picImageView addSubview:deleteBtn];
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(picLongTap:)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picTap:)];
        
        [picImageView addGestureRecognizer:tap];
        [picImageView addGestureRecognizer:longTap];
        
        [self.picScrollerView addSubview:picImageView];
    }
    
    //设置超过范围是的Scroller的滚动区域
    NSMutableArray *afterSubViewsArr = [NSMutableArray array];
    for (UIImageView *subView in self.picScrollerView.subviews) {
        if (subView.alpha != 0) {
            [afterSubViewsArr addObject:subView];
        }
    }
    
    UIImageView *lastImageView = afterSubViewsArr[afterSubViewsArr.count - 1];
    if (lastImageView.right > SCREEN_WIDTH) {
        self.picScrollerView.contentSize = CGSizeMake(lastImageView.right + 10, 60);
    }
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)saveAction {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
