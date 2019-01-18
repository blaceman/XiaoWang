//
//  XWPasswordVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPasswordVC.h"
#import "XWGetWordModel.h"

@interface XWPasswordVC ()
@property (nonatomic, strong) UITextView *questionView;  ///< <#Description#>
@property (nonatomic, strong) UITextView *answerView;  ///< <#Description#>

@property (nonatomic, strong) XWGetWordModel *wordModel;  ///< <#Description#>
@end

@implementation XWPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"通关口令"];
    WeakSelf
    [self.navigationView addRightButtonWithTitle:@"修改" clickCallBack:^(UIView *view) {
        StrongSelf
        [self postData];
    }];
    
    [self getData];
}

-(void)setupViews{
    UILabel *tipLabel = [UILabel fg_text:@"  我的问题" fontSize:13 colorHex:0x3A75FD];
    tipLabel.backgroundColor = UIColorFromHex(kColorBG);
    [self.bgScrollView.contentView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.height.mas_equalTo(AdaptedHeight(44));
    }];
    
    
    UIView *backLabelView = [UIView fg_backgroundColor:0xffffff];
    [self.bgScrollView.contentView addSubview:backLabelView];
    [backLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.height.mas_equalTo(AdaptedHeight(199));
    }];
    
   
    
    UITextView *questionTextView = [UITextView new];
    self.questionView = questionTextView;
    questionTextView.font = AdaptedFontSize(16);
    questionTextView.textColor = UIColorFromHex(0x333333);
    questionTextView.text = @"";
    if (IsEmpty(questionTextView.text)) {
        [questionTextView jk_addPlaceHolder:@"请输入问题"];
    }
    
    [self.bgScrollView.contentView addSubview:questionTextView];
    [questionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backLabelView).offset(AdaptedHeight(26));
        make.left.offset(AdaptedWidth(14));
        make.right.offset(AdaptedWidth(-31));
        make.bottom.equalTo(backLabelView);
        
    }];

    
    UILabel *tip1Label = [UILabel fg_text:@"  我的答案" fontSize:13 colorHex:0x3A75FD];
    tip1Label.backgroundColor = UIColorFromHex(kColorBG);
    [self.bgScrollView.contentView addSubview:tip1Label];
    [tip1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backLabelView.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.height.mas_equalTo(AdaptedHeight(44));
    }];

    UITextView *questionField = [UITextView new];
    self.answerView = questionField;
    questionField.backgroundColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:questionField];
    questionField.textColor = UIColorFromHex(0x333333);
    questionField.font = AdaptedFontSize(16);
    [questionField jk_addPlaceHolder:@"  请输入正确答案"];
    [questionField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip1Label.mas_bottom).offset(AdaptedHeight(0));
        make.left.offset(AdaptedWidth(14));
        make.right.offset(AdaptedWidth(-31));
        make.height.mas_equalTo(AdaptedHeight(111));
    }];
    
    UIView *answserView = [UIView new];
    answserView.backgroundColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:answserView];
    [self.bgScrollView.contentView sendSubviewToBack:answserView];
    [answserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.bottom.equalTo(questionField);
    }];
    
    UILabel *tip2Label = [UILabel fg_text:@"温馨提示" fontSize:13 colorHex:0x333333];
    [self.bgScrollView.contentView addSubview:tip2Label];
    [tip2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(24));
        make.top.equalTo(questionField.mas_bottom).offset(AdaptedHeight(28));
    }];
    
    UILabel *tip3Label = [UILabel fg_text:@"1.鼓励原创 \n2.如有需要请在您设定的通关问题后面加括号备注是猜谜语（猜一什么？）、脑筋急转弯、歇后语、顺口溜、知识题、算术\n3.设定的通关答案尽可能是唯一的，而且用最精简通俗公认的表达方法。否则，有可能造成速配对方通关答题意思对了，却因为用词用字不完全一样，结果通关失败。速配通关答题填写答案时要求一样。" fontSize:13 colorHex:0x666666];
    tip3Label.numberOfLines = 0;
    [self.bgScrollView.contentView addSubview:tip3Label];
    [tip3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(24));
        make.right.offset(AdaptedWidth(-32));
        make.top.equalTo(tip2Label.mas_bottom).offset(AdaptedHeight(8));
        make.bottom.offset(0);
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    [FGHttpManager getWithPath:@"api/profile/get_word" parameters:@{} success:^(id responseObject) {
        XWGetWordModel *wordModel = [XWGetWordModel modelWithJSON:responseObject];
        self.wordModel = wordModel;
        if (wordModel.question) {
            self.questionView.text = wordModel.question;
            [self.questionView jk_addPlaceHolder:nil];
        }
        if (wordModel.answer) {
            self.answerView.text = wordModel.answer;
            [self.answerView jk_addPlaceHolder:nil];
        }

    } failure:^(NSString *error) {
        
    }];
}
-(void)postData{
    [self showLoadingHUDWithMessage:@""];
    [FGHttpManager postWithPath:@"api/profile/set_word" parameters:@{@"question":self.questionView.text,@"answer":self.answerView.text} success:^(id responseObject) {
        [self hideLoadingHUD];
        [self showTextHUDWithMessage:@"修改成功"];
        XWGetWordModel *wordModel = [XWGetWordModel modelWithJSON:responseObject];
        if (wordModel.question) {
            self.questionView.text = wordModel.question;
            [self.questionView jk_addPlaceHolder:nil];
        }
        if (wordModel.answer) {
            self.answerView.text = wordModel.answer;
            [self.answerView jk_addPlaceHolder:nil];
        }
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
