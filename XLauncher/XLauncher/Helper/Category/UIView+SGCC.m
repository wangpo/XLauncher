//
//  UIView+SGCC.m
//  WPDevelopProject
//
//  Created by wangpo on 2018/6/19.
//  Copyright © 2018年 BaoFeng. All rights reserved.
//

#import "UIView+SGCC.h"

@implementation UIView (SGCC)

- (UIViewController *)viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
