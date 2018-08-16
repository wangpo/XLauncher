//
//  UIApplication+SGCC.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "UIApplication+SGCC.h"

@implementation UIApplication (SGCC)

+ (BOOL)isAllowedNotification {
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != settings.types) {
        return YES;
    }
    return NO;
}

+ (BOOL)isAllowedOpenSetting
{
    return  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
