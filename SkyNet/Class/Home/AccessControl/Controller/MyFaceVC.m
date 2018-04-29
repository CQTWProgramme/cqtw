//
//  MyFaceVC.m
//  SkyNet
//
//  Created by wqsjohnson on 2018/4/27.
//  Copyright © 2018年 xrg. All rights reserved.
//

#import "MyFaceVC.h"
#import "ACViewModel.h"

@interface MyFaceVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *qualityContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityEndLabel;
@property (strong, nonatomic) UIView *backCoverView;
@property (strong, nonatomic) UIView *noticeView;
@property (strong, nonatomic) NSTimer *noticeTimer;
@property (strong, nonatomic) UIButton *bottomButton;
@property (copy, nonatomic) NSString *featureId;
@end

@implementation MyFaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的人脸";
    [[UIApplication sharedApplication].keyWindow addSubview:self.backCoverView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.self.noticeView];
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self loadData];
}

-(UIView *)backCoverView {
    if (nil == _backCoverView) {
        _backCoverView = [[UIView alloc] init];
        _backCoverView.hidden = YES;
        _backCoverView.backgroundColor = [UIColor darkGrayColor];
        _backCoverView.alpha = 0.4;
        _backCoverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _backCoverView;
}

-(UIView *)noticeView {
    if (nil == _noticeView) {
        _noticeView = [[UIView alloc] init];
        _noticeView.hidden = YES;
        _noticeView.backgroundColor = [UIColor whiteColor];
        _noticeView.frame = CGRectMake(10, 80, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 160);
        _noticeView.layer.cornerRadius = 5;
        _noticeView.layer.masksToBounds = YES;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, _noticeView.width, 30);
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = @"正确的拍摄方式";
        [_noticeView addSubview:titleLabel];
        
        UIImageView *noticeImageView = [[UIImageView alloc] init];
        noticeImageView.frame = CGRectMake(0, 30, _noticeView.width, _noticeView.height - 150);
        noticeImageView.contentMode = UIViewContentModeCenter;
        noticeImageView.image = [UIImage imageNamed:@"face_example"];
        [_noticeView addSubview:noticeImageView];
        
        UILabel *bottomLabel = [[UILabel alloc] init];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.numberOfLines = 0;
        bottomLabel.font = [UIFont systemFontOfSize:13];
        bottomLabel.frame = CGRectMake(10, _noticeView.height - 120, _noticeView.width - 20, 40);
        bottomLabel.textColor = [UIColor lightGrayColor];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"在光线充足，纯色背景前关闭美颜功能后，按以上要求进行拍摄。"];
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(14, 4)];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(14, 4)];
        bottomLabel.attributedText = attrString;
        [_noticeView addSubview:bottomLabel];
        
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(10, _noticeView.height - 70, _noticeView.width - 20, 40);
        bottomButton.layer.cornerRadius = 5;
        bottomButton.layer.masksToBounds = YES;
        [bottomButton addTarget:self action:@selector(noticeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_noticeView addSubview:bottomButton];
        self.bottomButton = bottomButton;
    }
    return _noticeView;
}

-(void)loadData {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            double quality = [returnValue[@"data"][@"quality"] doubleValue];
            double minQuality = [returnValue[@"data"][@"minQuality"] doubleValue];
            NSString *facePicture = returnValue[@"data"][@"facepicture"];
            self.featureId = returnValue[@"data"][@"featureId"];
            self.qualityContentLabel.text = [NSString stringWithFormat:@"%@",@(quality)];
            [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:facePicture] placeholderImage:[UIImage imageNamed:@""]];
            if (quality < minQuality) {
                self.qualityEndLabel.text = @"(不符合标准)";
            }else {
                self.qualityEndLabel.text = @"(符合标准)";
            }
        }else {
            
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel acGetFaceImageData];
}

- (IBAction)updatePhotoAction:(id)sender {
    self.backCoverView.hidden = NO;
    self.noticeView.hidden = NO;
    self.noticeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(noticeTimeAction) userInfo:nil repeats:YES];
    [self.noticeTimer fire];
}

- (void)noticeBtnClick:(UIButton *)btn {
    self.backCoverView.hidden = YES;
    self.noticeView.hidden = YES;
    [self chooseImage];
}

- (void)noticeTimeAction {
    static NSInteger count = 5;
    if (count <= 0) {
        self.bottomButton.backgroundColor = [UIColor blueColor];
        self.bottomButton.userInteractionEnabled = YES;
        [self.bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bottomButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [self.noticeTimer invalidate];
        self.noticeTimer = nil;
        count = 6;
    }else {
        self.bottomButton.backgroundColor = [UIColor lightGrayColor];
        self.bottomButton.userInteractionEnabled = NO;
        [self.bottomButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        NSString *titleString = [NSString stringWithFormat:@"%@我知道了",@(count)];
        [self.bottomButton setTitle:titleString forState:UIControlStateNormal];
    }
    count--;
}

- (void)chooseImage {
    UIActionSheet *sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择",nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger sourceType = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                return;
            case 1:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
    }else {
        if (buttonIndex == 0) {
            return;
        }else if (buttonIndex == 1) {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
    imgPickerController.delegate = self;
    imgPickerController.allowsEditing = YES;
    imgPickerController.sourceType = sourceType;
    [self presentViewController:imgPickerController animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = [self zipImageWithImage:image];
    
    [self uploadFaceImageWithData:imgData type:1];
}

- (void)uploadFaceImageWithData:(NSData *)faceData type:(NSInteger)type {
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString * code=returnValue[@"code"];
        if (code.integerValue==1) {
            [STTextHudTool showErrorText:@"上传成功"];
            double quality = [returnValue[@"data"][@"quality"] doubleValue];
            double minQuality = [returnValue[@"data"][@"minQuality"] doubleValue];
            NSString *facePicture = returnValue[@"data"][@"facepicture"];
            self.featureId = returnValue[@"data"][@"featureId"];
            self.qualityContentLabel.text = [NSString stringWithFormat:@"%@",@(quality)];
            [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:facePicture] placeholderImage:[UIImage imageNamed:@""]];
            if (quality < minQuality) {
                self.qualityEndLabel.text = @"(不符合标准)";
            }else {
                self.qualityEndLabel.text = @"(符合标准)";
            }
        }else {
            [STTextHudTool showErrorText:returnValue[@"message"]];
        }
    } WithErrorBlock:^(id errorCode) {
        [STTextHudTool showErrorText:@"上传失败"];
    } WithFailureBlock:^{
        [STTextHudTool showErrorText:@"上传失败"];
    }];
    [viewModel uploadFaceImgWithFileImg:faceData featureId:self.featureId];
}

//压图片质量
- (NSData *)zipImageWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = 1024*1024;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
    }
    return compressedData;
}

//等比缩放图片大小
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(void)dealloc {
    [self.backCoverView removeFromSuperview];
    [self.noticeView removeFromSuperview];
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
