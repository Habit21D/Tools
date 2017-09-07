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

@interface SHViewController ()
@property (nonatomic , assign) CGFloat headerHeight;

@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addChildVCWithArray:(NSArray <UIViewController *> *)childVCArray
                 headerView:(UIView *)headerView {
    [childVCArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController* childVC = (UIViewController *)obj;
        [childVC.view addSubview:childVC.view];
        [self addChildViewController:childVC];
        UIScrollView *scrollView = [self getScrollViewWithVC:childVC];
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
        [scrollView addObserver:self forKeyPath:@"dragging" options:NSKeyValueObservingOptionInitial context:nil];
        [scrollView addObserver:self forKeyPath:@"decelerating" options:NSKeyValueObservingOptionInitial context:nil];

    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *tableView = object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        
        // 如果滑动没有超过150
        if (contentOffsetY < 150) {
            // 让这三个tableView的偏移量相等
            for (BaseViewController *vc in self.childViewControllers) {
                if (vc.tableView.contentOffset.y != tableView.contentOffset.y) {
                    vc.tableView.contentOffset = tableView.contentOffset;
                }
            }
            CGFloat headerY = -tableView.contentOffset.y;
            if (self.refreshSwitch.isOn && headerY > 0) {
                headerY = 0;
            }
            // 改变headerView的y值
            [self.headerView changeY:headerY];
            
            // 一旦大于等于150了，让headerView的y值等于150，就停留在上边了
        } else if (contentOffsetY >= 150) {
            [self.headerView changeY:-150];
        }
        
        // 处理顶部头像
        CGFloat scale = tableView.contentOffset.y / 80;
        
        // 如果大于80，==1，小于0，==0
        if (tableView.contentOffset.y > 80) {
            scale = 1;
        } else if (tableView.contentOffset.y <= 0) {
            scale = 0;
        }
        [self.avatarView setupScale:scale];
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
