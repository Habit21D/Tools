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

- (void)addChildVCWithArray:(NSArray *)childVCArray
               headerHeight:(CGFloat)headerHeight {
    
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
