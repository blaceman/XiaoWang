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

@property (nonatomic, strong) NSString *photos;  ///< <#Description#>
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
    self.photos = @"";
    
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        __block BOOL uplodImage = YES;

        for (UIImage *image in self.images) {
            if (uplodImage) {
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                [[FGAliyunOSSManager sharedInstance] uploadImageAsyncWithBucket:nil mimeType:@"jpg" data:imageData progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                } success:^(NSString *absoluteUrlString) {
                    //取得图片在阿里云的路径
                    if ([self.photos isEqualToString:@""]) {
                        self.photos = absoluteUrlString;
                    }else{
                        self.photos = [NSString stringWithFormat:@"%@,%@",self.photos,absoluteUrlString];
                    }
                    
                    dispatch_semaphore_signal(semaphore);

                } failure:^(NSString *msg) {
                    uplodImage = NO;
                    dispatch_semaphore_signal(semaphore);
                    [self hideLoadingHUD];

                }];
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        if (uplodImage == NO) {
            [self showTextHUDWithMessage:@"图片上传失败啦"];
            self.isRequestLock = NO;
            return;
        }
        [[RACScheduler mainThreadScheduler] schedule:^{
            [self postAlbum];
        }];
       
       
    });
}

#pragma mark -- pravateMethod
-(void)postAlbum{
    [FGHttpManager postWithPath:@"api/photo/add" parameters:@{@"photos":self.photos,@"content":self.publishTextView.text} success:^(id responseObject) {
        [self showCompletionHUDWithMessage:@"发布完成" completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSString *error) {
        
    }];
}



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
    
    imagePickerVC.maxCountTF = 9;
    
    
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
