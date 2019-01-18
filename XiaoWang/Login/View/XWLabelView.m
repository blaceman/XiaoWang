//
//  XWLabelView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWLabelView.h"
@interface XWLabelView()

@property (nonatomic,strong)NSString *title;


@end
@implementation XWLabelView


-(instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xffffff);
        [self addBottomLine];
//        self.dataSource = dataSource;
        self.title = title;
//        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self.dataSource addObject:@"更多 +"];
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
    for (int i = 0; i < self.dataSource.count; i++) {
        UIButton *typeBtn = [UIButton fg_title:self.dataSource[i] fontSize:16 titleColorHex:0x333333];
        [typeBtn jk_setBackgroundColor:UIColorFromHex(0xEDEDED) forState:(UIControlStateSelected)];
        [typeBtn jk_setBackgroundColor:UIColorFromHex(0xffffff) forState:(UIControlStateNormal)];
        [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [typeBtn fg_cornerRadius:AdaptedHeight(18) borderWidth:kOnePixel borderColor:0xD9D9D9];
        if (i == self.dataSource.count - 1) {
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
            
            if (i == self.dataSource.count - 1) {
                
                make.bottom.offset(AdaptedHeight(-22));
                if (bufferArr.count == 1) {
                    [bufferArr removeAllObjects];
                    make.left.offset(AdaptedWidth(13));
                    make.width.mas_equalTo(AdaptedWidth(122));
                    return ;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
