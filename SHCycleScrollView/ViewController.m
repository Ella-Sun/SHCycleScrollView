//
//  ViewController.m
//  SHCycleScrollView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright © 2017年 nil. All rights reserved.
//

#import "ViewController.h"

#import "SHCycleScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupScrollView];
}


- (void)setupScrollView
{
    CGFloat viewWidth = self.view.bounds.size.width;
    CGRect viewFrame = CGRectMake(0, 100, viewWidth, 150.f);
    SHCycleScrollView *relationView = [[SHCycleScrollView alloc] initWithFrame:viewFrame];
    [self.view addSubview:relationView];
}


@end
