//
//  AccessoryButton.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "AccessoryButton.h"

@interface AccessoryButton ()

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UIImageView *accessoryType;
@property(nonatomic,strong)UILabel *underLine;

@end

@implementation AccessoryButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self headLabel];
    [self accessoryType];
    [self underLine];
}

#pragma mark -private method
-(void)setButtonLeftTitleWithText:(NSString *)title
{
    _headLabel.text = title;
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat width = 150.0f;
        CGFloat height = 18.0f;
        CGFloat x = 15.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(UIImageView *)accessoryType
{
    if (!_accessoryType) {
        CGFloat width = 10.0f;
        CGFloat height = 20.0f;
        CGFloat x = self.frame.size.width - 15.0f - width;
        CGFloat y = (self.frame.size.height - height) / 2;
        
        _accessoryType = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _accessoryType.contentMode = UIViewContentModeScaleAspectFill;
        _accessoryType.image = [UIImage imageNamed:@"mine_accessory"];
        [self addSubview:_accessoryType];
    }
    return _accessoryType;
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

@end
