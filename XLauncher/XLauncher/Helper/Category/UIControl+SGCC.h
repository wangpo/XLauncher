//
//  UIButton+SGCC.h
//  SGCC
//
//  Created by wangpo on 2018/6/13.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(id sender);

@interface UIControl (SGCC)
@property (readonly) NSMutableDictionary *event;

- (void)sg_handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)actionBlock;

@end
