//
//  XWAlbumVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWAlbumVC.h"
#import "HYHomeTCell.h"
#import "HYDynamicViewController.h"
#import "XWAlbumModel.h"
#import "FGBaseLayoutView.h"

@interface XWAlbumVC ()<UITextFieldDelegate>
@property (nonatomic, strong) FGBaseLayoutView *bottomView;  ///< 底部view
@property (nonatomic, strong) UITextField *textView;  ///< 输入框
@property (nonatomic, strong) UIButton *sendBtn;  ///< 发送@end

@property (nonatomic, strong) id selectModel;  ///< 发送@end

@end
@implementation XWAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"我的相册"];
    WeakSelf
    [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_release") clickCallBack:^(UIView *view) {
        StrongSelf
        HYDynamicViewController *vc = [HYDynamicViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [self setupEstimatedRowHeight:100 cellClasses:@[[HYHomeTCell class]]];
    [self beginRefresh];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
    }];
    self.bottomView.hidden = YES;
}
-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
//    dynamic动态相册，mine我的相册
    [FGHttpManager getWithPath:@"api/photo/lists" parameters:@{@"type":@"mine",@"page":@(offset),@"pageSize":@10} success:^(id responseObject) {
        NSArray<XWAlbumModel *> *albumArr = [NSArray modelArrayWithClass:[XWAlbumModel class] json:[responseObject valueForKey:@"data"]];
        success(albumArr);
        
    } failure:^(NSString *error) {
        
    }];
//    success(@[@"发哈实例和",@"发斯蒂芬",@"发多少",@"发答案是"]);
}


-(void)configCellSubViewsCallback:(FGBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    HYHomeTCell *homeCell = (HYHomeTCell *)cell;
    WeakSelf
    //评论按钮
    homeCell.bottomView.zanBlock = ^(BOOL isZan, BOOL isCancel) {
        StrongSelf
        [self.textView becomeFirstResponder];
        self.selectModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    };
    //点赞按钮
    homeCell.bottomView.flowBlock = ^(BOOL isCancel) {
        StrongSelf
    };
    homeCell.tagLabelBlock = ^(id model) {
        self.selectModel = model;
        [self.textView becomeFirstResponder];
        self.textView.placeholder = @"回复傻瓜:";
    };
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (FGBaseLayoutView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [FGBaseLayoutView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addTopLine];
        
        _textView = [[UITextField alloc]init];
        _textView.placeholder = @" 我也说一句...";
        //        _textView.placeholderColor = UIColorFromHex(0xaaaaaa);
        
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = AdaptedWidth(18);
        _textView.layer.borderColor = UIColorFromHex(0xCACDD6).CGColor;
        _textView.layer.borderWidth = kOnePixel;
        _textView.backgroundColor = UIColorFromHex(kColorBG);
        _textView.delegate = self;
        _textView.font = AdaptedFontSize(16);
        _textView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AdaptedWidth(12), 35)];
        self.textView.leftViewMode = UITextFieldViewModeAlways;
        
        [_bottomView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self->_bottomView).offset(AdaptedHeight(8));
            make.bottom.equalTo(self->_bottomView).offset(AdaptedHeight(-8));
            make.height.mas_equalTo(35);
        }];
        
        _sendBtn = [UIButton fg_title:@"发送" fontSize:18 titleColorHex:0xffffff];
        _sendBtn.backgroundColor = UIColorFromHex(0xFEC830);
        _sendBtn.layer.cornerRadius = AdaptedWidth(18);
        [_sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self->_bottomView);
            make.right.equalTo(self->_bottomView).offset(AdaptedWidth(-10));
            make.height.mas_equalTo(AdaptedHeight(35));
            make.width.mas_equalTo(AdaptedWidth(73));
            make.left.equalTo(self->_textView.mas_right).offset(AdaptedWidth(10));
        }];
        [self addNotification];
    }
    
    return _bottomView;
}
#pragma mark ------------------键盘通知相关------------------
//添加通知
- (void)addNotification{
    //键盘相关通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
}

-(void)keyboardWillChange:(NSNotification *)note{
    
    // 获得通知信息
    NSDictionary *userInfo = note.userInfo;
    // 获得键盘弹出后或隐藏后的frame
    CGRect keyboardFrame =[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获得键盘的y值
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获得屏幕的高度
    CGFloat screenH =[UIScreen mainScreen].bounds.size.height;
    // 获得键盘执行动画的时间
    if (keyboardY - screenH == 0) {
        self.bottomView.hidden = YES;
    }else{
        self.bottomView.hidden = NO;
    }
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView  animateWithDuration:duration animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, (keyboardY - screenH));
    }];
}

-(void)sendClick{
    if ([self.selectModel isKindOfClass:[XWAlbumModel class]]) {
        XWAlbumModel *albumModel = self.selectModel;
        [FGHttpManager postWithPath:@"api/comment/comment" parameters:@{@"photo_id":albumModel.photo_id,@"content":self.textView.text} success:^(id responseObject) {
            [self showTextHUDWithMessage:@"评论成功"];
            [self.textView resignFirstResponder];
            self.textView.text = @"";
            [self beginRefresh];
        } failure:^(NSString *error) {
            
        }];
    }else if ([self.selectModel isKindOfClass:[XWCommentListsModel class]]){
        XWCommentListsModel *model = self.selectModel;
        [FGHttpManager postWithPath:@"api/comment/comment" parameters:@{@"photo_id":model.photo_id,@"content":self.textView.text,@"comment_id":model.ID} success:^(id responseObject) {
            [self showTextHUDWithMessage:@"评论成功"];
            [self.textView resignFirstResponder];
            self.textView.text = @"";
            [self beginRefresh];
        } failure:^(NSString *error) {
            
        }];
    }else if ([self.selectModel isKindOfClass:[XWCommentListsModel class]]){
        XWReplyModel *model = self.selectModel;

        [FGHttpManager postWithPath:@"api/comment/comment" parameters:@{@"photo_id":model.photo_id,@"content":self.textView.text,@"comment_id":model.ID} success:^(id responseObject) {
            [self showTextHUDWithMessage:@"评论成功"];
            [self.textView resignFirstResponder];
            self.textView.text = @"";
            [self beginRefresh];
        } failure:^(NSString *error) {
            
        }];
    }
   
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
