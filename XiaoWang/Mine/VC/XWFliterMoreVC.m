//
//  XWFliterMoreVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/27.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWFliterMoreVC.h"
#import "XWLabelView.h"

@interface XWFliterMoreVC ()

@end

@implementation XWFliterMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:self.moreTitle];
    [self setupMyView];
}

-(void)setupMyView{
    //性别
    WeakSelf
    self.bgScrollView.contentView.backgroundColor = UIColorFromHex(0xffffff);
    XWLabelView *labelViewSex = [[XWLabelView alloc]init];
//    initWithDataSource:self.dataSource title:@"我的选择" isMore:YES
    labelViewSex.labelModel = self.labelModel;
    labelViewSex.tag = self.labelTag;
    labelViewSex.dataSource = [NSMutableArray arrayWithArray:self.dataSource];
    labelViewSex.title = @"我的选择";
    labelViewSex.ismore = YES;
    [labelViewSex setupView];
    [self.bgScrollView.contentView addSubview:labelViewSex];
    Weakify(labelViewSex)
    labelViewSex.btnBlock = ^(UIButton *btn) {
        StrongSelf
        Strongify(labelViewSex)
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
