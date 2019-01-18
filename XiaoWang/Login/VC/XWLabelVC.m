//
//  XWLabelVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWLabelVC.h"
#import "XWLabelView.h"
#import "XWPairVC.h"
#import "XWLableListModel.h"
#import "XWLabelsModel.h"

@interface XWLabelVC ()
@property (nonatomic,strong)NSArray<XWLableListModel*> *labelArr;
@end

@implementation XWLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"个性标签"];
    WeakSelf
    [self.navigationView addRightButtonWithTitle:@"跳过" clickCallBack:^(UIView *view) {
        StrongSelf
        XWPairVC *vc = [XWPairVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
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
    UIView *bufferView;
    for (int i = 0; i< self.labelArr.count; i++) {
       
        XWLabelView *labelView = [[XWLabelView alloc]initWithDataSource:@[@"",@"",@"",@"",@"",@""] title:((XWLableListModel *)self.labelArr[i]).name];
        [self dataSetWithNum:i labelView:labelView];
        WeakSelf
        labelView.btnBlock = ^(UIButton *btn) {
            StrongSelf
            
        };
        [self.bgScrollView.contentView addSubview:labelView];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.offset(0);
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
