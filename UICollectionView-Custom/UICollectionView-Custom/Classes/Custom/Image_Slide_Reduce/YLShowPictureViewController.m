//
//  YLShowPictureViewController.m
//  UICollectionView-Custom
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "YLShowPictureViewController.h"
#import "SVProgressHUD.h"

@interface YLShowPictureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation YLShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

// 初始化视图
- (void)setupView
{
    // 添加可滚动的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:scrollView atIndex:0];

    // 添加imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:self.imageName];
    [scrollView addSubview:imageView];
    scrollView.delegate = self;
    self.imageView = imageView;
    // 添加手势
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    // 长按图片保存
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(save2photo)];
    [imageView addGestureRecognizer:longPress];
    
    scrollView.maximumZoomScale = 1.5;
    scrollView.minimumZoomScale = 0.2;
    
}

// 转发
- (IBAction)relay:(id)sender {
    [SVProgressHUD showErrorWithStatus:@"不够黄，不能转发" maskType:SVProgressHUDMaskTypeBlack];
}

// 保存到相册
- (IBAction)save2photo {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 保存相册的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败" maskType:SVProgressHUDMaskTypeBlack];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功" maskType:SVProgressHUDMaskTypeBlack];
    }
}
// 退出控制器
- (IBAction)back{

    [self dismissViewControllerAnimated:YES completion:nil];
}

// 缩放图片代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
