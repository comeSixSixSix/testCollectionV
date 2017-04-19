//
//  NavigationVC.m
//  Farm
//
//  Created by 赵鹏云 on 17/4/10.
//  Copyright © 2017年 niuxingyu. All rights reserved.
//

#import "FMNavigationVC.h"

@interface FMNavigationVC ()

@end

@implementation FMNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor] ;
}


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController] ;
    if (self) {
        // 导航条颜色
        self.navigationBar.barTintColor = [UIColor whiteColor] ;
        //导航栏<按钮>字体颜色
//        self.navigationBar.tintColor = [GVColor hexStringToColor:@"#333333"];
        //导航栏的字体颜色,大小
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18]}];

    }
    return self ;
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
