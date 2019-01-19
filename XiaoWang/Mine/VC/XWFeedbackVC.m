//
//  XWFeedbackVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWFeedbackVC.h"

@interface XWFeedbackVC ()
@property (nonatomic,strong)UITextView *feedbackField;
@end

@implementation XWFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"意见反馈"];
    
    UITextView *feedbackField = [UITextView new];
    self.feedbackField = feedbackField;
    feedbackField.textContainer.lineFragmentPadding = AdaptedWidth(16);
    feedbackField.backgroundColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:feedbackField];
    feedbackField.textColor = UIColorFromHex(0x333333);
    feedbackField.font = AdaptedFontSize(16);
    [feedbackField jk_addPlaceHolder:@"  请输入你的意见~"];
    [feedbackField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(AdaptedHeight(402));
    }];
    
    
    UIButton *commitBtn = [UIButton   fg_title:@"提交" fontSize:16 titleColorHex:0x000000];
    [commitBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    commitBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [self.bgScrollView.contentView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(45));
        make.right.offset(AdaptedWidth(-45));
        make.top.equalTo(feedbackField.mas_bottom).offset(AdaptedHeight(35));
        make.height.mas_equalTo(AdaptedHeight(40));
        make.bottom.offset(0);

    }];
    [commitBtn addTarget:self action:@selector(postData) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postData{
    [FGHttpManager postWithPath:@"api/feedback/feedback" parameters:@{@"content":self.feedbackField.text} success:^(id responseObject) {
        [self showCompletionHUDWithMessage:@"反馈成功" completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
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
