//
//  SGNavigationBar.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNavigationBar.h"

@implementation SGNavigationBar

+ (instancetype)navigationBarWithTarget:(id)target
{
    SGNavigationBar *navBarView = [[SGNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SGFullScreenWidth, SGNavBarHeight)  target:target];
    return navBarView;
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGB:0x006CDC];
        
        CGFloat maxTitleWidth = SGFullScreenWidth * 5 / 7;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SGFullScreenWidth/7, SGStatusBarHeight, maxTitleWidth, SGNavBarHeight - SGStatusBarHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"";
        [self addSubview:_titleLabel];
        
        self.target = target;
    }
    return self;
}

- (void)setNavTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setNavTitle:(NSString *)title backAction:(SEL)action
{
    _titleLabel.text = title;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (action == nil) {
        action = @selector(backButtonClicked);
    }
    [[backButton imageView] setContentMode:UIViewContentModeCenter];
    [backButton setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateHighlighted];
    [backButton addTarget:self.target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(self).offset(SGStatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(33, 41));
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
