//
//  YSFilterViewController.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/27.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "YSFilterViewController.h"
#import "XWLabelView.h"
#import "XWPairVC.h"
#import "XWLableListModel.h"
#import "XWLabelsModel.h"
#import "XWFliterMoreVC.h"


@interface YSFilterViewController ()
@property (nonatomic,strong)NSArray<XWLableListModel*> *labelArr;
@property (nonatomic,strong)NSMutableArray<XWLabelView*> *labelViewArr;

@end

@implementation YSFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"筛选"];
    self.labelViewArr = [NSMutableArray new];
    [self getLabelData];
}



-(void)getLabelData{
    WeakSelf
    [self showLoadingHUDWithMessage:@""];
    [FGHttpManager getWithPath:@"api/label/lists" parameters:@{} success:^(id responseObject) {
        [self hideLoadingHUD];
        StrongSelf
        NSArray<XWLableListModel*> *labelArr = [NSArray modelArrayWithClass:[XWLableListModel class] json:responseObject];
        self.labelArr = labelArr;
        [self LabelUISet];
        
    } failure:^(NSString *error) {
        
    }];
}

-(void)LabelUISet{
    WeakSelf
    UIView *bufferView;
    UILabel *isFilterLabel = [UILabel fg_text:@"   开启筛选条件" fontSize:16 colorHex:0x333333];
    isFilterLabel.backgroundColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:isFilterLabel];
    [isFilterLabel addTopLineWithEdge:UIEdgeInsetsMake(0, 12, 0, 12)];
    [isFilterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptedHeight(60));
        make.left.right.top.offset(0);
    }];
    
    UISwitch *switchView = [UISwitch new];
    switchView.onTintColor = [UIColor yellowColor];
//    switchView.backgroundColor = UIColor
    switchView.tintColor = UIColorFromHex(0xffffff);
    [self.bgScrollView.contentView addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(isFilterLabel);
        make.right.offset(AdaptedWidth(-26));
    }];
    
    //性别
    XWLabelView *labelViewSex = [[XWLabelView alloc]initWithDataSource:@[@"女",@"男"] title:@"性别"];
    [self.bgScrollView.contentView addSubview:labelViewSex];
    
    Weakify(labelViewSex)
    labelViewSex.btnBlock = ^(UIButton *btn) {
        StrongSelf
        Strongify(labelViewSex)
       
        
    };
    [labelViewSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isFilterLabel.mas_bottom).offset(AdaptedHeight(7));
        make.left.right.offset(0);
    }];
    
    //年龄
    XWLabelView *labelViewAge = [[XWLabelView alloc]initWithDataSource:@[@""] title:@"年龄区间"];
    [self.bgScrollView.contentView addSubview:labelViewAge];
    [labelViewAge setupAge];
    
    [labelViewAge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelViewSex.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
    }];
    
    //地区
    XWLabelView *labelViewloaction = [[XWLabelView alloc]initWithDataSource:@[@""] title:@"地区"];
    [self.bgScrollView.contentView addSubview:labelViewloaction];
    [labelViewloaction setupLocation];
    
    [labelViewloaction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelViewAge.mas_bottom).offset(AdaptedHeight(0));
        make.left.right.offset(0);
    }];
    
    for (int i = 0; i< self.labelArr.count; i++) {
        
        XWLabelView *labelView = [[XWLabelView alloc]initWithDataSource:@[@"",@"",@"",@"",@"",@""] title:((XWLableListModel *)self.labelArr[i]).name];
        [self dataSetWithNum:i labelView:labelView];
        
        Weakify(labelView)

        labelView.btnBlock = ^(UIButton *btn) {
            StrongSelf
            Strongify(labelView)
            if ([btn.titleLabel.text isEqualToString:@"更多 +"]) {
                XWFliterMoreVC *vc = [XWFliterMoreVC new];
                vc.moreTitle = labelView.title;
                vc.dataSource = labelView.dataSource;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        [self.bgScrollView.contentView addSubview:labelView];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(labelViewloaction.mas_bottom).offset(AdaptedHeight(0));
            }else{
                make.top.equalTo(bufferView.mas_bottom);
            }
            if (i == self.labelArr.count - 1) {
                make.bottom.offset(0);
            }
            make.left.right.offset(0);
        }];
        bufferView = labelView;
    }
}

-(void)dataSetWithNum:(NSInteger )num labelView:(XWLabelView *)labelView{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/label/label/%@",self.labelArr[num].ID] parameters:@{} success:^(id responseObject) {
        XWLabelsModel *labels = [XWLabelsModel modelWithJSON:responseObject];
        
        labelView.dataSource = [NSMutableArray arrayWithArray:[labels.labels.rac_sequence map:^id _Nullable(XWLableListModel  *_Nullable value) {
            return value.name;
        }].array];
        
        [labelView setupView];
    } failure:^(NSString *error) {
        
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
