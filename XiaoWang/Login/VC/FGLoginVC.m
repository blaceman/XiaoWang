//
//  FGLoginVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "FGLoginVC.h"
#import "FGCellStyleView.h"
#import <JKCategories/NSString+JKNormalRegex.h>
#import <JKCategories/NSString+JKHash.h>
#import "UIView+EdgeLine.h"

#import "FGRegisterVC.h"
#import "FGForgetPasswordVC.h"

@interface FGLoginVC ()

@property (nonatomic, strong) FGCellStyleView *mobileView; ///< 手机号
@property (nonatomic, strong) FGCellStyleView *pswView; ///< 密码
@property (nonatomic, strong) UIButton *forgetPsdBtn; ///< 忘记密码
@property (nonatomic, strong) UIButton *loginBtn; ///< 登录
@property (nonatomic, strong) UIButton *registerBtn; ///< 注册

@end

@implementation FGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    FGTextFeidViewModel *model1 = [FGTextFeidViewModel new];
    model1.leftTitle = @"手机号";
    model1.limitNum = 11;
    model1.keyboardType = UIKeyboardTypePhonePad;
    model1.contentMargin = AdaptedWidth(25);
    model1.leftImgPathMargin = 0;
    model1.placeholder = @"请输入11位手机号";
    model1.contentFont = 18;
    self.mobileView = [[FGCellStyleView alloc] initWithModel:model1];
    [self.mobileView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.mobileView];
    
    FGTextFeidViewModel *model2 = [FGTextFeidViewModel new];
    model2.placeholder = @"请输入6-18位密码";
    model2.leftTitle = @"密    码";
    model2.contentMargin = AdaptedWidth(25);
    model2.leftImgPathMargin = 0;
    model2.secureTextEntry = YES;
    model2.limitNum = 18;
    model2.contentFont = 18;
    self.pswView = [[FGCellStyleView alloc] initWithModel:model2];
    [self.pswView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView  addSubview:self.pswView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setImage:UIImageWithName(@"btn_sign_in_yellow_2") forState:UIControlStateNormal];
    [self.loginBtn setImage:UIImageWithName(@"btn_sign_in_yellow_1") forState:UIControlStateDisabled];
    [self.bgScrollView.contentView addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPsdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetPsdBtn setTitleColor:UIColorFromHex(0x949494) forState:UIControlStateNormal];
    self.forgetPsdBtn.titleLabel.font = AdaptedFontSize(15);
    [self.bgScrollView.contentView addSubview:self.forgetPsdBtn];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setTitle:@"新用户注册 >" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = AdaptedFontSize(17);
    [self.bgScrollView.contentView addSubview:self.registerBtn];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    RAC(self.loginBtn,enabled) = [[RACSignal combineLatest:@[[self.mobileView.textFeild rac_textSignal] ,[self.pswView.textFeild rac_textSignal]]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSString *tel , NSString *pwd ) = value;
        return @(tel.length > 0 && pwd.length > 5);
    }];
}

- (void)setupLayout
{
    UILabel *label = [UILabel fg_text:@"欢迎登录" fontSize:23 colorHex:0x333333];
    [self.bgScrollView.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(45));
        make.left.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(34));
    }];
    
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(AdaptedHeight(30));
        make.left.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(28));
        make.right.equalTo(self.bgScrollView.contentView ).offset(-AdaptedWidth(34));
        make.height.mas_equalTo(AdaptedHeight(52));
    }];
    
    [self.pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom).offset(AdaptedHeight(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(86));
        make.centerX.equalTo(self.bgScrollView.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(355), AdaptedWidth(60)));
    }];
    
    [self.forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pswView);
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(24));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgScrollView.contentView.mas_centerX);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(AdaptedWidth(20));
        make.bottom.offset(0);
    }];
    

}

#pragma mark - action

- (void)loginAction
{
    [self.view endEditing:YES];
    NSString *mobile = self.mobileView.model.content;
    NSString *password = self.pswView.model.content;
    
    if (![mobile jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }else if (password.length < 6) {
        [self showWarningHUDWithMessage:@"密码不能小于6位" completion:nil];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"username"] = mobile;
    dic[@"password"] = [password jk_md5String];
    
    [self showCompletionHUDWithMessage:@"登录成功" completion:^{
        [FGCacheManager sharedInstance].token = @"fdsafsafsaffdsaf";
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
   
    
    WeakSelf
//    [FGHttpManager postWithPath:@"security/login" parameters:dic success:^(id responseObject) {
//        StrongSelf
////        FGUserModel *model = [FGUserModel modelWithJSON:responseObject];
//        [FGUserHelper reloadUserinfo:^(BOOL success, NSString *error) {
//            if (success) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                [self showWarningHUDWithMessage:error completion:nil];
//            }
//        }];
//    } failure:^(NSString *error) {
//        StrongSelf
//        [self showWarningHUDWithMessage:error completion:nil];
//    }];
}


- (void)forgetPwdAction
{
    FGForgetPasswordVC *vc = [FGForgetPasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerAction
{
    FGRegisterVC *vc = [FGRegisterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - navigation set

- (void)backItemClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
