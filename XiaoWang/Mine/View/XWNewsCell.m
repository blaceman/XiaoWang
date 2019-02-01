//
//  XWNewsCellTableViewCell.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWNewsCell.h"
#import "XWPassModel.h"
#import "XWMessageModel.h"
@interface XWNewsCell()
@property (nonatomic, strong) UILabel *nameLabel;  ///< <#Description#>
@property (nonatomic, strong) UILabel *contentLabel;  ///< <#Description#>
@property (nonatomic, strong) UIImageView *rightImg;  ///< <#Description#>


@property (nonatomic, strong) UIImageView *sexImg;  ///< <#Description#>
@property (nonatomic, strong) UILabel *statusLabel;  ///< <#Description#>
@property (nonatomic, strong) UILabel *timeLabel;  ///< <#Description#>




@end
@implementation XWNewsCell

-(void)setupViews{
    [self.contentView addBottomLine];
    
    self.avatetBtn = [UIButton fg_imageString:@"icon_head2" imageStringSelected:@"icon_head2"];
    [self.contentView addSubview:self.avatetBtn];
    [self.avatetBtn fg_cornerRadius:AdaptedWidth(22) borderWidth:0 borderColor:0];
    
    self.nameLabel = [UILabel fg_text:@"恋恋BABY" fontSize:16 colorHex:0x333333];
    [self.contentView addSubview:self.nameLabel];
    
    self.contentLabel = [UILabel fg_text:@"小网号：1548154" fontSize:13 colorHex:0x666666];
    [self.contentView addSubview:self.contentLabel];
    
    self.rightImg = [UIImageView fg_imageString:@"icon_more"];
    [self.contentView addSubview:self.rightImg];
    
    
    self.sexImg = [UIImageView fg_imageString:@"icon_female"];
    [self.contentView addSubview:self.sexImg];
    
    
    self.statusLabel = [UILabel fg_text:@"通关成功" fontSize:15 colorHex:0x41C124];
    [self.contentView addSubview:self.statusLabel];
    
    self.timeLabel = [UILabel fg_text:@"7月10日 20:15" fontSize:11 colorHex:0x999999];
    [self.contentView addSubview:self.timeLabel];
}
-(void)setupLayout{
    [self.avatetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(12));
        make.left.offset(AdaptedWidth(18));
        make.width.height.mas_equalTo(AdaptedWidth(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatetBtn);
        make.left.equalTo(self.avatetBtn.mas_right).offset(AdaptedWidth(14));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatetBtn.mas_bottom).offset(AdaptedHeight(-12));
        make.left.equalTo(self.nameLabel);
//        make.right.offset(AdaptedWidth(-28));
        make.bottom.offset(AdaptedHeight(-12));
        
    }];
//    self.contentLabel.backgroundColor = UIColorFromHex(0x000000);
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(AdaptedWidth(-28));
    }];
    
    [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(AdaptedWidth(6));
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.offset(AdaptedWidth(-28));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentLabel);
        make.right.offset(AdaptedWidth(-28));
    }];
    self.sexImg.hidden = YES;
    self.timeLabel.hidden = YES;
    self.statusLabel.hidden = YES;
    
}

-(void)configWithModel:(id)model{
    
    if ([model isKindOfClass:[FGUserModel class]]) {
        FGUserModel *userModel = model;
        [self uiSetWithStr:@"2"];
        self.nameLabel.text = userModel.nickname;
        self.sexImg.image = UIImageWithName(userModel.gender.integerValue == 20 ? @"icon_male":@"icon_female");
        [self.avatetBtn setImageWithURL:[NSURL URLWithString:userModel.avatar] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
//        self.
        self.contentLabel.text = [NSString stringWithFormat:@"小网号：%@",userModel.code];
        
        return;
    }else if ([model isKindOfClass:[NIMRecentSession class]]){
        NIMRecentSession *sessionModel = model;
        self.statusLabel.hidden = YES;
        self.sexImg.hidden = YES;
        self.nameLabel.text = sessionModel.lastMessage.from;
        self.contentLabel.text = sessionModel.lastMessage.text;
        
    }else if ([model isKindOfClass:[NIMUser class]]){
        NIMUser *user = model;
        self.nameLabel.text = user.userInfo.nickName;
        self.contentLabel.text = user.userInfo.sign;
        [self.avatetBtn setImageWithURL:[NSURL URLWithString:user.userInfo.avatarUrl] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
        self.statusLabel.hidden = YES;
    }else if ([model isKindOfClass:[XWPassModel class]]){
        XWPassModel *passModel = model;
        [self uiSetWithStr:@"2"];
        self.nameLabel.text = passModel.nickname;
        self.sexImg.image = UIImageWithName(passModel.gender.integerValue == 20 ? @"icon_male":@"icon_female");
        [self.avatetBtn setImageWithURL:[NSURL URLWithString:passModel.avatar] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
        //        self.
        self.contentLabel.text = [NSString stringWithFormat:@"小网号：%@",passModel.code];
        
        if (passModel.state.integerValue == 10) {
            self.statusLabel.text = @"匹配中";
            self.statusLabel.textColor = UIColorFromHex(0x41C124);
        }else if (passModel.state.integerValue == 20){
            self.statusLabel.text = @"匹配成功";
            self.statusLabel.textColor = UIColorFromHex(0x41C124);

        }else if (passModel.state.integerValue == 30){
            self.statusLabel.text = @"通关失败";
            self.statusLabel.textColor = UIColorFromHex(0xF13939);

        }else if (passModel.state.integerValue == 40){
            self.statusLabel.text = @"放弃通关";
            self.statusLabel.textColor = UIColorFromHex(0xF13939);

        }else if (passModel.state.integerValue == 50){
            self.statusLabel.text = @"通关超时";
            self.statusLabel.textColor = UIColorFromHex(0xF13939);

        }
        self.timeLabel.text = [passModel.create_time fg_stringWithFormat:@"MM-dd HH:mm"];
        
    }else if ([model isKindOfClass:[XWMessageModel class]]){
        XWMessageModel *messageModel = model;
        [self.avatetBtn setImageWithURL:[NSURL URLWithString:messageModel.avatar] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
       
        self.nameLabel.text = messageModel.nickname ? messageModel.nickname : messageModel.title;
        self.contentLabel.text = messageModel.content;
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel setJk_edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.contentLabel.preferredMaxLayoutWidth = AdaptedWidth(250);
//        self.timeLabel.hidden = NO;
//        self.timeLabel.text = messageModel.t
//        self.sex
        
    }
    
   
}
-(void)uiSetWithStr:(NSString *)model{
    if ([model isEqualToString:@"1"]) {
        self.timeLabel.hidden = YES;
        self.statusLabel.hidden = YES;
        self.contentLabel.hidden = YES;
        self.sexImg.hidden = YES;
        self.rightImg.hidden = YES;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.avatetBtn);
        }];
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatetBtn);
            make.left.equalTo(self.avatetBtn.mas_right).offset(AdaptedWidth(14));
        }];
        [self.avatetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(AdaptedHeight(12));
            make.left.offset(AdaptedWidth(18));
            make.width.height.mas_equalTo(AdaptedWidth(44));
            
        }];
    }else if (([model isEqualToString:@"2"])){
        self.timeLabel.hidden = NO;
        self.statusLabel.hidden = NO;
        self.rightImg.hidden = YES;
        self.statusLabel.hidden = YES;
        self.timeLabel.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
