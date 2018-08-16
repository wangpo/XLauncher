//
//  SGAppearance.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGAppearance.h"

@implementation SGAppearance

+ (instancetype)defaultAppearance {
    static dispatch_once_t _onceToken = 0;
    static SGAppearance *_defaultAppearance = nil;
    dispatch_once(&_onceToken, ^{
        _defaultAppearance = [[self alloc] init];
    });
    return _defaultAppearance;
}

- (void)setup {
    [self setupNavigationBar];
    [self setupStatusBar];
    [self setupTabbar];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
    }
}

- (void)setupNavigationBar {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.translucent = YES;
    [navigationBar setShadowImage:[UIImage new]];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.titleTextAttributes = @{
                                          NSForegroundColorAttributeName: [UIColor blackColor],
                                          };
}

- (void)setupStatusBar {
    
}

- (void)setupTabbar {
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.translucent = NO;
    tabBar.barTintColor = [UIColor whiteColor];
    //tabBar上分割线
    [tabBar setShadowImage:[UIImage new]];
    [tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 0.5)]];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0,-2)];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGB:0x999999], NSForegroundColorAttributeName, [UIFont systemFontOfSize:10.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGB:0x006CDC], NSForegroundColorAttributeName, [UIFont systemFontOfSize:10.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
    [[UIButton appearance] setExclusiveTouch:YES];
}

@end
