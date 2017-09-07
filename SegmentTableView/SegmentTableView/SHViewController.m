//
//  SHViewController.m
//  SegmentTableView
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 jyn. All rights reserved.
//  SegmentHeaderViewController，继承自它就可以直接创建带有头视图的segment了

#import "SHViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WEAKSELF __weak typeof(self) weakSelf = self;
@interface SHViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray <UIViewController *> *vcArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat segmentHeight;
@property (nonatomic, assign) CGFloat headerMaxScrollHeight;

@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (void)addChildVCWithArray:(NSArray <UIViewController *> *)childVCArray
                 headerView:(UIView *)headerView
              segmentHeight:(CGFloat)segmentHeight {
    if (!headerView) {
        [self.view addSubview:headerView];
        self.headerView = headerView;
        self.headerHeight = CGRectGetHeight(headerView.frame);
    }
    
    self.segmentHeight =  segmentHeight;
    self.headerMaxScrollHeight = self.headerHeight - self.segmentHeight;
    
    if (!childVCArray || childVCArray.count <= 0) {
        return;
    }
    self.vcArray = childVCArray;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * childVCArray.count, SCREEN_HEIGHT);
    WEAKSELF
    [childVCArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController* childVC = (UIViewController *)obj;
        childVC.view.frame = CGRectMake(SCREEN_WIDTH * idx, CGRectGetMinY(childVC.view.frame), SCREEN_WIDTH, CGRectGetHeight(childVC.view.frame));
        [weakSelf.scrollView addSubview:childVC.view];
        [weakSelf addChildViewController:childVC];
        UIScrollView *scrollView = [weakSelf getScrollViewWithVC:childVC];
        
        [scrollView addObserver:weakSelf forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
        [scrollView addObserver:weakSelf forKeyPath:@"dragging" options:NSKeyValueObservingOptionInitial context:nil];
        [scrollView addObserver:weakSelf forKeyPath:@"decelerating" options:NSKeyValueObservingOptionInitial context:nil];

    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (offsetY > self.headerMaxScrollHeight) {
            if (CGRectGetMinY(self.headerView.frame) != -self.headerMaxScrollHeight) {
                self.headerView.frame = CGRectMake(0, - self.headerMaxScrollHeight, SCREEN_WIDTH, self.headerHeight);
                
            }}else if (offsetY > 0 && offsetY <= self.headerMaxScrollHeight) {
                
                self.headerView.frame = CGRectMake(0, - offsetY, SCREEN_WIDTH, self.headerHeight);
            }else if (offsetY < 0) {
                self.headerView.frame = CGRectMake(SCREEN_WIDTH * offsetY / self.headerHeight /2.0,0, SCREEN_WIDTH * (self.headerHeight - offsetY)/self.headerHeight, self.headerHeight - offsetY);
            }
    } else if ([keyPath isEqualToString:@"dragging"] || [keyPath isEqualToString:@"decelerating"]){
            WEAKSELF
            [self.vcArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIViewController* childVC = (UIViewController *)obj;
                UIScrollView *scrollView = [weakSelf getScrollViewWithVC:childVC];
                if (offsetY > weakSelf.headerMaxScrollHeight) {
                if (scrollView.contentOffset.y <= weakSelf.headerMaxScrollHeight)
                    scrollView.contentOffset = CGPointMake(0, weakSelf.headerMaxScrollHeight);
                }else if (offsetY >= 0 && offsetY <= weakSelf.headerMaxScrollHeight) {
                    if(scrollView.contentOffset.y != offsetY)
                    scrollView.contentOffset = CGPointMake(0, offsetY);
                }else if (offsetY < 0) {
                    if (scrollView.contentOffset.y > 0)
                        scrollView.contentOffset = CGPointMake(0, 0);
                }
            }];
    }

}

- (UIScrollView *)getScrollViewWithVC:(UIViewController *)vc {
    for (UIView *tempView in vc.view.subviews) {
        if ([tempView isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)tempView;
        }
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
