//
//  SGNetworkErrorView.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNetworkErrorView.h"

@interface SGNetworkErrorView ()
@property(nonatomic,strong)  UIImageView  *imageView;
@property(nonatomic,strong)  UILabel      *titleLabel;
@property(nonatomic,strong)  UILabel      *contentLabel;
@end

@implementation SGNetworkErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (handleTap:)];
        [self addGestureRecognizer: tapGestureRecognizer];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 75));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-90);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView.mas_bottom).offset(20);
            make.width.equalTo(self);
            make.height.mas_equalTo(16);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.width.equalTo(self);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}

- (void)handleTap: (id) sender {
    if (self.tapHandler) {
        self.tapHandler ();
    }
}

-(void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
}

- (UIImageView *)imageView
{
    SG_PROPERTY_LOCK(_imageView);
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"netError_default"];
    SG_PROPERTY_UNLOCK();
    return _imageView;
}

- (UILabel *)titleLabel {
    SG_PROPERTY_LOCK(_titleLabel);
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithRGB:0x555555];
    _titleLabel.text = @"网络开了小差";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    SG_PROPERTY_UNLOCK();
    return _titleLabel;
}

- (UILabel *)contentLabel {
    SG_PROPERTY_LOCK(_contentLabel);
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor colorWithRGB:0x555555];
    _contentLabel.text = @"请点击页面刷新";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    SG_PROPERTY_UNLOCK();
    return _contentLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
