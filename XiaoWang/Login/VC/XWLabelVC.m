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
#import "XWFliterMoreVC.h"
@interface XWLabelVC ()
@property (nonatomic,strong)NSArray<XWLableListModel*> *labelArr;

@property (nonatomic, strong) NSMutableArray *pidLabelSelectArr;  ///< <#Description#>
@end

@implementation XWLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"个性标签"];
    self.pidLabelSelectArr = [NSMutableArray new];
    WeakSelf
    if (!self.isMyLabel) {
        [self.navigationView addRightButtonWithTitle:@"跳过" clickCallBack:^(UIView *view) {
            StrongSelf
            XWPairVC *vc = [XWPairVC new];
            FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:vc];
            kAppDelegate.window.rootViewController = navi;
            
        }];
    }
   
    
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
        labelView.tag = self.labelArr[i].ID.integerValue;
        [self dataSetWithNum:i labelView:labelView];
        WeakSelf
        Weakify(labelView)
        labelView.btnBlock = ^(UIButton *btn) {
            StrongSelf
            Strongify(labelView)
            if ([btn.titleLabel.text isEqualToString:@"更多 +"]) {
                XWFliterMoreVC *vc = [XWFliterMoreVC new];
                vc.moreTitle = labelView.title;
                vc.dataSource = labelView.dataSource;
                [self.navigationController pushViewController:vc animated:YES];
                return ;
            }
            [self pidSetWithPid:@(labelView.tag).stringValue labels:@(btn.tag).stringValue labelModel:labelView.labelModel];
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
    WeakSelf
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/label/label/%@",self.labelArr[num].ID] parameters:@{} success:^(id responseObject) {
        StrongSelf
        XWLabelsModel *labels = [XWLabelsModel modelWithJSON:responseObject];
        [self.pidLabelSelectArr addObject:labels.selected];
        labelView.labelModel = labels;
        labelView.isSelected = YES;
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
-(void)pidSetWithPid:(NSString *)pid labels:(NSString *)labels labelModel:(XWLabelsModel *)model{
    NSMutableArray *selectArr = [NSMutableArray arrayWithArray:model.selected];
    
    if (!selectArr.count) {
        XWLableListModel *listModel = [XWLableListModel new];
        listModel.label_id = labels;
        listModel.label_pid = pid;
        [selectArr addObject:listModel];
    }else{
        for (int i = 0; i < model.selected.count; i++) {
            XWLableListModel *listModl = model.selected[i];
            XWLableListModel *selectModel = selectArr[i];
            if (listModl.label_id.integerValue == labels.integerValue) {
                [selectArr removeObject:selectModel];
                break;
            }
            if(i == model.selected.count - 1){
                XWLableListModel *listModel = [XWLableListModel new];
                listModel.label_id = labels;
                listModel.label_pid = pid;
                [selectArr addObject:listModel];
            }
        }

    }

    
    if (!self.pidLabelSelectArr.count) {
        [self.pidLabelSelectArr addObject:model.selected];
    }else{
        if (!selectArr.count) {
            [self.pidLabelSelectArr removeObject:model.selected];
        }else{
            if (!model.selected.count) {
                [self.pidLabelSelectArr addObject:selectArr];
            }else{
                [self.pidLabelSelectArr replaceObjectAtIndex:[self.pidLabelSelectArr indexOfObject:model.selected] withObject:selectArr];
            }
            

        }
    }

    
    NSArray *pidArr = [self.pidLabelSelectArr.rac_sequence map:^id _Nullable(NSArray<XWLableListModel *>  *_Nullable value) {
        return value.firstObject.label_pid;
    }].array;
    
    
   NSArray *label_idArr = [self.pidLabelSelectArr.rac_sequence map:^id _Nullable(NSArray<XWLableListModel *>  *_Nullable value) {
       if (!value.count) {
           return nil;
       }
        __block NSString *label_idStr = @"";
        [value jk_each:^(XWLableListModel *object) {
            if ([label_idStr isEqualToString:@""]) {
                label_idStr = object.label_id;
            }else{
                label_idStr = [NSString stringWithFormat:@"%@,%@",label_idStr,object.label_id];
            }
            
        }];
        return label_idStr;
    }].array;
    
    model.selected = selectArr;

    

    
    [FGHttpManager postWithPath:@"api/label/setting_all" parameters:@{@"pid":pidArr.jsonStringEncoded,@"labels":label_idArr.jsonStringEncoded} success:^(id responseObject) {
        
        
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
