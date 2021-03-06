//
//  UIScrollView+Placeholder.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "UIScrollView+Placeholder.h"

@implementation UIScrollView (Placeholder)

- (void)placeholderImage:(UIImage *)image title:(NSString *)title
{
    [self placeholderImage:image title:title offsetY:0];
}

- (void)placeholderImage:(UIImage *)image title:(NSString *)title offsetY:(CGFloat)offsetY
{
    if (!self.didSetup){
        self.didSetup = YES;
        self.placeholderView = [[UITableViewPlaceholderView alloc] initWithImage:image title:title offsetY:offsetY];
        [self addSubview:self.placeholderView];
    } else {
        self.placeholderView.placeholderImageView.image = image;
        self.placeholderView.placeholderLabel.text = title;
        self.placeholderView.offsetY = offsetY;
    }
    
    self.placeholderView.frame = (CGRect){CGPointZero,self.bounds.size};
}
- (void)removePlaceholder
{
    self.didSetup = NO;
    [self.placeholderView removeFromSuperview];
}

- (void)setDidSetup:(BOOL)didSetup
{
    objc_setAssociatedObject(self, @"didSetup", @(didSetup), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)didSetup
{
    return [objc_getAssociatedObject(self, @"didSetup") boolValue];
}

// placeholder view
- (void)setPlaceholderView:(UITableViewPlaceholderView *)placeholderView
{
    objc_setAssociatedObject(self, @"placeholderView", placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITableViewPlaceholderView *)placeholderView
{
    return objc_getAssociatedObject(self, @"placeholderView");
}
@end



@implementation UITableViewPlaceholderView

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title offsetY:(CGFloat)offsetY
{
    self = [super init];
    if (self) {
        self.placeholderImageView = [[UIImageView alloc] initWithImage:image];
        self.placeholderLabel     = [UILabel new];
        self.placeholderLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
        self.placeholderLabel.font = [UIFont systemFontOfSize:15];
        self.placeholderLabel.text = title;
        self.offsetY = offsetY;
        [self addSubview:_placeholderImageView];
        [self addSubview:_placeholderLabel];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat maxHeight = 0;
    if (_placeholderImageView.image) {
        maxHeight += _placeholderImageView.image.size.height;
    }
    
    CGSize textSize = CGSizeZero;
    if (_placeholderLabel.text.length) {
        NSString *text = _placeholderLabel.text;
        textSize = [text sizeWithAttributes:@{NSFontAttributeName:_placeholderLabel.font}];
        maxHeight += textSize.height;
    }
    
    CGFloat offset = 0;
    if (_placeholderImageView.image && _placeholderLabel.text.length) {
        offset = 15;
    }
    maxHeight += offset;
    
    _placeholderImageView.frame = CGRectMake((CGRectGetMaxX(self.frame)-_placeholderImageView.image.size.width)/2,
                                             (CGRectGetMaxY(self.frame)-maxHeight)/2 + _offsetY,
                                             _placeholderImageView.image.size.width,
                                             _placeholderImageView.image.size.height);
    _placeholderLabel.frame = CGRectMake(0,
                                         CGRectGetMaxY(_placeholderImageView.frame) + offset,
                                         textSize.width,
                                         textSize.height);
    CGPoint center = _placeholderLabel.center;
    center.x = self.center.x;
    _placeholderLabel.center = center;
}

@end
