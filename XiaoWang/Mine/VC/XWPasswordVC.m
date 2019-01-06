//
//  XWPasswordVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPasswordVC.h"

@interface XWPasswordVC ()

@end

@implementation XWPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"通关口令"];
    
    
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
    
    UILabel *questionLabel = [UILabel fg_text:@"明明是个近视眼，也是个出名的馋小子，在他面前放一堆书，放一个苹果，他会先看什么?" fontSize:16 colorHex:0x333333];
    [self.bgScrollView.contentView addSubview:questionLabel];
    [questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backLabelView).offset(AdaptedHeight(26));
        make.left.offset(AdaptedWidth(14));
        make.right.offset(AdaptedWidth(-31));

    }];
    questionLabel.numberOfLines = 0;
    
    
    UILabel *tip1Label = [UILabel fg_text:@"  我的答案" fontSize:13 colorHex:0x3A75FD];
    tip1Label.backgroundColor = UIColorFromHex(kColorBG);
    [self.bgScrollView.contentView addSubview:tip1Label];
    [tip1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backLabelView.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.height.mas_equalTo(AdaptedHeight(44));
    }];

    UITextView *questionField = [UITextView new];
    questionField.backgroundColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:questionField];
    questionField.textColor = UIColorFromHex(0x333333);
    questionField.font = AdaptedFontSize(16);
    [questionField jk_addPlaceHolder:@"  请输入正确答案"];
    [questionField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip1Label.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.height.mas_equalTo(AdaptedHeight(111));
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
