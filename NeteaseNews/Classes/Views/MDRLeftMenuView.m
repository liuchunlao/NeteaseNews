//
//  MDRLeftMenuView.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRLeftMenuView.h"

@interface MDRLeftMenuButton : UIButton

@end

@implementation MDRLeftMenuButton

- (void)setHighlighted:(BOOL)highlighted {}

@end


@interface MDRLeftMenuView ()

@property (nonatomic, weak) MDRLeftMenuButton *selectButton;

@end

@implementation MDRLeftMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
            [self addButtonWithTitle:@"新闻" andImageName:@"sidebar_nav_news" andColor:MDRRandomColor];
            [self addButtonWithTitle:@"订阅" andImageName:@"sidebar_nav_reading" andColor:MDRRandomColor];
            [self addButtonWithTitle:@"图片" andImageName:@"sidebar_nav_photo" andColor:MDRRandomColor];
            [self addButtonWithTitle:@"视频" andImageName:@"sidebar_nav_video" andColor:MDRRandomColor];
            [self addButtonWithTitle:@"跟帖" andImageName:@"sidebar_nav_comment" andColor:MDRRandomColor];
            [self addButtonWithTitle:@"电台" andImageName:@"sidebar_nav_radio" andColor:MDRRandomColor];
        
    }
    return self;
}


/**
 - 根据标题及图片创建按钮，
 - 以颜色生成图片设置为按钮的背景图片
 */
- (void)addButtonWithTitle:(NSString *)title andImageName:(NSString *)imgName andColor:(UIColor *)color {

    MDRLeftMenuButton *btn = [MDRLeftMenuButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
    
    // 调整位置
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    [self addSubview:btn];
    
    
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

// MARK: - 按钮点击事件
- (void)buttonClick:(MDRLeftMenuButton *)sender {
    
    if (sender.selected == YES) {
        return;
    }

    // 切换控制器
    if (self.changeVc) {
        self.changeVc(self, (int)self.selectButton.tag, (int)sender.tag);
    }
    
    // 切换状态
    self.selectButton.selected = NO;
    sender.selected = YES;
    self.selectButton = sender;

}

// MARK: - 布局按钮
- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat btnH = self.height / self.subviews.count;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof MDRLeftMenuButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tag = idx;
        
        obj.width = self.width;
        obj.height = btnH;
        
        obj.x = 0;
        obj.y = idx * btnH;
    
        if (idx == 0) {
            
            [self buttonClick:obj];
        }
        
    }];
    

}

@end
