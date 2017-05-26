//
//  SHCyclePartView.h
//  SHCycleScrollView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright © 2017年 nil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCyclePartView : UIView

//注意避免重复点击 BOOL
@property (nonatomic, copy) void(^TapFoldAction)();

@property (nonatomic, strong) UIImage *currentImage;

@end
