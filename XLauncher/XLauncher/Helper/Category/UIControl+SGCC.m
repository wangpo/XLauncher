//
//  UIButton+SGCC.m
//  SGCC
//
//  Created by wangpo on 2018/6/13.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "UIControl+SGCC.h"

@implementation UIControl (SGCC)
static char overviewKey;
@dynamic event;

- (void)sg_handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)actionBlock
{
    objc_setAssociatedObject(self, &overviewKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
}

- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
    }
}
@end
