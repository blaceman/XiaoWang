//
//  HYCellCommentView.m
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYCellCommentView.h"

@interface HYCellCommentView ()



@end


@implementation HYCellCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithModel:(id)model
{
    self = [super init];
    if (self) {
        [self setupViewsWithLayout:@[@"fsadfsafsafa",@"fsasafaa"]];
    }
    return self;
}

- (void)setupViewsWithLayout:(NSArray *)model
{
    //查看所有评论
//    UILabel *allLabel = [UILabel fg_text:@"查看所有评论" fontSize:15 colorHex:0x949494];
//    [self addSubview:allLabel];
//    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(0);
//        make.top.offset(AdaptedWidth(20));
//    }];
    
    UIView *tempView;
    
    for (int i = 0; i < model.count; i ++) {
        
//         HYNewsModel *m = model[i];
        
        YYLabel *label = [[YYLabel alloc] init];
        label.preferredMaxLayoutWidth = kScreenWidth - AdaptedWidth(40);
        label.numberOfLines = 0;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(AdaptedWidth(13));
            make.right.lessThanOrEqualTo(self).offset(0);
            make.top.equalTo(tempView ? tempView.mas_bottom : self).offset(AdaptedWidth(11));
            
            //说明 需要添加底部约束
            if (i == model.count - 1) {
                make.bottom.offset(AdaptedWidth(-11));
            }
        }];
        tempView = label;
        
        if (i == 0) {
            label.attributedText = [self firstUserLabAttribute:@"傻瓜" sencondName:nil andComment:model[i]];
        }else{
            label.attributedText = [self firstUserLabAttribute:@"傻瓜" sencondName:@"笨蛋" andComment:model[i]];
        }
        
        
        
//        //说明是二级评论
//        if (m.repliedUserId.integerValue == 0) {
//            label.attributedText = [self firstUserLabAttribute:m.user.nickName sencondName:nil andComment:m.content];
//        }else{
//
//        }
    }
}

/**
 创建 评论 内容
 */
- (NSMutableAttributedString *)firstUserLabAttribute:(NSString *)firstName sencondName:(NSString *)secondName andComment:(NSString *)commentStr{
    
    NSMutableAttributedString *attr = [NSMutableAttributedString new];
    UIColor *nameColor = UIColorFromHex(0x636b95);
    UIColor *textColor = UIColorFromHex(0x333333);
    
    //评论者
    NSMutableAttributedString *nameAttr1 = [[NSMutableAttributedString alloc]initWithString:firstName];
    nameAttr1.font = AdaptedFontSize(16);
    nameAttr1.color = nameColor;
    [attr appendAttributedString:nameAttr1];
    
    if (!IsEmpty(secondName)) {
        NSMutableAttributedString *reAttr = [[NSMutableAttributedString alloc]initWithString:@" 回复 "];
        reAttr.font = AdaptedFontSize(16);
        reAttr.color = textColor;
        [attr appendAttributedString:reAttr];
        //被评论者
        NSMutableAttributedString *nameAttr2 = [[NSMutableAttributedString alloc]initWithString:secondName];
        nameAttr2.font = AdaptedFontSize(16);
        nameAttr2.color = nameColor;
        [attr appendAttributedString:nameAttr2];
    }
    
    NSMutableAttributedString *commentAttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"：%@",commentStr]];
    commentAttr.font = AdaptedFontSize(16);
    commentAttr.color = textColor;
    [attr appendAttributedString:commentAttr];
    
    return attr;
}



@end
