//
//  XWLabelView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWLabelView.h"
#import "XWLableListModel.h"
@interface XWLabelView()


@property (nonatomic,strong)NSMutableArray *showArr;
@end
@implementation XWLabelView


-(instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xffffff);
        [self addBottomLine];
        self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        self.title = title;
        [self setupView];
    }
    return self;
}

-(instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title isMore:(BOOL)ismore{
    self = [super init];
    if (self) {
        self.ismore = ismore;
        self.backgroundColor = UIColorFromHex(0xffffff);
        [self addBottomLine];
        self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        self.title = title;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    if (!self.ismore) {
        if (self.dataSource.count >= 6) {
            self.showArr = [NSMutableArray arrayWithArray:[self.dataSource subarrayWithRange:NSMakeRange(0, 5)]];
            [self.showArr addObject:@"更多 +"];
        }else{
            self.showArr = [NSMutableArray arrayWithArray:self.dataSource];
        }
    }else{
        self.showArr = [NSMutableArray arrayWithArray:self.dataSource];
    }
    
    [self removeAllSubviews];
//    [self.dataSource addObject:@"更多 +"];
    UILabel *titleLabel = [UILabel fg_text:self.title fontSize:13 colorHex:0x3A75FD];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(13));
        make.top.offset(AdaptedHeight(17));
    }];
    
    UIView *bufferView;
    bufferView = titleLabel;
    NSMutableArray *bufferArr = [NSMutableArray new];
    for (int i = 0; i < self.showArr.count; i++) {
        UIButton *typeBtn = [UIButton fg_title:self.showArr[i] fontSize:16 titleColorHex:0x333333];
        if (![typeBtn.titleLabel.text isEqualToString:@"更多 +"]) {
            if ([typeBtn.titleLabel.text isEqualToString:@"男"]) {
                typeBtn.tag = 10000;
            }else if ([typeBtn.titleLabel.text isEqualToString:@"女"]){
                 typeBtn.tag = 10001;
            }
            if (self.labelModel) {
                typeBtn.tag = (self.labelModel.labels[i]).ID.integerValue;
                if ([kAppDelegate.pidDic valueForKey:@(self.tag).stringValue]) {
                    NSArray *arr = [kAppDelegate.pidDic valueForKey:@(self.tag).stringValue];
                    if ([arr containsObject:@(typeBtn.tag)]) {
                        typeBtn.selected = YES;
                    }
                }
            }
           
            
        }
        [typeBtn jk_setBackgroundColor:UIColorFromHex(0xEDEDED) forState:(UIControlStateSelected)];
        [typeBtn jk_setBackgroundColor:UIColorFromHex(0xffffff) forState:(UIControlStateNormal)];
        [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [typeBtn fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:0xD9D9D9];
        if ([typeBtn.titleLabel.text isEqualToString:@"更多 +"]) {
            [typeBtn setTitleColor:UIColorFromHex(0x999999) forState:(UIControlStateNormal)];
            [typeBtn jk_setBackgroundColor:UIColorFromHex(0xffffff) forState:(UIControlStateSelected)];
        }
        [bufferArr addObject:typeBtn];
        [self addSubview:typeBtn];
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(AdaptedWidth(122));
            make.height.mas_equalTo(AdaptedHeight(36));
            if ((i % 3) == 0) {
                make.top.equalTo(bufferView.mas_bottom).offset((i == 0) ? AdaptedHeight(17) : AdaptedHeight(12));
            }else{
                make.centerY.equalTo(bufferView);
            }
            
            if (i == self.showArr.count - 1) {
                
                make.bottom.offset(AdaptedHeight(-22));
                if (bufferArr.count == 1) {
                    [bufferArr removeAllObjects];
                    make.left.offset(AdaptedWidth(13));
                    make.width.mas_equalTo(AdaptedWidth(122));
                    return ;
                }else if (bufferArr.count == 2){
                    [bufferView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(AdaptedWidth(13));
                        make.width.mas_equalTo(AdaptedWidth(122));
                    }];
                    make.centerX.offset(0);
                    make.centerY.equalTo(bufferView);
                    make.width.mas_equalTo(AdaptedWidth(122));

                    return;
                }
                [bufferArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:AdaptedWidth(122) leadSpacing:AdaptedWidth(13) tailSpacing:AdaptedWidth(13)];
                [bufferArr removeAllObjects];
                return ;
            }
            if ((i % 3) == 2) {
                [bufferArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:AdaptedWidth(122) leadSpacing:AdaptedWidth(13) tailSpacing:AdaptedWidth(13)];
                [bufferArr removeAllObjects];
            }
        }];
        bufferView = typeBtn;
    }
}

-(void)typeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(self.btnBlock){
        self.btnBlock(sender);
    }
}


-(void)setupAge{
    [self removeAllSubviews];
    UILabel *titleLabel = [UILabel fg_text:self.title fontSize:13 colorHex:0x3A75FD];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(13));
        make.top.offset(AdaptedHeight(17));
    }];
    
    UITextField *minAgeField = [UITextField new];
    minAgeField.tag = 20000;
    minAgeField.backgroundColor = UIColorFromHex(0xffffff);

    minAgeField.textAlignment = NSTextAlignmentCenter;
    minAgeField.placeholder = @"最小年龄";
    minAgeField.font = AdaptedFontSize(16);
    minAgeField.textColor = UIColorFromHex(0x333333);
    [self addSubview:minAgeField];
    [minAgeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(AdaptedHeight(12));
        make.left.offset(AdaptedWidth(13));
        make.bottom.offset(AdaptedHeight(-22));
        make.height.mas_equalTo(AdaptedHeight(37));
        make.width.mas_equalTo(AdaptedHeight(158));
    }];
    [minAgeField fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:kColorBG];
    
    UITextField *maxAgeField = [UITextField new];
    maxAgeField.tag = 20001;

    maxAgeField.backgroundColor = UIColorFromHex(0xffffff);
    maxAgeField.textAlignment = NSTextAlignmentCenter;
    maxAgeField.placeholder = @"最大年龄";
    maxAgeField.font = AdaptedFontSize(16);
    maxAgeField.textColor = UIColorFromHex(0x333333);
    [self addSubview:maxAgeField];
    [maxAgeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(minAgeField);
        make.right.offset(AdaptedWidth(-13));
        make.height.mas_equalTo(AdaptedHeight(37));
        make.width.mas_equalTo(AdaptedHeight(158));
    }];
    [maxAgeField fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:kColorBG];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorFromHex(kColorBG);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(minAgeField);
        make.height.mas_equalTo(kOnePixel);
        make.left.equalTo(minAgeField.mas_right).offset(AdaptedWidth(12));
        make.right.equalTo(maxAgeField.mas_left).offset(AdaptedWidth(-12));

    }];
}


-(void)setupLocation{
    [self removeAllSubviews];
    UILabel *titleLabel = [UILabel fg_text:self.title fontSize:13 colorHex:0x666666];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(13));
        make.top.offset(AdaptedHeight(17));
    }];
    
    UIButton *typeBtn = [UIButton fg_title:@"省市区" fontSize:16 titleColorHex:0x333333];
    typeBtn.tag = 30000;
    typeBtn.backgroundColor = UIColorFromHex(0xffffff);
    [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];

    [self addSubview:typeBtn];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(AdaptedHeight(12));
        make.left.offset(AdaptedWidth(13));
        make.bottom.offset(AdaptedHeight(-22));
        make.height.mas_equalTo(AdaptedHeight(37));
        make.width.mas_equalTo(AdaptedHeight(122));
    }];
    [typeBtn fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:kColorBG];
    
    UITextField *maxAgeField = [UITextField new];
    maxAgeField.tag = 30001;

    maxAgeField.backgroundColor = UIColorFromHex(0xffffff);
    maxAgeField.textAlignment = NSTextAlignmentCenter;
    maxAgeField.placeholder = @"距离≤   公里";
    maxAgeField.font = AdaptedFontSize(16);
    maxAgeField.textColor = UIColorFromHex(0x333333);
    [self addSubview:maxAgeField];
    [maxAgeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeBtn);
        make.right.offset(AdaptedWidth(-13));
        make.height.mas_equalTo(AdaptedHeight(37));
        make.left.equalTo(typeBtn.mas_right).offset(AdaptedWidth(10));
    }];
    [maxAgeField fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:kColorBG];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
