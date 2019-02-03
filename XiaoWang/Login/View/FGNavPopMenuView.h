//
//  FGNavPopMenuView.h
//  yanzhi
//
//  Created by qiuxiaofeng on 2017/11/6.
//  Copyright © 2017年 figo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGNavPopMenuView : UIView

- (id)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items showPoint:(CGPoint)showPoint;



@property (strong, nonatomic) UIColor *sq_selectColor; //选后的颜色
@property (strong, nonatomic) UIColor *sq_backGroundColor;
@property (copy, nonatomic) void(^selectBlock)(FGNavPopMenuView *view, NSInteger index);

@property (copy, nonatomic) UIColor *itemTextColor;

@property (nonatomic,strong)NSArray<NSString *> *items;

- (void)selectBlock:(void(^)(FGNavPopMenuView *view, NSInteger index))block;

- (void)showView;
- (void)dismissView;


@end
