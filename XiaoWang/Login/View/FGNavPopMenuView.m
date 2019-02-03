//
//  FGNavPopMenuView.m
//  yanzhi
//
//  Created by qiuxiaofeng on 2017/11/6.
//  Copyright © 2017年 figo. All rights reserved.
//

#import "FGNavPopMenuView.h"

#define itemHeigth     48  //每项高度
#define triangleWith   15  //三角形的高度

#define itemSelectColor  [[UIColor blackColor]colorWithAlphaComponent:0.1]

@interface FGMenuCell : UITableViewCell

@property (strong, nonatomic) UILabel *textTitleLable;

@end

@implementation FGMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textTitleLable = [UILabel new];
        self.textTitleLable.font = AdaptedFontSize(16);
        self.textTitleLable.textColor = UIColorFromHex(0xffffff);
        self.textTitleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textTitleLable];
        
        [self.textTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return self;
}

@end


@interface FGNavPopMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) CGPoint showPoint;

@property (strong, nonatomic) UITableView *myTabelView;
@property (assign, nonatomic) CGRect originalRect;

@property (strong, nonatomic) NSMutableSet *choseSet;

@end

@implementation FGNavPopMenuView

- (id)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items showPoint:(CGPoint)showPoint{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showPoint = showPoint;
        _items = items.copy;
        CGRect newFrame = self.frame;
        newFrame.size.height = items.count *itemHeigth+triangleWith-5;
        self.frame = newFrame;
        self.alpha = 0;
        self.originalRect = newFrame;
        [self setNeedsDisplay];
        [self.myTabelView reloadData];
        self.layer.anchorPoint = CGPointMake(0.9, 0);
        self.layer.position = CGPointMake(self.layer.position.x+self.frame.size.width*0.4, self.layer.position.y-self.frame.size.height*0.5);
    }
    
    return self;
}

- (NSMutableSet *)choseSet{
    if (!_choseSet) {
        _choseSet = [[NSMutableSet alloc]init];
    }
    
    return _choseSet;
}

- (void)setSq_selectColor:(UIColor *)sq_selectColor{
    _sq_selectColor = sq_selectColor;
    [self.myTabelView reloadData];
}

- (void)setSq_backGroundColor:(UIColor *)sq_backGroundColor{
    _sq_backGroundColor = sq_backGroundColor;
    self.myTabelView.backgroundColor = _sq_backGroundColor;
}

- (void)setItemTextColor:(UIColor *)itemTextColor{
    _itemTextColor = itemTextColor;
    [self.myTabelView reloadData];
}


- (UITableView *)myTabelView{
    if (_myTabelView) {
        
        return _myTabelView;
    }
    
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectZero];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.backgroundColor = [UIColor clearColor];
    _myTabelView.scrollEnabled = NO;
    _myTabelView.layer.cornerRadius = 5;
    _myTabelView.layer.masksToBounds = YES;
    _myTabelView.separatorColor = UIColorFromHexWithAlpha(0xffffff, 0.5);
    _myTabelView.frame = (CGRect){0,triangleWith-5,self.frame.size.width,self.frame.size.height-(triangleWith-5)};
    [self addSubview:_myTabelView];
    
    [_myTabelView registerClass:[FGMenuCell class] forCellReuseIdentifier:NSStringFromClass([FGMenuCell class])];
    return _myTabelView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置separatorInset(iOS7之后)
    if ([self.myTabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    //设置layoutMargins(iOS8之后)
    if ([self.myTabelView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTabelView setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FGMenuCell class])];
    cell.textTitleLable.text = self.items[indexPath.row];
    cell.textTitleLable.textColor = _itemTextColor;
    
    if ([self.choseSet containsObject:@(indexPath.row)]) {
        cell.backgroundColor = itemSelectColor;
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, itemHeigth)];
    backView.backgroundColor = itemSelectColor;
    cell.selectedBackgroundView = backView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeigth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock (self,indexPath.row);
    }
    if (![self.choseSet containsObject:@(indexPath.row)]) {
        [self.choseSet removeAllObjects];
        [self.choseSet addObject:@(indexPath.row)];
    }
    [self.myTabelView reloadData];
    [self dismissView];
}


#pragma - method


- (void)showView{
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    CGPoint locationPoint = CGPointMake(self.showPoint.x - self.originalRect.origin.x, 0);
    CGPoint leftPoint     = CGPointMake(self.showPoint.x - self.originalRect.origin.x-triangleWith/2, triangleWith-5);
    CGPoint rightPoint    = CGPointMake(self.showPoint.x - self.originalRect.origin.x+triangleWith/2, triangleWith-5);
    
    
    CGContextMoveToPoint(context,locationPoint.x,locationPoint.y);//设置起点
    
    CGContextAddLineToPoint(context,leftPoint.x ,  leftPoint.y);
    
    CGContextAddLineToPoint(context,rightPoint.x, rightPoint.y);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    UIColor * clor = self.myTabelView.backgroundColor;
    [clor setFill];  //设置填充色
    
    [clor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
}

- (void)selectBlock:(void (^)(FGNavPopMenuView *, NSInteger))block{
    self.selectBlock = block;
}

- (void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    [self.myTabelView reloadData];
}

@end
