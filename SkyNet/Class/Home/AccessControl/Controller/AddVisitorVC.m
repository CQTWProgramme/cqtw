//
//  AddVisitorVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/10.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "AddVisitorVC.h"
#import "DataEntryImgPicCell.h"
#import "ACViewModel.h"
#import "PGDatePicker.h"
#import <MessageUI/MessageUI.h>
#import <UMSocialCore/UMSocialCore.h>

static NSString *imgCellID = @"AddVisitorVCImgCellID";

@interface AddVisitorVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PGDatePickerDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate> {
    MFMessageComposeViewController *_messageController;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseLabel;
@property (strong, nonatomic) IBOutlet UITextField *visitorNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *visitorNumTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITextField *markLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *picCollectionView;

@property (strong, nonatomic) IBOutlet UIView *backCoverView;
@property (strong, nonatomic) IBOutlet UIView *bottomMessageView;
@property (strong, nonatomic) IBOutlet UILabel *visitorPasswordLabel;
@property (strong, nonatomic) IBOutlet UILabel *openDoorHrefLabel;
@property (weak, nonatomic)MFMessageComposeViewController *picker;

@property (nonatomic, strong) NSMutableArray *imgDataArray;
@property (nonatomic, copy) NSString *facePhotos;
@property (nonatomic, strong)NSData *imgData;
@property (nonatomic, copy) NSString *cardNumId;
@end

@implementation AddVisitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.title=@"访客登记";
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSArray *timeDataArray = [currentDateStr componentsSeparatedByString:@" "];
    NSString *dateStr = timeDataArray[0];
    NSString *timeStr = timeDataArray[1];
    self.dateLabel.text = dateStr;
    self.timeLabel.text = timeStr;
    self.nameLabel.text = self.model.disName;
    self.houseLabel.text = self.model.houseName;
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupCollectionView];
}

-(NSMutableArray *)imgDataArray {
    if (nil == _imgDataArray) {
        _imgDataArray = [NSMutableArray array];
    }
    return _imgDataArray;
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *imgLayout = [[UICollectionViewFlowLayout alloc] init];
    imgLayout.itemSize = CGSizeMake(60, 60);
    imgLayout.minimumLineSpacing = 10;
    imgLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    imgLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.picCollectionView setCollectionViewLayout:imgLayout];
    self.picCollectionView.showsHorizontalScrollIndicator = NO;
    self.picCollectionView.backgroundColor = [UIColor clearColor];
    self.picCollectionView.delegate = self;
    self.picCollectionView.dataSource = self;
    
    [self.picCollectionView registerClass:[DataEntryImgPicCell class] forCellWithReuseIdentifier:imgCellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgDataArray.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf
        DataEntryImgPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgCellID forIndexPath:indexPath];
        if (indexPath.row == self.imgDataArray.count) {
            cell.isLast = YES;
        }else {
            cell.isLast = NO;
            cell.img = self.imgDataArray[indexPath.row];
        }
        cell.deleteImg = ^{
            [weakSelf.imgDataArray removeObjectAtIndex:indexPath.row];
            self.imgData = nil;
            [weakSelf.picCollectionView reloadData];
        };
        return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.imgDataArray.count) {
        if (self.imgDataArray.count >= 1) {
            [STTextHudTool showErrorText:@"目前只支持一张人脸照"];
            return;
        }else {
            
            [self chooseImage];
        }
    }
    
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
    self.imgData = [self zipImageWithImage:image];
    [self.imgDataArray addObject:image];
    [self.picCollectionView reloadData];
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

- (IBAction)submitAction:(id)sender {
    if ([self.visitorNameTextField.text isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请填写访客姓名"];
        return;
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *checkDateStr = [NSString stringWithFormat:@"%@ %@",self.dateLabel.text,self.timeLabel.text];
    NSDate *checkDate =[dateFormat dateFromString:checkDateStr];
    NSDate *now = [NSDate date];
    if ([now timeIntervalSinceDate:checkDate] > 0) {
        [STTextHudTool showErrorText:@"请选择合理的有效时间"];
        return;
    }
    if (![self.visitorNumTextField.text isEqualToString:@""]) {
        if (![self valiMobile:self.visitorNumTextField.text]) {
            [STTextHudTool showErrorText:@"请填写正确的电话号码"];
            return;
        }
    }
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSDictionary *dataDic = returnValue;
        self.visitorPasswordLabel.text = [NSString stringWithFormat:@"%@#",dataDic[@"temporaryPword"]];
        self.openDoorHrefLabel.text = dataDic[@"remoteConnection"];
        self.cardNumId = dataDic[@"cardnumId"];
        [self showViewAction];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    NSString *startTime = [dateFormat stringFromDate:now];
    NSString *endTime = [NSString stringWithFormat:@"%@ %@",self.dateLabel.text,self.timeLabel.text];
    [viewModel acCreateVisitorsWithAreasId:self.model.areasId name:self.visitorNameTextField.text phone:self.visitorNumTextField.text startTime:startTime endTime:endTime bz:self.markLabel.text facePicture:self.imgData];
}

- (IBAction)timeCheckAction:(id)sender {
    
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.datePickerMode = PGDatePickerModeTimeAndSecond;
    datePicker.minimumDate = [NSDate date];
}

- (IBAction)dateCheckAction:(id)sender {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.minimumDate = [NSDate date];
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if (datePicker.datePickerMode == PGDatePickerModeDate) {
        NSString *month = @"";
        NSString *day = @"";
        if ([dateComponents month] <= 9) {
            month = [NSString stringWithFormat:@"0%@",@([dateComponents month])];
        }else {
            month = [NSString stringWithFormat:@"%@",@([dateComponents month])];
        }
        if ([dateComponents day] <= 9) {
            day = [NSString stringWithFormat:@"0%@",@([dateComponents day])];
        }else {
            day = [NSString stringWithFormat:@"%@",@([dateComponents day])];
        }
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",@([dateComponents year]),month,day];
        self.dateLabel.text = dateStr;
    }else {
        NSString *hour = @"";
        NSString *minute = @"";
        NSString *second = @"";
        if ([dateComponents hour] <= 9) {
            hour = [NSString stringWithFormat:@"0%@",@([dateComponents hour])];
        }else {
            hour = [NSString stringWithFormat:@"%@",@([dateComponents hour])];
        }
        if ([dateComponents minute] <= 9) {
            minute = [NSString stringWithFormat:@"0%@",@([dateComponents minute])];
        }else {
            minute = [NSString stringWithFormat:@"%@",@([dateComponents minute])];
        }
        if ([dateComponents second] <= 9) {
            second = [NSString stringWithFormat:@"0%@",@([dateComponents second])];
        }else {
            second = [NSString stringWithFormat:@"%@",@([dateComponents second])];
        }
        NSString *timeStr = [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
        self.timeLabel.text = timeStr;
    }
}

- (BOOL)valiMobile:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    }else{
        /**
         
         * 移动号段正则表达式
         
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         
         * 联通号段正则表达式
         
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         
         * 电信号段正则表达式
         
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
    }
}

- (void)hideViewAction {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.bottomMessageView.layer addAnimation:animation forKey:nil];
    [self.backCoverView.layer addAnimation:animation forKey:nil];
    
    self.backCoverView.hidden = YES;
    self.bottomMessageView.hidden = YES;
}

- (void)showViewAction {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.bottomMessageView.layer addAnimation:animation forKey:nil];
    [self.backCoverView.layer addAnimation:animation forKey:nil];
    
    self.backCoverView.hidden = NO;
    self.bottomMessageView.hidden = NO;
}
//开门
- (IBAction)openDoorAction:(id)sender {
    
}

//微信分享
- (IBAction)wxShareAction:(id)sender {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString *thumbURL =  @"AppIcon";
    NSString *address = [NSString stringWithFormat:@"%@[%@]",self.model.disName,self.model.houseName];
    NSString *descr = [NSString stringWithFormat:@"[智能人脸门禁]分享开门信息给你,门禁访问密码：%@,远程开门地址：%@。使用以上授权信息可以打开以下门禁：%@",self.visitorPasswordLabel.text,@"https://city.cqtianwang.com/app/visitorsOpenDoor",address];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:descr thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@",self.openDoorHrefLabel.text];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            if([error.userInfo objectForKey:@"message"]) {
                [STTextHudTool showErrorText:[error.userInfo objectForKey:@"message"]];
            }
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                [STTextHudTool showSuccessText:resp.message];
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

//短信分享
- (IBAction)mgShareAction:(id)sender {
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //创建网页内容对象
//    NSString *thumbURL =  @"AppIcon";
//    NSString *address = [NSString stringWithFormat:@"%@[%@]",self.model.disName,self.model.houseName];
//    NSString *descr = [NSString stringWithFormat:@"[智能人脸门禁]分享开门信息给你,门禁访问密码：%@,远程开门地址：%@。使用以上授权信息可以打开以下门禁：%@",self.visitorPasswordLabel.text,self.openDoorHrefLabel.text,address];
//
//    UMShareSmsObject *shareObject = [[UMShareSmsObject alloc] init];
//    shareObject.smsContent = descr;
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sms messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            if([error.userInfo objectForKey:@"message"]) {
//                [STTextHudTool showErrorText:[error.userInfo objectForKey:@"message"]];
//            }
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                [STTextHudTool showSuccessText:resp.message];
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//    }];
    //用于判断是否有发送短信的功能（模拟器上就没有短信功能）
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    //有短信功能
    if ([messageClass canSendText]) {//发送短信
        //实例化MFMessageComposeViewController,并设置委托
        _messageController = [[MFMessageComposeViewController alloc] init];
        _messageController.messageComposeDelegate = self;
        _messageController.delegate = self;
        UINavigationItem *navigationItem = [[[_messageController viewControllers] lastObject] navigationItem];
        [navigationItem setTitle:@"开门密码分享"];
        
        UIButton* ButSign = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        [ButSign setTitle:@"取消" forState:UIControlStateNormal];
        ButSign.titleLabel.font = [UIFont systemFontOfSize:14];
        [ButSign setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [ButSign addTarget:self action:@selector(msgBackFun) forControlEvents:UIControlEventTouchUpInside];
        navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ButSign];
    
        //拼接并设置短信内容
        NSString *address = [NSString stringWithFormat:@"%@[%@]",self.model.disName,self.model.houseName];
        NSString *descr = [NSString stringWithFormat:@"[智能人脸门禁]分享开门信息给你,门禁访问密码：%@,远程开门地址：%@。使用以上授权信息可以打开以下门禁：%@",self.visitorPasswordLabel.text,self.openDoorHrefLabel.text,address];
        _messageController.body = descr;
        
        //推到发送试图控制器
        [self presentViewController:_messageController animated:YES completion:^{
            
        }];
    }else {
        [STTextHudTool showErrorText:@"该设备没有发送短信的功能~"];
    }
}

//发送短信后回调的方法
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSString *tipContent;
    switch (result) {
        case MessageComposeResultCancelled:
            tipContent = @"发送短信已取消";
            break;
        case MessageComposeResultFailed:
            tipContent = @"发送短信失败";
            break;
        case MessageComposeResultSent:
            tipContent = @"发送成功";
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        [STTextHudTool showErrorText:tipContent];
    }];
}

-(void)msgBackFun {
    [_messageController dismissViewControllerAnimated:YES completion:^{
        [STTextHudTool showErrorText:@"发送短信已取消"];
    }];
}

//back点击隐藏
- (IBAction)backCoverTap:(id)sender {
    [self hideViewAction];
}

@end
