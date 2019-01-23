//
//  TextInputView.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "TextInputView.h"

@implementation TextInputView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self icon];
    [self textField];
}

#pragma mark - private method
// 设置分割线
-(void)setUnderLine
{
    [self underLine];
}

// 设置图标
-(void)setIconWithImageName:(NSString *)imageName
{
    _icon.image = [UIImage imageNamed:imageName];
}

// 设置默认输入文本
-(void)setPlaceHolderText:(NSString *)placeHolder
{
    [_textField setPlaceholder:placeHolder];
}

// 设置获取验证码按钮
-(void)setIdntifyCodeBtn
{
    [self identifyCodeBtn];
}

#pragma mark - lazy load
-(UIImageView *)icon
{
    if (!_icon) {
        CGFloat x = 30.0f;
        CGFloat y = 17.5f;
        CGFloat width = 19.0f;
        CGFloat height = 20.0f;
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_icon];
    }
    return _icon;
}

-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = _icon.frame.origin.x + _icon.frame.size.width + 9.0f;
        CGFloat y = 17.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 20.0f;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:_textField];
    }
    return _textField;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat width = self.frame.size.width;
        CGFloat height = 0.5f;
        CGFloat x = 0.0f;
        CGFloat y = self.frame.size.height - height;
        
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(UIButton *)identifyCodeBtn
{
    if (!_identifyCodeBtn) {
        CGFloat width = 100.0f;
        CGFloat height = 14.0f;
        CGFloat x = self.frame.size.width - width - 10.0f;
        CGFloat y = 20.0f;
        
        _identifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _identifyCodeBtn.frame = CGRectMake(x, y, width, height);
        [_identifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_identifyCodeBtn setTitleColor:[UIColor colorWithHexString:@"#3399FF"] forState:UIControlStateNormal];
        _identifyCodeBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:13.0f];
        [self addSubview:_identifyCodeBtn];
    }
    return _identifyCodeBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
