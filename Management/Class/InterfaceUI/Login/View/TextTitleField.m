//
//  TextTitleField.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "TextTitleField.h"

@implementation TextTitleField

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
    [self titleLabel];
    [self textField];
}

#pragma mark - private method
-(void)setUnderLine
{
    [self underLine];
}

// 设置
-(void)setTitleWithText:(NSString *)title
{
    self.titleLabel.text = title;
}

-(void)setPlaceHolderText:(NSString *)placeHolder
{
    [_textField setPlaceholder:placeHolder];
}

-(void)setTextFieldSecureTextEntry
{
    _textField.secureTextEntry = YES;
}


#pragma mark - lazy load
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat width = 80.0f;
        CGFloat height = 14.0f;
        CGFloat x = 15.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14.0f];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = _titleLabel.frame.origin.x + _titleLabel.frame.size.width + 20.0f;
        CGFloat width = 200.0f;
        CGFloat height = 14.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
