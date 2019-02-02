//
//  XWFliterMoreVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/27.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWFliterMoreVC.h"
#import "XWLabelView.h"
#import "XWXustomizeView.h"
#import "XWLableListModel.h"

@interface XWFliterMoreVC ()
@property (nonatomic,strong)XWLabelView *labelViewSex;
@end

@implementation XWFliterMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:self.moreTitle];
    
    WeakSelf
    [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_release") clickCallBack:^(UIView *view) {
        StrongSelf
        XWXustomizeView *tipView = [XWXustomizeView new];
        [tipView showInView:self.navigationController.view];
        Weakify(tipView)
        [tipView.comfigBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            StrongSelf
            Strongify(tipView)
            if (IsEmpty(tipView.customTextField.text)) {
                [self showTextHUDWithMessage:@"标签为空"];
                return ;
            }
            [self setLabelWithName:tipView.customTextField.text pid:@(self.labelTag).stringValue];
            [tipView remove];
            
        }];
        
    }];
    
    
    [self setupMyView];
}

-(void)setupMyView{
    //性别
    WeakSelf
    self.bgScrollView.contentView.backgroundColor = UIColorFromHex(0xffffff);
    XWLabelView *labelViewSex = [[XWLabelView alloc]init];
//    initWithDataSource:self.dataSource title:@"我的选择" isMore:YES
    labelViewSex.labelModel = self.labelModel;
    self.labelViewSex = labelViewSex;
    labelViewSex.tag = self.labelTag;
    labelViewSex.dataSource = self.dataSource;
    labelViewSex.title = @"我的选择";
    labelViewSex.ismore = YES;
    labelViewSex.isSelected = self.isSelect;
    [labelViewSex setupView];
    [self.bgScrollView.contentView addSubview:labelViewSex];
    Weakify(labelViewSex)
    labelViewSex.btnBlock = ^(UIButton *btn) {
        StrongSelf
        Strongify(labelViewSex)
        if (labelViewSex.isSelected == YES) {
            if (self.labelViewBlock) {
                self.labelViewBlock(labelViewSex, btn);
            }
        }
        
        if (btn.selected) {
            if ([kAppDelegate.pidDic valueForKey:@(labelViewSex.tag).stringValue]) {
                NSMutableArray *dic = [kAppDelegate.pidDic valueForKey:@(labelViewSex.tag).stringValue];
                if (![dic containsObject:@(btn.tag)]) {
                    [dic addObject:@(btn.tag)];
                }
            }else{
                [kAppDelegate.pidDic setValue:[NSMutableArray arrayWithObject:@(btn.tag)] forKey:@(labelViewSex.tag).stringValue];
            }
        }else{
            if ([kAppDelegate.pidDic valueForKey:@(labelViewSex.tag).stringValue]) {
                NSMutableArray *dic = [kAppDelegate.pidDic valueForKey:@(labelViewSex.tag).stringValue];
                if ([dic containsObject:@(btn.tag)]) {
                    [dic removeObject:@(btn.tag)];
                }
            }
        }
        
    };
    [labelViewSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(0));
        make.left.right.offset(0);
        make.bottom.offset(AdaptedHeight(-20));
    }];
    
    [self lableSet];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)lableSet{
    UILabel *label = [UILabel fg_text:@"温馨提示\n1.请认真填写，有助于同类目标用户速配到你\n2.若采用自定义录入，尽可能使用最精简通俗公认常用词\n3.除性别、年龄外每项最多可以设定6个。" fontSize:13 colorHex:0x666666];
    label.numberOfLines = 0;
    [self.bgScrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelViewSex.mas_bottom).offset(AdaptedHeight(52));
//        make.bottom.offset(AdaptedHeight(-88));
        make.left.offset(AdaptedWidth(24));
        make.right.offset(AdaptedWidth(-52));

    }];
    
}

-(void)setLabelWithName:(NSString *)name pid:(NSString *)pid{
    [FGHttpManager postWithPath:@"api/label/set_label" parameters:@{@"name":name,@"label_pid":pid} success:^(id responseObject) {
        XWLableListModel *listModel = [XWLableListModel modelWithJSON:responseObject];
        [self.labelViewSex.dataSource addObject:listModel.name];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.labelModel.labels];
        [arr addObject:listModel];
        self.labelModel.labels = arr;
        [self.labelViewSex setupView];

        
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
    }];
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
