//
//  SHViewController.h
//  SegmentTableView
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 jyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHViewController : UIViewController

- (void)addChildVCWithArray:(NSArray <UIViewController *> *)childVCArray
                 headerView:(UIView *)headerView
              segmentHeight:(CGFloat)segmentHeight;

@end
