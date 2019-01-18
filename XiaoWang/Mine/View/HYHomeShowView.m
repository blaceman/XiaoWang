//
//  HYHomeShowView.m
//  hangyeshejiao
//
//  Created by Eric on 2018/3/29.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYHomeShowView.h"
#import <PYPhotosView.h>
#import "XWAlbumModel.h"

@interface HYHomeShowView ()

@property (nonatomic, strong) UILabel *contentLabel;  ///< <#Description#>

@property (nonatomic, strong) PYPhotosView *photosView;  ///< <#Description#>


@end

@implementation HYHomeShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentLabel = [UILabel fg_text:@"" fontSize:17 colorHex:0x333333];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.photosView = [PYPhotosView photosView];
    self.photosView.placeholderImage = UIImageWithName(@"default_square_image_3");
    self.photosView.photoMargin = AdaptedWidth(10);
    self.photosView.photoWidth = (kScreenWidth - AdaptedWidth(60))/3;  //60 怎么来的 其中 父类左右边距各20, 图片直接间隔各 10
    self.photosView.photoHeight = (kScreenWidth - AdaptedWidth(60))/3;
    [self addSubview:self.photosView];
}

- (void)setupLayout
{
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedWidth(0));
        make.left.right.offset(0);
    }];
    
    [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(AdaptedWidth(18));
        make.left.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)configWithModel:(id)model
{
    if ([model isKindOfClass:[XWAlbumModel class]]) {
        XWAlbumModel *albumModel = model;
        self.contentLabel.text = albumModel.content;
        self.photosView.thumbnailUrls = albumModel.images;
        self.photosView.originalUrls = albumModel.images;
        
        CGSize size = [self.photosView sizeWithPhotoCount:albumModel.images.count photosState:PYPhotosViewStateDidCompose];
        [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
        
        return;
    }
    
    
    self.contentLabel.text = @"dkgjklajdgkljdasklgfdk";
    
    // 1. 创建图片链接数组
    NSMutableArray *thumbnailImageUrls = [NSMutableArray array];
    // 添加图片(缩略图)链接
    [thumbnailImageUrls addObject:@"http://ww3.sinaimg.cn/thumbnail/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    
    // 1.2 创建图片原图链接数组
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    // 添加图片(原图)链接
    [originalImageUrls addObject:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    
    self.photosView.thumbnailUrls = thumbnailImageUrls;
    self.photosView.originalUrls = originalImageUrls;

    CGSize size = [self.photosView sizeWithPhotoCount:thumbnailImageUrls.count photosState:PYPhotosViewStateDidCompose];
    [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
//    if ([model isKindOfClass:[NSString class]]) {
//        NSString *m = model;
//        self.contentLabel.text = m;
//
//        //修改约束
//        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(IsEmpty(m) ? 0 : AdaptedWidth(20));
//        }];
//
//        if (IsEmpty(m)) {
//            [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.contentLabel.mas_bottom).offset(IsEmpty(m) ? 0 : AdaptedWidth(20));
//            }];
//            return;
//        }
//
//        NSArray *thumbnailImageUrls = [@[@"",@"",@"",@"",@""] jk_map:^id(NSString *object) {
//            return object;
//        }];
//
//        NSArray *originalImageUrls = [@[@"",@"",@"",@"",@""] jk_map:^id(NSString *object) {
//            return object;
//        }];
//
//        self.photosView.thumbnailUrls = @[@"",@"",@"",@"",@""];
//        self.photosView.originalUrls = @[@"",@"",@"",@"",@""];
//
//        CGSize size = [self.photosView sizeWithPhotoCount:thumbnailImageUrls.count photosState:PYPhotosViewStateDidCompose];
//        [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(size);
//        }];
//    }
    
    
}


@end
