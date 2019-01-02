//
//  FGForgetPasswordVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "FGForgetPasswordVC.h"
#import "FGCellStyleView.h"
#import "UIView+EdgeLine.h"
#import <JKCategories/NSString+JKNormalRegex.h>
#import <JKCategories/NSString+JKHash.h>
#import <UIButton+JKCountDown.h>


@interface FGForgetPasswordVC ()

@property (nonatomic, strong) FGCellStyleView *mobileView; ///< 手机号
@property (nonatomic, strong) FGCellStyleView *codeView; ///< 验证码
@property (nonatomic, strong) FGCellStyleView *pswView; ///< 密码
@property (nonatomic, strong) UIButton *getCodeBtn; ///< 发送验证码
@property (nonatomic, strong) UIButton *nextStepBtn; ///< 下一步


@end

@implementation FGForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationView setTitle:@"忘记密码"];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    FGTextFeidViewModel *model1 = [FGTextFeidViewModel new];
    model1.leftTitle = @"手机号";
    model1.keyboardType = UIKeyboardTypePhonePad;
    model1.placeholder = @"请输入已绑定的手机号";
    model1.limitNum = 11;
    model1.contentMargin = AdaptedWidth(25);
    model1.contentFont = 18;
    self.mobileView = [[FGCellStyleView alloc] initWithModel:model1];
    [self.mobileView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.mobileView];
    
    FGTextFeidViewModel *model2 = [FGTextFeidViewModel new];
    model2.leftTitle = @"验证码";
    model2.placeholder = @"输入验证码";
    model2.limitNum = 6;
    model2.contentMargin = AdaptedWidth(25);
    model2.keyboardType = UIKeyboardTypeNumberPad;
    model2.contentFont = 18;
    self.codeView = [[FGCellStyleView alloc] initWithModel:model2];
    self.codeView.textFeild.clearButtonMode = UITextFieldViewModeNever;
    [self.codeView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.codeView];
    
    FGTextFeidViewModel *model3 = [FGTextFeidViewModel new];
    model3.leftTitle = @"密  码";
    model3.placeholder = @"请输入6-18位密码";
    model3.secureTextEntry = YES;
    model3.contentMargin = AdaptedWidth(25);
    model3.contentFont = 18;
    self.pswView = [[FGCellStyleView alloc] initWithModel:model3];
    [self.pswView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView  addSubview:self.pswView];
    
    
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setImage:UIImageWithName(@"btn_confirm_yellow_1") forState:UIControlStateDisabled];
    [self.nextStepBtn setImage:UIImageWithName(@"btn_confirm_yellow_2") forState:UIControlStateNormal];
    [self.bgScrollView.contentView addSubview:self.nextStepBtn];
    [self.nextStepBtn addTarget:self action:@selector(netxStepAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:@" 获取验证码 " forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = AdaptedFontSize(13);
    [self.getCodeBtn setTitleColor:UIColorFromHex(0xffb000) forState:UIControlStateNormal];
    self.getCodeBtn.layer.cornerRadius = AdaptedWidth(3);
    self.getCodeBtn.layer.borderColor = UIColorFromHex(0xffb000).CGColor;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.clipsToBounds = YES;
    [self.bgScrollView.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn addTarget:self action:@selector(startCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeBtn addBottomLine];
    
}

- (void)setupLayout
{
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(45));
        make.left.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(28));
        make.right.equalTo(self.bgScrollView.contentView ).offset(-AdaptedWidth(34));
        make.height.mas_equalTo(AdaptedHeight(52));
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom).offset(AdaptedWidth(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeView.mas_bottom).offset(AdaptedWidth(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AdaptedWidth(100));
        make.height.mas_equalTo(AdaptedWidth(32));
        make.centerY.equalTo(self.codeView.mas_centerY);
        make.right.equalTo(self.codeView.mas_right ).offset(0);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(66));
        make.centerX.equalTo(self.bgScrollView.contentView.mas_centerX);
        make.bottom.equalTo(self.bgScrollView.contentView);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(355), AdaptedWidth(60)));
    }];
    
}

- (void)seceatAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.pswView.model.secureTextEntry = !sender.selected;
}

/**
 下一步
 */
- (void)netxStepAction
{
    [self.view endEditing:YES];
    NSString *mobile = self.mobileView.model.content;
    NSString *code = self.codeView.model.content;
    NSString *password = self.pswView.model.content;
    
    if (![mobile jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }else if (code == nil || code == 0){
        [self showWarningHUDWithMessage:@"请获取验证码" completion:nil];
        return;
    }else if (code.length < 5) {
        [self showWarningHUDWithMessage:@"输入验证码有误" completion:nil];
        return;
    }else if (password.length < 6) {
        [self showWarningHUDWithMessage:@"密码不能小于6位" completion:nil];
        return;
    }
    //
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"username"] = mobile;
    dic[@"mobileCode"] = code;
    dic[@"password" ] = [password jk_md5String];
    WeakSelf
//    [FGHttpManager postWithPath:@"security/resetPassword" parameters:dic success:^(id responseObject) {
//        StrongSelf
//
//        [FGUserHelper reloadUserinfo:^(BOOL success, NSString *error) {
//            if (success) {
//                [self showCompletionHUDWithMessage:@"重置成功" completion:^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }];
//            }else{
//                [self showWarningHUDWithMessage:error completion:nil];
//            }
//        }];
//
//
//    } failure:^(NSString *error) {
//        StrongSelf
//        [self showWarningHUDWithMessage:error completion:nil];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startCountdown
{
    [self.view endEditing:YES];
    
    if (![self.mobileView.model.content jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }
    
    [self showLoadingHUDWithMessage:nil];
    self.getCodeBtn.titleLabel.font = AdaptedFontSize(13);
    
    WeakSelf
    //根据手机号查找用户名
    NSDictionary *dict = @{@"mobile": self.mobileView.model.content};
    
//    [FGHttpManager getWithPath:@"msm/forgetPassword/mobileCode" parameters:dict success:^(id responseObject) {
//        StrongSelf
//        [self showTextHUDWithMessage:@"发送成功，请留意手机短信"];
//        [self.getCodeBtn jk_startTime:59 title:@"获取验证码" waitTittle:@"重新获取"];
//    } failure:^(NSString *error) {
//        [self showWarningHUDWithMessage:error completion:nil];
//    }];
    
    

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
