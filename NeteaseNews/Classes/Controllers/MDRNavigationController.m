//
//  MDRNavigationController.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRNavigationController.h"

@interface MDRNavigationController ()

@end

@implementation MDRNavigationController

+ (void)initialize {
    
    // 1.获取导航条的外观代理对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2.设置导航条背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航栏标题颜色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     }];
    
    // 4.设置两侧按钮的颜色
    [navBar setTintColor:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}






@end
