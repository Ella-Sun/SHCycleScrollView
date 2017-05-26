//
//  SHCycleScrollView.m
//  SHCycleScrollView
//
//  Created by Glen Eller on 2017/5/26.
//  Copyright © 2017年 nil. All rights reserved.
//

#import "SHCycleScrollView.h"

#import "UIView+SHExtension.h"
#import "SHCyclePartView.h"

static NSInteger PageCount = 3;
//static CGFloat rightSpacePercent = 0.2;//右侧空占百分比
static CGFloat viewWidthPercent = 1.0;//子视图宽度占百分比

#define PartViewWidth self.viewWidth*viewWidthPercent

@interface SHCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, assign) NSInteger currentPage;//当前页码
//@property (nonatomic, assign) CGFloat direction;//运动方向，1 <==> right, -1 <==> left

@property (nonatomic, strong) NSMutableArray<SHCyclePartView *> *viewsArray;//存储三个子视图

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation SHCycleScrollView

#pragma mark - init

- (CGFloat)viewWidth
{
    return self.bounds.size.width;
}

- (CGFloat)viewHeight
{
    return self.bounds.size.height;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentPage = 0;
//        self.direction = 1;
        
        //伪值
        self.datasArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
        
        //scrollView
        [self addSubview:self.scrollView];
        [self initPartViews];
        //pageControl
        [self addSubview:self.pageControl];
        
    }
    return self;
}

//创建滑动视图
- (void)initPartViews
{
    NSArray *colors = @[[UIColor redColor],[UIColor greenColor],[UIColor cyanColor]];
    for (int i = 0; i<3; i++) {
        CGRect partFrame = CGRectMake(PartViewWidth*i, 0, PartViewWidth, [self viewHeight]);
        SHCyclePartView *partView = [self generalCommonSubviewWithFrame:partFrame];
        partView.backgroundColor = colors[i];
        partView.tag = 200 + i;
        __weak typeof(self)weakSelf = self;
        //点击折叠按钮
        partView.TapFoldAction = ^{
            if (self.ClickAction) {
                self.ClickAction(weakSelf.currentPage);
            };
        };
        [self.scrollView addSubview:partView];
        
        [self.viewsArray addObject:partView];
    }
    
    NSString *imageName = self.datasArray[self.currentPage];
    UIImage *showImage = [UIImage imageNamed:imageName];
    SHCyclePartView *currentView = self.viewsArray[1];
    currentView.currentImage = showImage;
}

- (SHCyclePartView *)generalCommonSubviewWithFrame:(CGRect)frame
{
    SHCyclePartView *relationView = [[SHCyclePartView alloc] initWithFrame:frame];
    
    return relationView;
}

#pragma mark - 获取子视图索引

/**
 获取当前显示视图索引
 
 @return 当前视图索引
 */
- (NSInteger)getCurrentSubviewIndex:(NSInteger)currentPage
{
    if (self.datasArray.count > 0) {
        NSInteger tempCurrentPage = currentPage % self.datasArray.count;
        return tempCurrentPage < 0 ? self.datasArray.count - 1 : tempCurrentPage;
    }
    return 0;
}

/**
 获取当前显示视图的上一个视图的索引
 
 @return 上一个视图的索引
 */
- (NSInteger)getBeforeSubviewIndex:(NSInteger)currentPage
{
    NSInteger beforeNumber = [self getCurrentSubviewIndex:currentPage] - 1;
    return beforeNumber < 0 ? self.datasArray.count - 1 : beforeNumber;
}

/**
 获取当前视图显示的下一个视图的索引
 
 @return 下一个视图
 */
- (NSInteger)getLastSubviewIndex:(NSInteger)currentPage
{
    NSInteger lastNumber = [self getCurrentSubviewIndex:currentPage] + 1;
    return lastNumber >= self.datasArray.count ? 0 : lastNumber;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    [self moveSubView:scrollView.contentOffset.x];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView.contentOffset.x - self.viewWidth > 0) {
//        self.direction = 1;
//    } else {
//        self.direction = -1;
//    }
//}

/**
 移动子视图到合适的位置
 */
- (void)moveSubView:(CGFloat)offsetX
{
    CGFloat temp = offsetX / self.viewWidth;
    
    if (temp == 0 || temp == 1 || temp == 2) {
        
        NSInteger position = temp - 1;
        
        NSInteger currentPage = [self getCurrentSubviewIndex:(self.currentPage + position)];
        
//        if (currentPage == self.currentPage && currentPage != 0) {
//            return;
//        }
        self.currentPage = currentPage;
        self.pageControl.currentPage = currentPage;
        
        self.scrollView.contentOffset = CGPointMake(self.viewWidth, 0);
        
        //赋值
        [self setButtonImage:currentPage];
        
        NSLog(@"currentPage>>>>>>>>>>>>>>%ld",currentPage);
    }
}

/**
 赋值

 @param currentPage :
 */
- (void)setButtonImage:(NSInteger)currentPage
{
    NSString *beforeIndexStr = [NSString stringWithFormat:@"%ld",[self getBeforeSubviewIndex:currentPage]];
    NSString *currentIndexStr = [NSString stringWithFormat:@"%ld",[self getCurrentSubviewIndex:currentPage]];
    NSString *lastIndexStr = [NSString stringWithFormat:@"%ld",[self getLastSubviewIndex:currentPage]];
    
    NSArray *imageIndexArray = @[beforeIndexStr,currentIndexStr,lastIndexStr];
    
    for (int i = 0; i<self.viewsArray.count; i++) {
        SHCyclePartView *tempView = self.viewsArray[i];
        NSInteger imageIndex = [imageIndexArray[i] integerValue];
        NSString *imageName = self.datasArray[imageIndex];
        tempView.currentImage = [UIImage imageNamed:imageName];
    }
}


#pragma mark - 创建视图

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        CGRect scrollFrame = CGRectMake(0, 0, self.viewWidth, [self viewHeight]);
        _scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        _scrollView.contentSize = CGSizeMake(self.viewWidth*viewWidthPercent * PageCount, [self viewHeight]);
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        //把scrollView偏移到中间子视图
        _scrollView.contentOffset = CGPointMake(self.viewWidth, 0);
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGFloat pageWidth = 150.f;
        CGFloat pageMinX = PartViewWidth - pageWidth;
        CGRect pageFrame = CGRectMake(pageMinX, 10, pageWidth, 50);
        _pageControl = [[UIPageControl alloc] initWithFrame:pageFrame];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        
        _pageControl.numberOfPages = self.datasArray.count;//PageCount;
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark - 初始化

- (NSMutableArray<SHCyclePartView *> *)viewsArray
{
    if (!_viewsArray) {
        _viewsArray = [NSMutableArray array];
    }
    return _viewsArray;
}

@end
