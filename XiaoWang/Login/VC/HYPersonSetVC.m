//
//  HYPersonSetVC.m
//  hangyeshejiao
//
//  Created by blaceman on 2018/4/17.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYPersonSetVC.h"
#import "FGCellStyleView.h"
#import "FGPlaceholderTextView.h"
#import "FGCacheManager.h"
#import "FGImagePickerVC.h"
#import "FGPickerView.h"
#import "FGAliyunOSSManager.h"
#import <NSAttributedString+YYText.h>
#import <BRPickerView.h>
#import "XWLabelVC.h"

@interface HYPersonSetVC ()
@property (nonatomic,strong)UIButton *avaterButton;
@property (nonatomic,strong)UIView *avaterBackground;

@property (nonatomic, strong) FGImagePickerVC *singleImagePickerVC;///< 单选照片器
@property (nonatomic,strong)NSArray<UIImage *> *photos; //图片数据源
@property (nonatomic, assign) BOOL isChangeAvatar;  ///< <#Description#>

@property (nonatomic,strong)NSString *avatar;
@end

@implementation HYPersonSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnaviView];
    [self setHeadAvater];
    [self setBodyView];
}
-(void)setupViews{
    
}
-(void)setHeadAvater{
   
    UIView *avaterBackground = [UIView new];
    self.avaterBackground = avaterBackground;
    avaterBackground.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView.contentView addSubview:avaterBackground];
    [avaterBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(AdaptedHeight(11));
        make.height.mas_equalTo(AdaptedHeight(88));
        
    }];
    [avaterBackground addBottomLine];
    
    self.avaterButton = [UIButton fg_imageString:@"icon_head1" imageStringSelected:@"icon_head1"];
    [self.avaterButton setImageWithURL:[NSURL URLWithString:[FGCacheManager sharedInstance].userModel.avatar] forState:UIControlStateNormal placeholder:UIImageWithName(@"icon_head1")];
    self.avaterButton.userInteractionEnabled = NO;
    [self.bgScrollView.contentView addSubview:self.avaterButton];
    [self.avaterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avaterBackground);
        make.left.equalTo(avaterBackground).offset(AdaptedWidth(70));

        make.height.width.mas_equalTo(AdaptedWidth(63));
    }];
    self.avaterButton.layer.cornerRadius = AdaptedWidth(63 / 2.0);
    self.avaterButton.layer.masksToBounds = YES;

    
        UIButton *bigButton = [UIButton fg_imageString:@"icon_more" imageStringSelected:@"icon_more"];

        
        [self.bgScrollView.contentView addSubview:bigButton];
        [bigButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avaterBackground);
            make.right.equalTo(avaterBackground).offset(AdaptedHeight(-19));
        }];
        
    UILabel *leftLabel = [UILabel fg_text:@"头像" fontSize:16 colorHex:0x333333];
    [self.bgScrollView.contentView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avaterBackground);
        make.left.offset(AdaptedWidth(23));
    }];
    
    WeakSelf
    [avaterBackground jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        StrongSelf
        [self selectAvater];
    }];
    
}
-(void)setnaviView{
    [self.navigationView setTitle:@"个人资料"];
    WeakSelf

}


-(void)setBodyView{
    NSArray *titleArr = @[@"昵称",@"性别",@"生日",@"地区"];
    
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftTitle = titleArr[i];
//        model.margin = AdaptedWidth(0);
        model.alignment = NSTextAlignmentLeft;
        model.leftTitleColor = UIColorFromHex(0x333333);
        model.contentColor = UIColorFromHex(0x666666);
        model.leftImgPathMargin = AdaptedWidth(23);
        model.placeholder = @"未设置";
        if (![titleArr[i] isEqualToString:@"昵称"]) {
            model.rightImgPath = @"icon_more";

        }
        if ([titleArr[i] isEqualToString:@"生日"]) {
            model.placeholder = @"请选择出生年月（选填）";
            model.content = [FGCacheManager sharedInstance].userModel.birthday;
        }else if ([titleArr[i] isEqualToString:@"地区"]){
            model.content = [FGCacheManager sharedInstance].userModel.city_id.stringValue;
        }else if ([titleArr[i] isEqualToString:@"昵称"]){
            model.content = [FGCacheManager sharedInstance].userModel.nickname;
        }else if ([titleArr[i] isEqualToString:@"性别"]){
            model.content = [FGCacheManager sharedInstance].userModel.gender.integerValue == 20 ? @"男" : @"女";
        }
        
        
        FGCellStyleView *cell = [[FGCellStyleView alloc] initWithModel:model];
        cell.tag = i + 1;
        [cell addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(16), 0, 0)];
        [self.bgScrollView.contentView addSubview:cell];
        [cell addTarget:self action:@selector(itemAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [cell setTouchDownTarget:self action:@selector(itemAction:)];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgScrollView.contentView);
            if (i == 0) {
                make.top.equalTo(self.avaterBackground .mas_bottom).offset(AdaptedHeight(0));
            }else{
                
                make.top.equalTo(bufferCell.mas_bottom).offset(i == 5 ? 11 : 0);
            }
            make.height.mas_equalTo(AdaptedHeight(63));
            if (i == titleArr.count - 1) {
//                make.bottom.equalTo(self.bgScrollView.contentView).offset(-AdaptedHeight(140));
            }
        }];
        
        bufferCell = cell;
    }
    
    
    UIButton *bottomView = [UIButton fg_title:@"完成注册" fontSize:16 titleColorHex:0x000000];
    bottomView.backgroundColor = UIColorFromHex(0xFFE616);
    [bottomView fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    [self.bgScrollView.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(45));
        make.right.offset(AdaptedWidth(-45));

        make.top.equalTo(bufferCell.mas_bottom).offset(AdaptedHeight(52));
        make.height.mas_equalTo(AdaptedHeight(40));
    }];
    
    [bottomView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self updateAvaterInfo];
        
    }];
    
    
    NSMutableAttributedString *protocolString = [[NSMutableAttributedString alloc] initWithString:@"注册即代表我同意《用户协议》"];
    [protocolString setColor:UIColorFromHex(0x808080) range:NSMakeRange(0, 8)];
    [protocolString setColor:UIColorFromHex(0x419AFF) range:NSMakeRange(8, protocolString.length - 8)];
    [protocolString setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(8, protocolString.length - 8)];
    
    UIButton *protocolBtn = [UIButton fg_title:@"" fontSize:13 titleColorHex:0x666666];
    [self.bgScrollView.contentView addSubview:protocolBtn];
    
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bottomView.mas_bottom).offset(AdaptedHeight(24));
        make.bottom.offset(AdaptedHeight(-13));
    }];
    [protocolBtn setAttributedTitle:protocolString forState:UIControlStateNormal];
    
    
    self.bgScrollView.backgroundColor = UIColorFromHex(0xffffff);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemAction:(FGCellStyleView *)view{
    [self.view endEditing:YES];
    if ([view.model.leftTitle isEqualToString:@"地区"]) {
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@"广东省", @"广州市", @"海珠区"] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            view.model.content = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        }];
    }else if ([view.model.leftTitle isEqualToString:@"生日"]){
        
        [BRDatePickerView showDatePickerWithTitle:@"生日选择" dateType:BRDatePickerModeDate defaultSelValue:nil resultBlock:^(NSString *selectValue) {
            view.model.content = selectValue;
        }];
    }else if ([view.model.leftTitle isEqualToString:@"性别"]){
        [BRStringPickerView showStringPickerWithTitle:@"性别选择" dataSource:@[@"男",@"女"] defaultSelValue:@"男" resultBlock:^(id selectValue) {
            view.model.content = selectValue;
        }];
        
    }
    
}

- (void)selectAvater{
    WeakSelf
    UIAlertController *alVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf
        [self.singleImagePickerVC takePhoto];
    }]];
    [alVC addAction:[UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf
        [self.singleImagePickerVC pushTZImagePickerController];
    }]];
    [self presentViewController:alVC animated:YES completion:nil];
    
    self.singleImagePickerVC.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        StrongSelf
        self.photos = photos;
        [self.avaterButton setImage:photos.firstObject forState:(UIControlStateNormal)];
        self.isChangeAvatar = YES;

        
    };
}
- (FGImagePickerVC *)singleImagePickerVC{
    if (!_singleImagePickerVC) {
        _singleImagePickerVC = [FGImagePickerVC new];
        _singleImagePickerVC.columnNumberTF = 4;
        _singleImagePickerVC.maxCountTF = 1;
        _singleImagePickerVC.allowPickingImageSwitch = YES;
        _singleImagePickerVC.allowPickingOriginalPhotoSwitch = YES;
        _singleImagePickerVC.allowCropSwitch = YES;
        // 设置竖屏下的裁剪尺寸
        _singleImagePickerVC.cropRect = CGRectMake(0, (kScreenHeight - kScreenWidth)/2, kScreenWidth, kScreenWidth);
        [self addChildViewController:_singleImagePickerVC];
        _singleImagePickerVC.view.backgroundColor = [UIColor whiteColor];
    }
    
    return _singleImagePickerVC;
}


-(void)updateAvaterInfo{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    //是否修改了头像
    if (self.isChangeAvatar) {
        //上传头像
        [self showLoadingHUDWithMessage:@"上传头像..."];
        NSData *imageData = UIImageJPEGRepresentation(self.photos.firstObject, 1);
        WeakSelf
        [[FGAliyunOSSManager sharedInstance] uploadImageAsyncWithBucket:nil mimeType:@"jpg" data:imageData progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            //            StrongSelf
        } success:^(NSString *absoluteUrlString) {
            StrongSelf
            //取得图片在阿里云的路径
            onMainThreadAsync(^{
                StrongSelf
                [self hideLoadingHUD];
                self.avatar = [NSString stringWithFormat:@"%@/%@",OSS_DIMAO,absoluteUrlString];
                [self updateUserInfo];
            });
            
        } failure:^(NSString *msg) {
            StrongSelf
            DLog(@"上传图片失败");
            onMainThreadAsync(^{
                StrongSelf
                [self showWarningHUDWithMessage:msg completion:nil];
            });
        }];
    }else{
//        [self updateUserInfoWithDic:[NSMutableDictionary new]];
        [self updateUserInfo];
    }
}


-(void)updateUserInfo{
//    @[@"昵称",@"性别",@"生日",@"地区"]
    
    NSString *nickname = ((FGCellStyleView *)[self.bgScrollView.contentView viewWithTag:1]).model.content;
    NSString *gender = ((FGCellStyleView *)[self.bgScrollView.contentView viewWithTag:2]).model.content;
    NSString *birthday = ((FGCellStyleView *)[self.bgScrollView.contentView viewWithTag:3]).model.content;
    NSString *city_id = ((FGCellStyleView *)[self.bgScrollView.contentView viewWithTag:4]).model.content;
    NSString *avatar = self.avatar;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (nickname) {
        dic[@"nickname"] = nickname;
    }
    if (gender){
        dic[@"gender"] = [gender isEqualToString:@"男"] ? @20 : @30;
    }
    if (birthday){
        dic[@"birthday"] = birthday;
    }
    if (city_id){
        dic[@"city_id"] = @20;
    }
    if (avatar){
        dic[@"avatar"] = avatar;
    }
    
    [FGHttpManager putWithPath:@"api/profile/set_profile" parameters:dic success:^(id responseObject) {
        FGUserModel *loginModel = [FGUserModel modelWithJSON:responseObject];
        [FGCacheManager sharedInstance].userModel = loginModel;
        XWLabelVC *vc = [XWLabelVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error];
    }];
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
