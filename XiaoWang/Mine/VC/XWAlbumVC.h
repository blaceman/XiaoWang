//
//  XWAlbumVC.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseRefreshTableViewController.h"
#import "XWAlbumModel.h"
@interface XWAlbumVC : FGBaseRefreshTableViewController
@property (nonatomic, assign) BOOL isDynamic;  ///< <#Description#>
@property (nonatomic,strong)FGUserModel *userModel;

@end
