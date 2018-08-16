//
//  SGBaseTabBarController.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGBaseTabBarController.h"
#import "SGBaseNavigationController.h"
#import "SGHomeViewController.h"
#import "SGDiscoveryViewController.h"
#import "SGMallViewController.h"
#import "SGProfileViewController.h"

@interface SGBaseTabBarController ()

@end

@implementation SGBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutTabBarVC];
}

- (void)layoutTabBarVC
{
    //首页
    SGHomeViewController *homeVC = [[SGHomeViewController alloc] init];
    UITabBarItem *homeTBI= [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeVC.tabBarItem = homeTBI;
    SGBaseNavigationController *homeNC = [[SGBaseNavigationController alloc] initWithRootViewController:homeVC];
    //发现
    SGDiscoveryViewController *discoveryVC = [[SGDiscoveryViewController alloc] init];
    UITabBarItem *discoveryTBI= [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"discovery_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"discovery_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    discoveryVC.tabBarItem = discoveryTBI;
    SGBaseNavigationController *discoveryNC = [[SGBaseNavigationController alloc] initWithRootViewController:discoveryVC];
    //商城
    SGMallViewController *mallVC = [[SGMallViewController alloc] init];
    UITabBarItem *mallTBI= [[UITabBarItem alloc] initWithTitle:@"商城" image:[[UIImage imageNamed:@"mall_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"mall_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mallVC.tabBarItem = mallTBI;
    SGBaseNavigationController *mallNC = [[SGBaseNavigationController alloc] initWithRootViewController:mallVC];
    //我的
    SGProfileViewController *myProfileVC = [[SGProfileViewController alloc] init];
    UITabBarItem *myProfileTBI = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"profile_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    myProfileVC.tabBarItem = myProfileTBI;
    SGBaseNavigationController *myProfileNC = [[SGBaseNavigationController alloc] initWithRootViewController:myProfileVC];
    
    NSArray *  controllerArray = [NSArray arrayWithObjects:homeNC,discoveryNC,mallNC,myProfileNC, nil];
    self.viewControllers = controllerArray;
    
}
#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
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
