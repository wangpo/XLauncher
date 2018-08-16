//
//  SGNetworkErrorView.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNetworkErrorView : UIView
@property (nonatomic, copy) void(^tapHandler)(void);
-(void)setTitleText:(NSString *)titleText;
@end
