//
//  UIButton+MDR_Ex.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "UIButton+MDR_Ex.h"

@implementation UIButton (MDR_Ex)


+ (UIButton *)topButtonWithTitle:(NSString *)title {

    // 1.标题
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton setImage:[UIImage imageNamed:@"navbar_netease"] forState:UIControlStateNormal];
    [titleButton setTitle:title forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    
    [titleButton sizeToFit];
    titleButton.width += 5;
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    titleButton.userInteractionEnabled = NO;
    
    return titleButton;
}

@end
