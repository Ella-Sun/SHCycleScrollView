//
//  SHCyclePartView.m
//  SHCycleScrollView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright © 2017年 nil. All rights reserved.
//

#import "SHCyclePartView.h"

@interface SHCyclePartView ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SHCyclePartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)setCurrentImage:(UIImage *)currentImage
{
    _currentImage = currentImage;
    self.imageView.image = currentImage;
}

@end
