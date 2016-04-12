//
//  MDRRightMenuCenterButton.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/12.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRRightMenuCenterButton.h"

@interface MDRRightMenuCenterButton ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@property (nonatomic, weak) IBOutlet UIImageView *iconView;


@end


@implementation MDRRightMenuCenterButton


+ (instancetype)centerButton {

    MDRRightMenuCenterButton *centerButton = [[[NSBundle mainBundle] loadNibNamed:@"MDRRightMenuCenterButton" owner:nil options:nil] lastObject];
    
    centerButton.showsTouchWhenHighlighted = YES;
    
    return centerButton;
}

- (void)setText:(NSString *)text {

    _text = text;
    
    self.textLabel.text = text;
    
}

- (void)setImgName:(NSString *)imgName {

    _imgName = imgName;
    
    self.iconView.image = [UIImage imageNamed:imgName];
    
}


@end
