//
//  YIPayDetailView.m
//  shopex
//
//  Created by admin on 17/4/12.
//  Copyright © 2017年 figo. All rights reserved.
//

#import "JWPayDetailView.h"
#import "FGCellStyleView.h"
@implementation JWPayItemView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void)setupViews{
    self.modeIV = [UIImageView new];
    [self addSubview:self.modeIV];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = UIColorFromHex(0x333333);
    self.titleLabel.font = AdaptedFontSize(16);
    [self addSubview:self.titleLabel];
    
    self.chooseIV = [UIImageView new];
    [self addSubview:self.chooseIV];

}

- (void)setupLayout{
    [self.chooseIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-AdaptedWidth(18));
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(22), AdaptedWidth(22)));
    }];
    
    [self.modeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AdaptedWidth(16));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(32), AdaptedWidth(32)));
    }];
    [self.modeIV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.modeIV.mas_centerY);
        make.left.equalTo(self.modeIV.mas_right).offset(AdaptedWidth(15));
        make.right.equalTo(self.chooseIV.mas_left).offset(-AdaptedWidth(15));
    }];
}

@end

@interface JWPayDetailView ()

@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,copy)NSString *rightNorImage;
@property (nonatomic,copy)NSString *rightSelImage;
@end

@implementation JWPayDetailView



- (instancetype)initWithLeftImage:(NSArray<NSString *>*)images titles:(NSArray <NSString *>*)titles rightNorImage:(NSString *)rightNorImage rightSelImage:(NSString *)rightSelImage{
    
    if (self = [super init]) {
        self.titles = titles;
        self.images = images;
        self.rightNorImage = rightNorImage;
        self.rightSelImage = rightSelImage;
        
        [self setupViews];
    }
    return self;
}

+ (instancetype)payDetailViewWithLeftImage:(NSArray<NSString *>*)images titles:(NSArray <NSString *>*)titles rightNorImage:(NSString *)rightNorImage rightSelImage:(NSString *)rightSelImage{
    
    return [[self alloc]initWithLeftImage:images titles:titles rightNorImage:rightNorImage rightSelImage:rightSelImage];
}

- (void)setupViews{
    

    self.backgroundColor = UIColorFromHex(0xFFFFFF);
    
    for (NSInteger i = 0; i < self.titles.count; i++ ) {
        JWPayItemView *itemView = [JWPayItemView new];
        itemView.tag = i;
        if ([self.images[i] hasPrefix:@"http"]) {
            [itemView.modeIV sd_setImageWithURL:[NSURL URLWithString:self.images[i]]];
        }else{
            itemView.modeIV.image = UIImageWithName(self.images[i]);
        }
        
        itemView.titleLabel.text = self.titles[i];
        itemView.chooseIV.image = UIImageWithName(self.rightNorImage);
        [itemView setTouchDownTarget:self action:@selector(PayAction:)];
        [self addSubview:itemView];
        
        
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(i * AdaptedWidth(60));
            make.left.right.equalTo(self);
            make.height.mas_equalTo(AdaptedWidth(60));
            
            if (i == self.titles.count-1) {
                make.bottom.offset(0);
            }
        }];
        
        
        if (i != self.titles.count-1) {
            [itemView addBottomLineWithEdge:UIEdgeInsetsMake(0, 9, 0, 17)];
        }
        
        //默认选择第一个
        if (i == 0) {
            [self PayAction:itemView];
        }
    }

}


- (void)PayAction:(JWPayItemView *)itemView{
    if (self.callBackPayType) {
        self.callBackPayType(itemView.tag);
    }
    
    self.selectedItemIndex = itemView.tag;
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    _selectedItemIndex = selectedItemIndex;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[JWPayItemView class]]) {
            JWPayItemView *item = (JWPayItemView *)obj;
            item.chooseIV.image = UIImageWithName(self.rightNorImage);
            if (idx == selectedItemIndex) {
                item.chooseIV.image = UIImageWithName(self.rightSelImage);
            }
        }
    }];
}

@end
