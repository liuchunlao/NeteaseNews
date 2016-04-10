//
//  MDRLeftMenuView.h
//  NeteaseNews
//
//  Created by 刘春牢 on 16/4/10.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MDRLeftMenuView;

typedef void (^LeftMenuBlock)(MDRLeftMenuView *, int fromIdx, int toIdx);

@interface MDRLeftMenuView : UIView

@property (nonatomic, copy) LeftMenuBlock changeVc;

@end
