//
//  FillterButton.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "FillterButton.h"

@interface FillterButton ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *contentLabel;

@end

@implementation FillterButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self iconImageView];
    [self contentLabel];
}

#pragma mark - private method
-(void)setHeadTitleWithText:(NSString *)title
{
    _contentLabel.text = title;
}

#pragma mark - lazy load
-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        CGFloat width = 20.0f;
        CGFloat height = 10.0f;
        CGFloat x = self.frame.size.width - width - 10.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _iconImageView.image = [UIImage imageNamed:@"icon_accessory_down"];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width - _iconImageView.frame.size.width;
        CGFloat height = self.frame.size.height;
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
