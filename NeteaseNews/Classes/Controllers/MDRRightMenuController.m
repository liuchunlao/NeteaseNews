//
//  MDRRightMenuController.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/12.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRRightMenuController.h"

@interface MDRRightMenuController ()

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@end

@implementation MDRRightMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 让头像做动画
- (void)iconViewStartAnimating {
    
    // 通过核心动画进行旋转
    [UIView transitionWithView:self.iconView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];
        self.iconView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView transitionWithView:self.iconView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                
                self.iconView.layer.transform = CATransform3DIdentity;
                
                self.iconView.image = [UIImage imageNamed:@"default_avatar"];
                
            } completion:nil];
            
        });
        
    }];


}

@end
