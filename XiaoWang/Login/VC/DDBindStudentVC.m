//
//  DDBindStudentVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "DDBindStudentVC.h"
#import "FGCellStyleView.h"
#import "FGPickerView.h"

@interface DDBindStudentVC ()

@property (nonatomic, strong) FGCellStyleView *nameView;  ///< 学生姓名
@property (nonatomic, strong) FGCellStyleView *schoolView;  ///< 学校
@property (nonatomic, strong) FGCellStyleView *editSchoolView;  ///< 编辑学校名称
@property (nonatomic, strong) FGCellStyleView *gradeView;  ///< 年级
@property (nonatomic, strong) FGCellStyleView *classView;  ///< 班级
@property (nonatomic, strong) FGCellStyleView *ageView;  ///< 年龄

@property (nonatomic, strong) UIButton *submitBtn;  ///< 提交
@property (nonatomic, strong) UIButton *jumpBtn;  ///< 跳过

@property (nonatomic,strong)UIView *tempView;
@end

@implementation DDBindStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    DDSchoolModel *school = [DDSchoolModel new];
//    school.name = self.studentModel.schoolName;
//    school.type = self.studentModel.schoolType;
//    school.ID = self.studentModel.schoolId.stringValue;
//    self.selectSchool = school;
    
    [self requestSchoolData];
    
}

- (void)requestSchoolData{
    WeakSelf
    [self setupView];
//    [MBProgressHUD showLoadMessage:nil ToView:nil];
//    [FGHttpManager getWithPath:@"security/getSchool" parameters:nil success:^(id responseObject) {
//        StrongSelf
//        [MBProgressHUD hideHUD];
//        self.schoolData = [NSArray modelArrayWithClass:[DDSchoolModel class] json:responseObject[@"schoolList"]];
//        [self setupView];
//    } failure:^(NSString *error) {
//        [MBProgressHUD showError:error ToView:nil];
//    }];
}

- (void)cellViewAction:(FGCellStyleView *)view
{
//    [self.view endEditing:YES];
//    WeakSelf
//    NSString *leftTitle = view.model.leftTitle;
//    if ([leftTitle isEqualToString:@"学校"]) {
//        NSMutableArray *data = [NSMutableArray new];
//        [self.schoolData enumerateObjectsUsingBlock:^(DDSchoolModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [data addObject:obj.name];
//        }];
//        [data addObject:@"其他学校"];
//        FGPickerView *picker = [[FGPickerView alloc] initWithDataSourceArr:data seletedRow:0 andtitle:nil];
//        [picker show];
//        [picker setDidSeclectedItem:^(NSInteger index, NSString *title) {
//            StrongSelf
//            if (index != data.count-1) {
//                self.selectSchool = self.schoolData[index];
//            }else{
//                self.selectSchool = nil;
//            }
//            self.schoolView.model.content = title;
//
//        }];
//    }else if ([leftTitle isEqualToString:@"年龄"]) {
//
//        NSMutableArray *array = [NSMutableArray new];
//        for (int i = 3; i <= 100; i ++) {
//            [array addObject:@(i).stringValue];
//        }
//        FGPickerView *picker = [[FGPickerView alloc] initWithDataSourceArr:array seletedRow:0 andtitle:nil];
//        [picker show];
//        [picker setDidSeclectedItem:^(NSInteger index, NSString *title) {
//            StrongSelf
//            self.ageView.model.content = NSStringFormat(@"%@岁",title);
//
//
//        }];
//    }
}

/**
 跳过
 */
- (void)jumpAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucceedNotification object:self userInfo:nil];
}

/**
 提交
 */


- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *leftTitle = @[@"邮寄地址",@"详细地址",@"是否考过雅思",@"年龄",@"考试日期",@"留学目的地",@"目标分数"];
    NSArray *content ;
//    if (self.studentModel) {
//        content = @[self.studentModel.realName,self.studentModel.schoolName,self.studentModel.grade,self.studentModel.classes,NSStringFormat(@"%zd岁",self.studentModel.age)];
//    }
    NSArray *placeholders =  @[@"请选择地区",@"请输入详细地址",@"是/否",@"请选择年龄",@"请选择考试日期",@"请选择目的地",@"请选择目标分数"];
    UIView *tempView;
    for (NSInteger i = 0; i < leftTitle.count; i ++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftTitle = leftTitle[i];
        model.placeholder = placeholders[i];
        model.contentMargin = AdaptedWidth(25);
        model.contentFont = 18;
        if (content) {
            model.content = content[i];
        }
        model.alignment = NSTextAlignmentRight;
        if (i == 1 || i == 4) {
            model.rightImgPath = @"ic_arrow_right_light_gray";
        }
        FGCellStyleView *view = [[FGCellStyleView alloc] initWithModel:model];
        [view addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
        [view addTarget:self action:@selector(cellViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempView) {
                make.top.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(40));
                make.left.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(28));
                make.right.equalTo(self.bgScrollView.contentView ).offset(-AdaptedWidth(34));
                make.height.mas_equalTo(AdaptedHeight(52));
            }else{
                make.top.equalTo(tempView.mas_bottom).offset(AdaptedWidth(16));
                make.left.right.height.equalTo(tempView);
            };
        }];
        
        tempView = view;
        
        switch (i) {
            case 0:self.nameView = view;
                break;
            case 1:self.schoolView = view;
                break;
            case 2:self.gradeView = view;
                break;
            case 3:self.classView = view;
                break;
            case 4:self.ageView = view;
                break;
            default:
                break;
        }
    }
    self.tempView = tempView;
    self.submitBtn = [UIButton fg_imageString:@"btn_submission_yellow_2" imageStringSelected:nil];
    [self.submitBtn setImage:UIImageWithName(@"btn_submission_yellow_1") forState:UIControlStateDisabled];
    [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView.contentView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.tempView.mas_bottom).offset(AdaptedWidth(40));
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(355), AdaptedWidth(60)));
    }];
    
    self.jumpBtn = [UIButton fg_title:@"跳过 >" fontSize:17 titleColorHex:0x333333];
    [self.jumpBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView.contentView addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(AdaptedWidth(20));
        make.bottom.offset(0);
    }];
    
    WeakSelf
    [RACObserve(self.schoolView.model, content) subscribeNext:^(NSString *_Nullable string) {
        StrongSelf
        [self isAddEditSchoolView:[string isEqualToString:@"其他学校"]];
    }];
    
//    switch (self.bindType) {
//        case DDBindStudentTypeLogin:{
//            [self.navigationView setTitle:@"绑定学生"];
//        }
//            break;
//        case DDBindStudentTypeNew:{
//            [self.navigationView setTitle:@"绑定新学生"];
//            self.jumpBtn.hidden = YES;
//        }
//            break;
//        case DDBindStudentTypeEdit:{
//            [self.navigationView setTitle:@"编辑学生资料"];
//            self.jumpBtn.hidden = YES;
//        }
//            break;
//        default:
//            break;
//    }

}

/**
 是否 添加编辑学校 view
 */
- (void)isAddEditSchoolView:(BOOL)isAdd
{
    if (isAdd) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.placeholder = @"请输入学校名称";
        model.contentMargin = AdaptedWidth(25);
        model.contentFont = 18;
        model.alignment = NSTextAlignmentRight;
        FGCellStyleView *view = [[FGCellStyleView alloc] initWithModel:model];
        [view addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
        [self.bgScrollView.contentView addSubview:view];
        self.editSchoolView = view;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.schoolView.mas_bottom).offset(AdaptedWidth(16));
            make.height.left.right.equalTo(self.schoolView);
        }];
        
        [self.gradeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.editSchoolView.mas_bottom).offset(AdaptedWidth(16));
            make.height.left.right.equalTo(self.schoolView);
        }];
        
        [self.gradeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.editSchoolView.mas_bottom).offset(AdaptedWidth(16));
        }];
        [self.bgScrollView.contentView layoutIfNeeded];
        
    }else{
        [self.editSchoolView removeFromSuperview];
        self.editSchoolView = nil;
        [self.gradeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.schoolView.mas_bottom).offset(AdaptedWidth(16));
        }];
        [self.bgScrollView.contentView layoutIfNeeded];
    }
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
