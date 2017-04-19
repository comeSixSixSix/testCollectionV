//
//  FMTabBarVC.m
//  Farm
//
//  Created by 赵鹏云 on 17/4/10.
//  Copyright © 2017年 niuxingyu. All rights reserved.
//

#import "FMTabBarVC.h"
#import "FMNavigationVC.h"
#import "SlideReduceVC.h"
#import "WaterFallVC.h"

#define tabBarHeight [self getTabBarHeight]
#define standOutHeight 16.0f
#define ScreenW  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenH CGRectGetHeight([UIScreen mainScreen].bounds)

@interface FMTabBarVC ()<UITabBarControllerDelegate>
{
    BOOL _btn_hight_bool ;
    
    UIView *_bottomViewColor ;
}
@end

@implementation FMTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UINavigationBar的外观属性
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
//    [self setupChildViewController:[[FMHomeVC alloc]init] title:@"首页" imageName:@"home" selectedImageName:@"home_select"] ;
//    [self setupChildViewController:[[FMMeVC alloc]init] title:@"我的" imageName:@"me" selectedImageName:@"me_select"] ;

    FMNavigationVC * home_NVC = [[FMNavigationVC alloc]initWithRootViewController:[[SlideReduceVC alloc]init]] ;
    FMNavigationVC * me_NVC = [[FMNavigationVC alloc]initWithRootViewController:[[WaterFallVC alloc]init]] ;
    
    UITabBarItem * tab1 =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1000] ;
    
    UITabBarItem * tab2 =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1000] ;
    
    tab1.title = @"瀑布流";
    tab2.title = @"滑动缩小";
    // 联系 标签和导航
    home_NVC.tabBarItem = tab1 ;
    me_NVC.tabBarItem = tab2 ;
    
    self.viewControllers = @[home_NVC, me_NVC] ;
        

}


#pragma mark UIButton event
- (void) click_button:(UIButton *)button
{
    if (_btn_hight_bool) {
        _btn_hight_bool = !_btn_hight_bool ;
        [_btn setBackgroundImage:[UIImage imageNamed:@"put_sure"] forState:UIControlStateNormal] ;
        NSLog(@"123131") ;
    }else{
        _btn_hight_bool = !_btn_hight_bool ;
        [_btn setBackgroundImage:[UIImage imageNamed:@"put_cancel"] forState:UIControlStateNormal] ;
    }
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedIamge = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedIamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navVc];
    
}

@end
