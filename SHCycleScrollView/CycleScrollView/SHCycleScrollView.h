//
//  SHCycleScrollView.h
//  SHCycleScrollView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright © 2017年 nil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCycleScrollView : UIView

@property (nonatomic, copy) void(^ClickAction)(NSInteger pageNo);//点击打开

@property (nonatomic, strong) NSArray *datasArray;//存放三个model的数组

@end
