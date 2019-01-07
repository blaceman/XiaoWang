//
//  HYDynamicViewController.m
//  hangyeshejiao
//
//  Created by blaceman on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYDynamicViewController.h"
#import "FGImagePickerVC.h"
#import "UIViewController+FGToast.h"
#import "FGAliyunOSSManager.h"

@interface HYDynamicViewController ()

@property (nonatomic, strong) UITextView *publishTextView;  ///< <#Description#>
@property (nonatomic,strong)UIImageView *avaterImg;

@property (nonatomic,strong)FGImagePickerVC *imagePickerVC; ///> 图片选择
@property (nonatomic, strong) NSArray *images;  ///< 上传的图片数组
@property (nonatomic, assign) BOOL isRequestLock;  ///< 锁住导航栏右侧按钮,防止网络请求时重复点击

@end

@implementation HYDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromHex(0xffffff);
    [self.navigationView setTitle:@"动态"];
    WeakSelf
    [self.navigationView addRightButtonWithTitle:@"发布" clickCallBack:^(UIView *view) {
        StrongSelf
        [self publishMethod];
    }];
    
//    [self setPublishView];
    [self publishTextViewSet];
    [self pickViewSet];
    
    [self.publishTextView becomeFirstResponder];
}


#pragma mark -  发布方法

- (void)publishMethod
{
    if (self.isRequestLock) {
        return;
    }
    
    WeakSelf
    if (self.publishTextView.text.length <= 0) {
        [self showTextHUDWithMessage:@"请填写描述"];
        return;
    }
    
    [self showLoadingHUDWithMessage:nil];
    
    self.isRequestLock = YES;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableArray *urls = [NSMutableArray array];
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        __block BOOL uplodImage = YES;
//
//        for (UIImage *image in self.images) {
//            if (uplodImage) {
//                NSData *imageData = UIImageJPEGRepresentation(image, 1);
//                [[FGAliyunOSSManager sharedInstance] uploadImageAsyncWithBucket:nil mimeType:@"jpg" data:imageData progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//                } success:^(NSString *absoluteUrlString) {
//                    //取得图片在阿里云的路径
//
//                    NSMutableDictionary *dict = [NSMutableDictionary new];
//                    dict[@"uri"] = absoluteUrlString;
//                    dict[@"type"] = @0;
//
//                    [urls addObject:dict];
//                    dispatch_semaphore_signal(semaphore);
//
//                } failure:^(NSString *msg) {
//                    uplodImage = NO;
//                    dispatch_semaphore_signal(semaphore);
//                    [self hideLoadingHUD];
//
//                }];
//            }
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        }
//        if (uplodImage == NO) {
//            [self showTextHUDWithMessage:@"图片上传失败啦"];
//            self.isRequestLock = NO;
//            return;
//        }
//
//        [self postArticle:urls];
//    });
}

#pragma mark -- pravateMethod
//- (void)postArticle:(NSArray *)images{
//
//    NSMutableDictionary *param = [HYUtil blogParameter];
//    param[@"userId"] = kUserId;
//    param[@"content"] = self.publishTextView.text;
//    param[@"medias"] = images;
//
//    WeakSelf
//    [[HYNetworkManager sharedInstance].blog postBlogsWithParameter:param success:^(id result) {
//        self.isRequestLock = NO;
//        [self showCompletionHUDWithMessage:@"发布成功" completion:^{
//            StrongSelf
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//
//    } failure:^(NSString *msg) {
//        self.isRequestLock = NO;
//        [self showWarningHUDWithMessage:msg completion:nil];
//    }];
//}

//-(void)setPublishView{
//    UIImageView *avaterImg = [UIImageView fg_imageString:@"ic_default_avatar"];
//    self.avaterImg = avaterImg;
//    [self.avaterImg sd_setImageWithURL:[NSURL URLWithString:[FGCacheManager sharedInstance].userModel.avatarFull] placeholderImage:UIImageWithName(@"ic_default_avatar")];
//    [self.avaterImg fg_cornerRadius:AdaptedWidth(54)/2 borderWidth:0 borderColor:0];
//    [self.bgScrollView.contentView addSubview:avaterImg];
//    [avaterImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(AdaptedWidth(13));
//        make.top.equalTo(self.navigationView.mas_bottom).offset(AdaptedHeight(17));
//        make.width.height.mas_equalTo(AdaptedWidth(54));
//    }];
//
//    UILabel *publishLabel = [UILabel fg_text:@"发布人:" fontSize:15 colorHex:0x949494];
//    [self.bgScrollView.contentView addSubview:publishLabel];
//    [publishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(avaterImg).offset(2);
//        make.left.equalTo(avaterImg.mas_right).offset(AdaptedWidth(13));
//    }];
//
//    UILabel *publishNameLabel = [UILabel fg_text:[FGCacheManager sharedInstance].userModel.nickName fontSize:17 colorHex:0x000000];
//    [self.bgScrollView.contentView addSubview:publishNameLabel];
//    [publishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(publishLabel);
//        make.bottom.equalTo(avaterImg.mas_bottom).offset(-2);
//    }];
//
//}

-(void)publishTextViewSet{
    self.publishTextView = [[UITextView alloc]init];
    self.publishTextView.backgroundColor = [UIColor clearColor];
    [self.bgScrollView.contentView addSubview:self.publishTextView];
    self.publishTextView.font = AdaptedFontSize(16);
    [self.publishTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(16));
        make.top.offset(AdaptedHeight(0));
        make.right.offset(AdaptedWidth(-16));
        make.height.mas_equalTo(AdaptedHeight(120));
    }];
    
    
    UILabel *placehoderLabel = [UILabel fg_text:@"动态描述..." fontSize:16 colorHex:0xaaaaaa];
    [self.bgScrollView.contentView addSubview:placehoderLabel];
    
    [placehoderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.publishTextView).offset(AdaptedWidth(11));
        make.top.equalTo(self.publishTextView).offset(AdaptedHeight(8));
    }];
    
    [self.publishTextView.rac_textSignal  subscribeNext:^(NSString * _Nullable x) {
        if (x.length > 0) {
            placehoderLabel.hidden = YES;
        }else{
            placehoderLabel.hidden = NO;
        }
    }];
}

-(void)pickViewSet{
    WeakSelf
    FGImagePickerVC *imagePickerVC = [FGImagePickerVC new];
    self.imagePickerVC = imagePickerVC;
    imagePickerVC.columnNumberTF = 4;
    imagePickerVC.allowPickingImageSwitch = YES;
    imagePickerVC.allowPickingOriginalPhotoSwitch = NO;
    imagePickerVC.showTakePhotoBtnSwitch = YES;
    imagePickerVC.addBtnImgPath = @"icon_addpic";
//    imagePickerVC.itemWH = AdaptedWidth(104);
    imagePickerVC.columnNumberTF = 3;
    
    [self addChildViewController:imagePickerVC];
    [self.bgScrollView.contentView addSubview:imagePickerVC.view];
    
    imagePickerVC.maxCountTF = 4;
    
    
    [imagePickerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishTextView.mas_bottom).offset(AdaptedHeight(8));
        make.left.offset(AdaptedWidth(16));
        make.width.offset(AdaptedWidth(104 * 3 + 10 * 6));
        make.bottom.offset(0).priorityLow();
    }];
    
    imagePickerVC.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        StrongSelf
        self.images = photos;
    };
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
