//
//  SGDiscoveryListCell.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDiscoveryListCell.h"
#import <UIImageView+WebCache.h>

@interface SGDiscoveryListCell ()

@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation SGDiscoveryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutSubView];
    }
    return self;
}

- (void)layoutSubView
{
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo((kScreenSize.width-10)*0.75).priorityHigh();
    }];
}

- (UIImageView *)contentImageView
{
    SG_PROPERTY_LOCK(_contentImageView);
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    _contentImageView.backgroundColor = [UIColor lightGrayColor];
    SG_PROPERTY_UNLOCK();
    return _contentImageView;
}

- (void)setModel:(SGDiscoveryModel *)model
{
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

// If you are not using auto layout, override this method, enable it by setting
// "fd_enforceFrameLayout" to YES.
- (CGSize)sizeThatFits:(CGSize)size {
    size = CGSizeMake(kScreenSize.width-10, 0);
    CGFloat totalHeight = 0;
    totalHeight += (kScreenSize.width-10)*0.75;
    totalHeight += 10; // margins
    return CGSizeMake(size.width, totalHeight);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
