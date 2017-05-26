//
//  UIView+SDExtension.h
//  SDRefreshView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright (c) 2017年 nil. All rights reserved.
//


#import <UIKit/UIKit.h>

#define SHColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]


@interface UIView (SHExtension)

@property (nonatomic, assign) CGFloat sh_height;
@property (nonatomic, assign) CGFloat sh_width;

@property (nonatomic, assign) CGFloat sh_y;
@property (nonatomic, assign) CGFloat sh_x;

@end
