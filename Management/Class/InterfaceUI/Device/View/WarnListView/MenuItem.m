//
//  MenuItem.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UIImageView *iconImageView;

@end

@implementation MenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self headLabel];
    [self iconImageView];
}

#pragma mark - private method
-(void)setHeadLabelTitle:(NSString *)text
{
    _headLabel.text = text;
}

-(void)setItemSelectState:(BOOL)isSelect
{
    __weak typeof(self) weakSelf = self;
    self.selected = isSelect;
    [UIView animateWithDuration:0.5f animations:^{
        if (weakSelf.selected) {
            weakSelf.headLabel.textColor = [UIColor colorWithHexString:@"#3399FF"];
            weakSelf.iconImageView.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            weakSelf.headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            weakSelf.iconImageView.transform = CGAffineTransformMakeRotation(0.0f);
        }
    } completion:NULL];
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat width = 60.0f;
        CGFloat height = 13.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        CGFloat y = (self.frame.size.height - height) / 2;
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.font = [UIFont systemFontOfSize:13.0f];
        _headLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        CGFloat width = 7.0f;
        CGFloat height = 5.0f;
        CGFloat x = _headLabel.frame.origin.x + _headLabel.frame.size.width;
        CGFloat y = (self.frame.size.height - height) / 2;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_iconImageView setImage:[UIImage imageNamed:@"icon_drop_menu"]];
//        _iconImageView.transform = CGAffineTransformMakeRotation(M_PI);
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

@end
