//
//  UIView+SDExtension.h
//  SDRefreshView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright (c) 2017年 nil. All rights reserved.
//


#import "UIView+SHExtension.h"

@implementation UIView (SHExtension)

- (CGFloat)sh_height
{
    return self.frame.size.height;
}

- (void)setSh_height:(CGFloat)sh_height
{
    CGRect temp = self.frame;
    temp.size.height = sh_height;
    self.frame = temp;
}

- (CGFloat)sh_width
{
    return self.frame.size.width;
}

- (void)setSh_width:(CGFloat)sh_width
{
    CGRect temp = self.frame;
    temp.size.width = sh_width;
    self.frame = temp;
}


- (CGFloat)sh_y
{
    return self.frame.origin.y;
}

- (void)setSh_y:(CGFloat)sh_y
{
    CGRect temp = self.frame;
    temp.origin.y = sh_y;
    self.frame = temp;
}

- (CGFloat)sh_x
{
    return self.frame.origin.x;
}

- (void)setSh_x:(CGFloat)sh_x
{
    CGRect temp = self.frame;
    temp.origin.x = sh_x;
    self.frame = temp;
}



@end
