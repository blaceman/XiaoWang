//
//  HYHomeTCell.h
//  hangyeshejiao
//
//  Created by Eric on 2018/3/29.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseTableViewCell.h"
#import "HYCellBottomView.h"
#import "HYCellTopView.h"

@interface HYHomeTCell : FGBaseTableViewCell

@property (nonatomic, strong) HYCellBottomView *bottomView;  ///< <#Description#>

//@property (nonatomic, strong) HYCellTopView *topView;  ///< <#Description#>


@property (nonatomic, strong)UIButton *liveButton;//直播状态按钮

@end
