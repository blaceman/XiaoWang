//
//  HYHomeTCell.m
//  hangyeshejiao
//
//  Created by Eric on 2018/3/29.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYHomeTCell.h"
#import <YYLabel.h>
#import "HYHomeShowView.h"
#import "HYCellBottomView.h"
#import "HYCellCommentView.h"
#import <JKCategories/UIView+JKFind.h>
#import "XWAlbumModel.h"

@interface HYHomeTCell ()


@property (nonatomic, strong) UIView *containerView;  ///< <#Description#>
@property (nonatomic, strong) UIView *commentView;  ///< <#Description#>

@property (nonatomic, strong) UIView *emptyView;  ///< 间隙view

@end


@implementation HYHomeTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews
{
//    self.topView = [HYCellTopView new];
//    [self.contentView addSubview:self.topView];
    
    self.containerView = [UIView fg_backgroundColor:0];
    [self.contentView addSubview:self.containerView];
    
    self.commentView = [UIView fg_backgroundColor:0];
    [self.contentView addSubview:self.commentView];
    
    self.bottomView = [HYCellBottomView new];
    [self.contentView addSubview:self.bottomView];
    
    self.emptyView = [UIView fg_backgroundColor:0xffffff];
    [self.contentView addSubview:self.emptyView];
    
    [self.contentView addBottomLine];
}

- (void)setupLayout
{
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(AdaptedWidth(16));
//        make.top.offset(AdaptedWidth(20));
//        make.right.offset(AdaptedWidth(-16));
//    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedWidth(20));

//        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.offset(0);
    }];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_bottom);
        make.left.right.offset(0);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(20));
        make.top.equalTo(self.commentView.mas_bottom).offset(AdaptedWidth(20));
        make.right.offset(AdaptedWidth(-20));
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.bottomView.mas_bottom).offset(AdaptedWidth(18));
//        make.height.offset(AdaptedWidth(10));
        make.bottom.offset(0).priorityHigh();
    }];
}

- (void)configWithModel:(id)model
{
    //假数据

//    [self.topView configWithModel:@""];
    [self.bottomView configWithModel:model];
    
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //展示 图片
    HYHomeShowView *view = [HYHomeShowView new];
    [view configWithModel:model];
    [self.containerView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedWidth(0));
        make.left.offset(AdaptedWidth(20));
        make.right.offset(AdaptedWidth(-20));
        make.bottom.offset(0).priorityHigh();
    }];
    
//    //一级页面的评论
    HYCellCommentView *comment = [[HYCellCommentView alloc] initWithModel:model];
    comment.backgroundColor = UIColorFromHex(kColorBG);
    [self.emptyView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedWidth(0));
        make.left.offset(AdaptedWidth(20));
        make.right.offset(AdaptedWidth(-20));
        make.bottom.offset(AdaptedHeight(-18));
    }];
}




@end
