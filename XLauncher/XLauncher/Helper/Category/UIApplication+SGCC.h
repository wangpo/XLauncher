//
//  UIApplication+SGCC.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SGCC)

+ (BOOL)isAllowedNotification;
+ (BOOL)isAllowedOpenSetting;

@end
