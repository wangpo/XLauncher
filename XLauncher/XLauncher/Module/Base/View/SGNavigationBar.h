//
//  SGNavigationBar.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNavigationBar : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) id  target;
@property (nonatomic, assign) SEL action;

/**
 *  自定义导航条
 *
 *  @param target 父类控制器
 *
 */

+ (instancetype)navigationBarWithTarget:(id)target;
/**
 *  设置标题
 */
- (void)setNavTitle:(NSString *)title;

/**
 *  设置标题以及左边返回按钮
 */
- (void)setNavTitle:(NSString *)title backAction:(SEL)action;

@end
