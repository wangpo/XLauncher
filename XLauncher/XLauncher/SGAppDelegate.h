//
//  SGAppDelegate.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGBaseTabBarController.h"

@interface SGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SGBaseTabBarController  *mainController;

@end

extern SGAppDelegate *AppDelegate;
