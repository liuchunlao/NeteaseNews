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
#import "MDRRightMenuController.h"


#define MDRLeftMenuH 420
#define MDRLeftMenuY 80
#define MDRLeftMenuW 200

#define MDRRightMenuX 100

@interface MDRMainController ()

@property (nonatomic, weak) MDRNavigationController *showingNav;

// 右侧菜单栏
@property (nonatomic, weak) UIView *rightMenuView;

// 左侧菜单栏
@property (nonatomic, weak) UIView *leftMenuView;

@end

@implementation MDRMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    // MARK: - 设置背景
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"sidebar_bg"].CGImage);

    // MARK: - 添加子控制器
    [self setupChildVcs];
    
    // MARK: - 添加左侧菜单
    [self setupLeftMenu];
    
    // MARK: - 添加右侧菜单
    [self setupRightMenu];
    
}

#pragma mark - 添加子控制器
- (void)setupChildVcs {

    // MARK: - 新闻
    MDRNewsListController *newsVc = [[MDRNewsListController alloc] init];
    [self setupVc:newsVc withTitle:@"新闻"];
    
    // MARK: - 订阅
    MDRReadingListController *readingVc = [[MDRReadingListController alloc] init];
    [self setupVc:readingVc withTitle:@"订阅"];
    
    // MARK: - 图片
    UIViewController *photoVc = [[UIViewController alloc] init];
    [self setupVc:photoVc withTitle:@"图片"];
    
    // MARK: - 视频
    UIViewController *videoVc = [[UIViewController alloc] init];
    [self setupVc:videoVc withTitle:@"视频"];
    
    
    // MARK: - 跟帖
    UIViewController *commentVc = [[UIViewController alloc] init];
    [self setupVc:commentVc withTitle:@"跟帖"];
    
    
    // MARK: - 电台
    UIViewController *radioVc = [[UIViewController alloc] init];
    [self setupVc:radioVc withTitle:@"电台"];

}

#pragma mark - 根据标题创建控制器
- (void)setupVc:(UIViewController *)vc withTitle:(NSString *)title {
    
    // MARK: - 包成导航控制器
    MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:vc];
    
    // MARK: - 导航栏设置
    // 1.标题
    vc.navigationItem.titleView = [UIButton topButtonWithTitle:title];
    vc.view.backgroundColor = MDRRandomColor;
    // 2.按钮
    // 左边
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    // 右边
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rigthItemClick)];
    
    
    [self addChildViewController:nav];
    
}

#pragma mark - 添加左侧菜单
- (void)setupLeftMenu {

    // MARK: - 左侧菜单
    MDRLeftMenuView *leftMenu = [[MDRLeftMenuView alloc] init];
    
    leftMenu.x = 0;
    leftMenu.y = MDRLeftMenuY;
    leftMenu.height = MDRLeftMenuH;
    leftMenu.width = MDRLeftMenuW;
    
    [self.view insertSubview:leftMenu atIndex:0];
    
    _leftMenuView = leftMenu;
    
    // MARK: - 代码块
    leftMenu.changeVc = ^(MDRLeftMenuView *leftMenu, int fromIdx, int toIdx){
        
        // 1.上次显示的控制器
        MDRNavigationController *lastNav = self.childViewControllers[fromIdx];
        [lastNav.view removeFromSuperview];
        
        // 2.即将要显示的控制器
        MDRNavigationController *newNav = self.childViewControllers[toIdx];
        
        // MARK: - 当一个导航控制器的view，如果第一次显示到它的父控件时，如果有transform的缩放值被改了，则
        [self.view addSubview:newNav.view];
        // 3.让新建的控制器视图与原来的形变相等
        newNav.view.transform = lastNav.view.transform;
        
        _showingNav = newNav;
        
    };
    
}

#pragma mark - 添加右侧菜单
- (void)setupRightMenu {
    
    // MARK: - 右侧控制器
    MDRRightMenuController *rightMenuVc = [[MDRRightMenuController alloc] init];
    
    rightMenuVc.view.x = MDRRightMenuX;
    rightMenuVc.view.y = 0;
    rightMenuVc.view.width = self.view.width - MDRRightMenuX;
    rightMenuVc.view.height = self.view.height;
    
    [self.view addSubview:rightMenuVc.view];
    [self.view addSubview:rightMenuVc.view];
    
    _rightMenuView = rightMenuVc.view;

}

#pragma mark - 显示左侧菜单
- (void)leftItemClick {
    
    self.rightMenuView.hidden = YES;
    self.leftMenuView.hidden = NO;
    
    CGAffineTransform form = self.showingNav.view.transform;
    
    if (CGAffineTransformIsIdentity(form)) {
        
        // 1.需要显示
        
        // 1.1 缩放比
        CGFloat scale = (self.showingNav.view.height - 2 * MDRLeftMenuY) / self.showingNav.view.height;
        
        // 1.2 缩放
        form = CGAffineTransformMakeScale(scale, scale);
        
        // 1.3 平移
        CGFloat distanceY = self.showingNav.view.height * (1 - scale) * 0.5 - MDRLeftMenuY;
        CGFloat distanceX = MDRLeftMenuW - self.showingNav.view.width * (1 - scale) * 0.5;
        
        // 1.4 需要形变的数据
        form = CGAffineTransformTranslate(form, distanceX / scale, distanceY / scale);
        
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
    
    // 动画调整尺寸
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showingNav.view.transform = form;
        
    }];
    
}

#pragma mark - 显示右侧菜单
- (void)rigthItemClick {
    
    self.rightMenuView.hidden = NO;
    self.leftMenuView.hidden = YES;
    
    CGAffineTransform form = self.showingNav.view.transform;
    
    if (CGAffineTransformIsIdentity(form)) {
        
        // 1.需要显示
        // 1.1 缩放比
        CGFloat scale = (self.showingNav.view.height - 2 * MDRLeftMenuY) / self.showingNav.view.height;
        
        // 1.2 缩放
        form = CGAffineTransformMakeScale(scale, scale);
        
        // 1.3 平移
        CGFloat distanceY = self.showingNav.view.height * (1 - scale) * 0.5 - MDRLeftMenuY;
        CGFloat distanceX = self.rightMenuView.width - self.showingNav.view.width * (1 - scale) * 0.5;
        
        // 1.4 需要形变的数据
        form = CGAffineTransformTranslate(form, -distanceX / scale, distanceY / scale);
        
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
