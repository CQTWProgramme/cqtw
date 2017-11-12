//
//  DataEntryVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/10/22.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "DataEntryVC.h"
#import "DataEntryIdCardCell.h"
#import "DataEntryImgPicCell.h"
#import "IDImagePickModel.h"
#import "ACViewModel.h"
#import "CertificateInfoModel.h"

static NSString *idCardCellID = @"DataEntryVCIdCardCellID";
static NSString *imgCellID = @"DataEntryVCImgCellID";

//照片选择枚举
typedef NS_ENUM(NSInteger, ImagePickType) {
    //身份证正面照
    IDCardFirstType,
    //身份证背面照
    IDCardSecondType,
    //人脸照
    FaceImageType
};

@interface DataEntryVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *backScroller;
@property (strong, nonatomic) IBOutlet UICollectionView *idCardCollectionView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *IdNumTextField;
@property (strong, nonatomic) IBOutlet UICollectionView *imgCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *certificateTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *minzuLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthLabel;
@property (assign, nonatomic) ImagePickType imagePickType;
@property (strong, nonatomic) CertificateInfoModel *infoModel;

@property (copy, nonatomic)NSString *idCardPage;
@property (copy, nonatomic)NSString *idCardPage1;
@property (copy, nonatomic)NSString *facePhotos;

@property (strong, nonatomic) IBOutlet UITextField *addressLabel;
@property (strong, nonatomic) NSMutableArray *imgDataArray;
@property (strong, nonatomic) NSMutableArray *idDataArray;

@end

@implementation DataEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.facePhotos = @"";
    self.idCardPage1 = @"";
    self.idCardPage = @"";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"实名认证";
    [self createRightItem];
    [self setupCollection];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setupScrollerContentSize];
}

-(NSMutableArray *)imgDataArray {
    if (nil == _imgDataArray) {
        _imgDataArray = [NSMutableArray array];
    }
    return _imgDataArray;
}

-(NSMutableArray *)idDataArray {
    if (nil == _idDataArray) {
        IDImagePickModel *model1 = [[IDImagePickModel alloc] init];
        model1.content = @"身份证人像页";
        model1.pickImg = nil;
        model1.isEmpty = YES;
        IDImagePickModel *model2 = [[IDImagePickModel alloc] init];
        model2.content = @"身份证国徽页";
        model2.pickImg = nil;
        model2.isEmpty = YES;
        _idDataArray = [NSMutableArray array];
        [_idDataArray addObject:model1];
        [_idDataArray addObject:model2];
    }
    return _idDataArray;
}
//设置scoller滚动范围
- (void)setupScrollerContentSize {
    self.backScroller.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

//重置collectionView
- (void)setupCollection {
    UICollectionViewFlowLayout *idCardLayout = [[UICollectionViewFlowLayout alloc] init];
    idCardLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 30) / 2, 110);
    idCardLayout.minimumLineSpacing = 10;
    idCardLayout.sectionInset = UIEdgeInsetsMake(15, 10, 25, 10);
    idCardLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionViewFlowLayout *imgLayout = [[UICollectionViewFlowLayout alloc] init];
    imgLayout.itemSize = CGSizeMake(60, 60);
    imgLayout.minimumLineSpacing = 10;
    imgLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    imgLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.idCardCollectionView setCollectionViewLayout:idCardLayout];
    self.idCardCollectionView.showsHorizontalScrollIndicator = NO;
    self.idCardCollectionView.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
    self.idCardCollectionView.delegate = self;
    self.idCardCollectionView.dataSource = self;
    
    [self.imgCollectionView setCollectionViewLayout:imgLayout];
    self.imgCollectionView.showsHorizontalScrollIndicator = NO;
    self.imgCollectionView.backgroundColor = [UIColor clearColor];
    self.imgCollectionView.delegate = self;
    self.imgCollectionView.dataSource = self;
    
    [self.idCardCollectionView registerClass:[DataEntryIdCardCell class] forCellWithReuseIdentifier:idCardCellID];
    [self.imgCollectionView registerClass:[DataEntryImgPicCell class] forCellWithReuseIdentifier:imgCellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.idCardCollectionView) {
        return self.idDataArray.count;
    }else if (collectionView == self.imgCollectionView) {
        return self.imgDataArray.count + 1;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf
    if (collectionView == self.idCardCollectionView) {
        DataEntryIdCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idCardCellID forIndexPath:indexPath];
        IDImagePickModel *model = self.idDataArray[indexPath.row];
        cell.model = model;
        
        cell.deleteImg = ^{
            model.isEmpty = YES;
            model.pickImg = nil;
            if (indexPath.row == 0) {
                self.idCardPage = @"";
                [self resetViewData];
            }else if (indexPath.row == 1) {
                self.idCardPage1 = @"";
            }
            [weakSelf.idCardCollectionView reloadData];
        };
        return cell;
    }else if (collectionView == self.imgCollectionView) {
        DataEntryImgPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgCellID forIndexPath:indexPath];
        if (indexPath.row == self.imgDataArray.count) {
            cell.isLast = YES;
        }else {
            cell.isLast = NO;
            cell.img = self.imgDataArray[indexPath.row];
        }
        
        cell.deleteImg = ^{
            [weakSelf.imgDataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.imgCollectionView reloadData];
            weakSelf.facePhotos = @"";
        };
        return cell;
    }
    return nil;
}

- (void)resetViewData {
    self.nameTextField.text = @"";
    self.minzuLabel.text = @"民族";
    self.sexLabel.text = @"性别";
    self.IdNumTextField.text = @"";
    self.birthLabel.text = @"出生年月";
    self.addressLabel.text = @"";
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (collectionView == self.imgCollectionView) {
        if (indexPath.row == self.imgDataArray.count) {
            if (self.imgDataArray.count >= 1) {
                [STTextHudTool showErrorText:@"人脸照片已选取"];
                return;
            }else {
                if ([self.nameTextField.text isEqualToString:@""]) {
                    [STTextHudTool showErrorText:@"请先选择身份证获取信息"];
                    return;
                }else {
                    self.imagePickType = FaceImageType;
                    [self chooseImage];
                }
            }
        }
    }else if (collectionView == self.idCardCollectionView) {
        IDImagePickModel *model = self.idDataArray[indexPath.row];
        if (!model.isEmpty) {
            [STTextHudTool showErrorText:@"身份证照片已选取"];
            return;
        }else {
            if (indexPath.row == 0) {
                self.imagePickType = IDCardFirstType;
            }else if (indexPath.row == 1) {
                if ([self.idCardPage isEqualToString:@""]) {
                    [STTextHudTool showErrorText:@"请先选择正面照片获取信息"];
                    return;
                }
                self.imagePickType = IDCardSecondType;
            }
            [self chooseImage];
        }
    }
}

-(void)createRightItem{
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0,0,25,25);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
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
    if (self.imagePickType == IDCardFirstType) {
        [self getInfoDataWithImageData:imgData withImg:image];
    }else {
        [self uploadImageByType:self.imagePickType withData:imgData withImage:image];
    }
}

//根据身份证正面照获取用户信息
- (void)getInfoDataWithImageData:(NSData *)imgData withImg:(UIImage *)image{
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        self.infoModel = returnValue;
        [self uploadImageByType:self.imagePickType withData:imgData withImage:image];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel getMessageWithFileImg:imgData];
}

//设置用户信息
- (void)setupInfoData {
    self.nameTextField.text = self.infoModel.name;
    self.sexLabel.text = self.infoModel.sex;
    self.IdNumTextField.text = self.infoModel.num;
    self.birthLabel.text = self.infoModel.birth;
    self.minzuLabel.text = self.infoModel.nationality;
    self.addressLabel.text = self.infoModel.address;
}

//上传图片
- (void)uploadImageByType:(ImagePickType )type withData:(NSData *)imgData withImage:(UIImage *)image{

    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [self setImageByType:type withImg:image];
        if (self.imagePickType == IDCardFirstType) {
            self.idCardPage = returnValue;
            [self setupInfoData];
        }else if (self.imagePickType == IDCardSecondType) {
            self.idCardPage1 = returnValue;
        }else if (self.imagePickType == FaceImageType) {
            self.facePhotos = returnValue;
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    if (self.imagePickType == IDCardFirstType) {
        [viewModel uploadImgWithFileImg:imgData type:1 idCardNumber:self.infoModel.num];
    }else if (self.imagePickType == IDCardSecondType) {
        [viewModel uploadImgWithFileImg:imgData type:2 idCardNumber:self.infoModel.num];
    }else if (self.imagePickType == FaceImageType) {
        [viewModel uploadImgWithFileImg:imgData type:4 idCardNumber:self.infoModel.num];
    }
    
}

//设置图片
- (void)setImageByType:(ImagePickType )type withImg:(UIImage *)img{
    if (self.imagePickType == IDCardFirstType) {
        IDImagePickModel *model = self.idDataArray[0];
        model.pickImg = img;
        model.isEmpty = NO;
        [self.idCardCollectionView reloadData];
    }else if (self.imagePickType == IDCardSecondType) {
        IDImagePickModel *model = self.idDataArray[1];
        model.pickImg = img;
        model.isEmpty = NO;
        [self.idCardCollectionView reloadData];
    }else if (self.imagePickType == FaceImageType) {
        [self.imgDataArray addObject:img];
        [self.imgCollectionView reloadData];
    }
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

-(void)rightButtonAction {
    
}

//提交
- (IBAction)submitAction:(id)sender {
    if ([self.idCardPage1 isEqualToString:@""] || [self.idCardPage isEqualToString:@""]) {
        [STTextHudTool showErrorText:@"请先选择照片获取相关信息"];
        return;
    }
    
    ACViewModel *viewModel = [ACViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        NSString *code = returnValue;
        if (code.integerValue==1) {
            [STTextHudTool showErrorText:@"信息提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [STTextHudTool showErrorText:@"信息提交失败"];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [viewModel certificationConfirmWithName:self.nameTextField.text sex:self.sexLabel.text peoples:self.minzuLabel.text birth:self.birthLabel.text address:self.addressLabel.text idCardNumber:self.IdNumTextField.text cardType:@"0" idCardPage:self.idCardPage idCardPage1:self.idCardPage1 lifePhoto:@"" facePhotos:self.facePhotos];
}

@end
