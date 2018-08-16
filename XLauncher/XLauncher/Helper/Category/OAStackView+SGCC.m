//
//  OAStackView+SGCC.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "OAStackView+SGCC.h"

@implementation OAStackView (SGCC)

- (void)removeAllArrangedSubviews {
    for (UIView * subview in self.arrangedSubviews) {
        [self removeArrangedSubview:subview];
    }
}

@end
