//
//  UIViewController+DismissKeyboard.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DismissKeyboard)

//该方法可加在RootViewController的viewDidLoad中
- (void)setupForDismissKeyboard;

@end
