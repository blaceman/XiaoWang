//
//  FGBaseLayoutView.h
//  shopex
//
//  Created by qiuxiaofeng on 17/3/27.
//  Copyright © 2017年 figo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGBaseLayoutView : UIView

@property(nonatomic, assign) BOOL isHighlight;
@property(nonatomic, strong) UIColor *highlightedBgColor;

- (void)addTopLine;
- (void)addBottomLine;
- (void)addLeftLine;
- (void)addRightLine;

- (void)addTopLineWithEdge:(UIEdgeInsets)edge;
- (void)addBottomLineWithEdge:(UIEdgeInsets)edge;
- (void)addLeftLineWithEdge:(UIEdgeInsets)edge;
- (void)addRightLineWithEdge:(UIEdgeInsets)edge;
- (void)addBottomLineWithEdge:(UIEdgeInsets)edge withColor:(UIColor *)color;

-(void)setTouchDownTarget:(id)target action:(SEL)action;

@end
