//
//  UIImage+MDR_Ex.m
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "UIImage+MDR_Ex.h"

@implementation UIImage (MDR_Ex)

+ (UIImage *)imageWithColor:(UIColor *)color {

    CGSize size = CGSizeMake(1, 1);
    // 1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // 2.设置颜色
    [color set];
    
    // 3.渲染
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    // 4.获取图片
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭
    UIGraphicsEndImageContext();
    
    // 6.返回图片
    return colorImg;
}

@end
