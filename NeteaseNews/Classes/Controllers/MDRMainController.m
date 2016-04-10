//
//  MDRMainController.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRMainController.h"
#import "MDRLeftMenuView.h"
#import "MDRNavigationController.h"
#import "MDRNewsListController.h"
#import "MDRReadingListController.h"

@interface MDRMainController ()

@property (nonatomic, weak) MDRNavigationController *showingNav;

@end

@implementation MDRMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    // MARK: - 设置背景
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"sidebar_bg"].CGImage);

    // MARK: - 新闻控制器
    MDRNewsListController *newsVc = [[MDRNewsListController alloc] init];
    [self setupVc:newsVc withTitle:@"新闻"];
    
    // MARK: - 订阅控制器
    MDRReadingListController *readingVc = [[MDRReadingListController alloc] init];
    [self setupVc:readingVc withTitle:@"订阅"];
    
    

    // MARK: - 左侧菜单
    MDRLeftMenuView *leftMenu = [[MDRLeftMenuView alloc] init];
    
//    leftMenu.backgroundColor = MDRRandomColor;
    leftMenu.x = 0;
    leftMenu.y = 80;
    leftMenu.height = 420;
    leftMenu.width = 200;
    
    [self.view insertSubview:leftMenu atIndex:0];
    
    // MARK: - 代码块
    leftMenu.changeVc = ^(MDRLeftMenuView *leftMenu, int fromIdx, int toIdx){
    
        // 上次显示的控制器
        MDRNavigationController *lastNav = self.childViewControllers[fromIdx];
        [lastNav.view removeFromSuperview];
        
        
        // 即将要显示的控制器
        MDRNavigationController *newNav = self.childViewControllers[toIdx];
        
        // 当一个导航控制器的view，如果第一次显示到它的父控件时，如果有transform的缩放值被改了，则
        [self.view addSubview:newNav.view];
        // 让新建的控制器视图与原来的形变相等
        newNav.view.transform = lastNav.view.transform;
        
        _showingNav = newNav;
    
    
    };
    
    
}

- (void)setupVc:(UIViewController *)vc withTitle:(NSString *)title {

    // MARK: - 包成导航控制器
    MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:vc];
    
    // MARK: - 导航栏设置
    // 1.标题
    vc.navigationItem.titleView = [UIButton topButtonWithTitle:title];
    
    // 2.按钮
    // 左边
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuIconItemClick)];
    
    // 右边
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [self addChildViewController:nav];
    
}

#pragma mark - 显示左侧菜单
- (void)menuIconItemClick {
    
    CGAffineTransform form = self.showingNav.view.transform;
    
    if (CGAffineTransformIsIdentity(form)) {
        
        // 1.需要显示
        
        // 1.1 缩放比
        CGFloat scale = (self.showingNav.view.height - 2 * 80) / self.showingNav.view.height;
        
        // 1.2 缩放
        form = CGAffineTransformMakeScale(scale, scale);
        
        // 1.3 平移
        CGFloat distanceY = self.showingNav.view.height * (1 - scale) * 0.5 - 80;
        CGFloat distanceX = 200 - self.showingNav.view.width * (1 - scale) * 0.5;
        
        // 1.4 需要形变的数据
        form = CGAffineTransformTranslate(form, distanceX / scale, - distanceY / scale);
        
        // MARK: - 遮盖
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        coverBtn.frame = self.showingNav.view.bounds;
        
        [self.showingNav.view addSubview:coverBtn];
        
        [coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    } else {
        // 2.不需要显示
        // 清除
        form = CGAffineTransformIdentity;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showingNav.view.transform = form;
        
    }];
    
}

#pragma mark - 点击遮盖，清除形变
- (void)coverBtnClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showingNav.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [sender removeFromSuperview];
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
    
}


@end
