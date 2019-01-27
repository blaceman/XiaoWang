//
//  FGRegisterVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "FGRegisterVC.h"
#import "FGCellStyleView.h"
#import "UIView+EdgeLine.h"
#import <JKCategories/NSString+JKNormalRegex.h>
#import <JKCategories/NSString+JKHash.h>
#import <UIButton+JKCountDown.h>
#import <NSAttributedString+YYText.h>
#import "FGBaseWebViewController.h"

#import "HYPersonSetVC.h"

#import "FGUserModel.h"
#import "XWPairVC.h"

@interface FGRegisterVC ()

@property (nonatomic, strong) FGCellStyleView *mobileView; ///< 手机号
@property (nonatomic, strong) FGCellStyleView *codeView; ///< 验证码
@property (nonatomic, strong) UIButton *getCodeBtn; ///< 发送验证码
@property (nonatomic, strong) UIButton *nextStepBtn; ///< 下一步


@end

@implementation FGRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"登录"];
    
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    FGTextFeidViewModel *model1 = [FGTextFeidViewModel new];
    model1.leftTitle = @"手机号码";
    model1.keyboardType = UIKeyboardTypePhonePad;
    model1.placeholder = @"请输入绑定手机号码";
    model1.limitNum = 11;
    model1.contentMargin = AdaptedWidth(37);
    model1.contentFont = 16;
    self.mobileView = [[FGCellStyleView alloc] initWithModel:model1];
    [self.mobileView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.mobileView];
    
    FGTextFeidViewModel *model2 = [FGTextFeidViewModel new];
    model2.leftTitle = @"验证码";
    model2.placeholder = @"请输入输入验证码";
    model2.limitNum = 6;
    model2.contentFont = 16;
    model2.contentMargin = AdaptedWidth(54);
    model2.keyboardType = UIKeyboardTypeNumberPad;
    self.codeView = [[FGCellStyleView alloc] initWithModel:model2];
    self.codeView.textFeild.clearButtonMode = UITextFieldViewModeNever;
    [self.codeView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.codeView];
    
    
   
    
    
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn fg_cornerRadius:AdaptedHeight(20.5) borderWidth:0 borderColor:0];
    [self.nextStepBtn jk_setBackgroundColor:UIColorFromHex(0xFFE616) forState:(UIControlStateNormal)];
    [self.nextStepBtn setTitle:@"下一页" forState:(UIControlStateNormal)];
    [self.nextStepBtn setTitleColor:UIColorFromHex(0x000000) forState:(UIControlStateNormal)];
    [self.bgScrollView.contentView addSubview:self.nextStepBtn];
    [self.nextStepBtn addTarget:self action:@selector(netxStepAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:@" 发送验证码 " forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = AdaptedFontSize(13);
    [self.getCodeBtn setTitleColor:UIColorFromHex(0x000000) forState:UIControlStateNormal];
    self.getCodeBtn.layer.cornerRadius = AdaptedHeight(16);
    self.getCodeBtn.backgroundColor = UIColorFromHex(0xFFDD00);
    self.getCodeBtn.clipsToBounds = YES;
    [self.bgScrollView.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn addTarget:self action:@selector(startCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeBtn addBottomLine];
    
    
    NSMutableAttributedString *protocolString = [[NSMutableAttributedString alloc] initWithString:@"注册即代表我同意《用户协议》"];
    [protocolString setColor:UIColorFromHex(0x808080) range:NSMakeRange(0, 8)];
    [protocolString setColor:UIColorFromHex(0x419AFF) range:NSMakeRange(8, protocolString.length - 8)];
    [protocolString setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(8, protocolString.length - 8)];
//    [self.protocolBtn setAttributedTitle:protocolString forState:UIControlStateNormal];
    
    

}

- (void)setupLayout
{
    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenHeight - NavigationHeight_N());
    }];
    
   
    
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedWidth(0));
        make.left.equalTo(self.bgScrollView.contentView).offset(AdaptedWidth(12));
        make.right.equalTo(self.bgScrollView.contentView).offset(AdaptedWidth(-12));
        make.height.mas_equalTo(AdaptedHeight(56));
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom).offset(AdaptedWidth(0));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
   
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AdaptedWidth(95));
        make.height.mas_equalTo(AdaptedHeight(32));
        make.centerY.equalTo(self.mobileView.mas_centerY);
        make.right.equalTo(self.mobileView.mas_right ).offset(0);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeView.mas_bottom).offset(AdaptedWidth(33));
        make.height.mas_offset(AdaptedHeight(41));
        make.left.offset(AdaptedWidth(43));
        make.right.offset(AdaptedWidth(-43));
//        make.bottom.offset(0);

    }];
    
   
}

- (void)loginAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)protocolAction:(UIButton *)sender
{
    FGBaseWebViewController *vc = [[FGBaseWebViewController alloc] initWithUrl:@"http://baidu.com"];
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"服务协议"];
}

/**
 下一步
 */
- (void)netxStepAction
{

//    return;
    [self.view endEditing:YES];
    NSString *mobile = self.mobileView.model.content;
    NSString *code = self.codeView.model.content;
    
    if (![mobile jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }else if (code == nil || code == 0){
        [self showWarningHUDWithMessage:@"请获取验证码" completion:nil];
        return;
    }else if (code.length < 5) {
        [self showWarningHUDWithMessage:@"输入验证码有误" completion:nil];
        return;
    }
  
    WeakSelf
    [FGHttpManager postWithPath:@"api/account/login" parameters:@{@"mobile":mobile,@"code":code} success:^(id responseObject) {
        StrongSelf
        FGUserModel *loginModel = [FGUserModel modelWithJSON:responseObject];
        [FGCacheManager sharedInstance].token = loginModel.token;
        [FGCacheManager sharedInstance].userModel = loginModel;
        [kAppDelegate loginNotification];
        if (loginModel.is_newer.boolValue) {
           
            //跳转
            HYPersonSetVC *vc = [HYPersonSetVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            XWPairVC *vc = [XWPairVC new];
            
            FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:vc];
            kAppDelegate.window.rootViewController = navi;
            
//            XWPairVC *vc = [XWPairVC new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSString *error) {
        StrongSelf
        [self showWarningHUDWithMessage:error completion:nil];
    }];

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

    [FGHttpManager postWithPath:@"api/account/send_code" parameters:dict success:^(id responseObject) {
        StrongSelf
        [self showTextHUDWithMessage:@"发送成功，请留意手机短信"];
        [self.getCodeBtn jk_startTime:59 title:@"获取验证码" waitTittle:@"重新获取"];
    } failure:^(NSString *error) {
        StrongSelf
        [self showWarningHUDWithMessage:error completion:nil];
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
