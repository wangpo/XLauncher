//
//  SGAppDelegate.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGAppDelegate.h"
#import "SGAppearance.h"
#import "SGSDKRegisterManager.h"

SGAppDelegate *AppDelegate;

@interface SGAppDelegate ()<UITabBarControllerDelegate>

@end

@implementation SGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AppDelegate = self;
    //解决6p横屏启动画面错乱问题
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    //UI框架特征
    [[SGAppearance defaultAppearance] setup];
    //注册第三方sdk
    [SGSDKRegisterManager registerAllSdkInfoWithLaunchOptions:launchOptions];
    //初始化页面框架
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (SGBaseTabBarController *)mainController
{
    SG_PROPERTY_LOCK(_mainController);
    _mainController = [[SGBaseTabBarController alloc] init];
    _mainController.delegate = self;
    SG_PROPERTY_UNLOCK();
    return _mainController;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //TODO:tab点击回调
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
