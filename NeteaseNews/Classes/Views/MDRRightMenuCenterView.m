//
//  MDRRightMenuCenterView.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/12.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRRightMenuCenterView.h"
#import "MDRRightMenuCenterButton.h"

@implementation MDRRightMenuCenterView


- (void)awakeFromNib {
    
    [self setupCenterButtonWithTitle:@"商城 能赚钱花，土豪当家" andImage:@"promoboard_icon_mall"];
    [self setupCenterButtonWithTitle:@"活动 4.0发布，粉丝招募" andImage:@"promoboard_icon_activities"];
    [self setupCenterButtonWithTitle:@"应用 app从来都是这样的" andImage:@"promoboard_icon_apps"];
    
}


- (void)setupCenterButtonWithTitle:(NSString *)title andImage:(NSString *)imgName {
    
    // 创建按钮
    MDRRightMenuCenterButton *btn = [MDRRightMenuCenterButton centerButton];
    
    btn.text = title;
    btn.imgName = imgName;
    
    btn.width = self.width;
    btn.height = self.height / 3;
    
    btn.x = 0;
    btn.y = btn.height * self.subviews.count;
    
    [self addSubview:btn];
    
}


@end
