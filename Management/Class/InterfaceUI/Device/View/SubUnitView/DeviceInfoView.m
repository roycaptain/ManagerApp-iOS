//
//  DeviceInfoView.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceInfoView.h"

@interface DeviceInfoView ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *underLine;
@property(nonatomic,strong)UILabel *deviceName; // 设备名称
@property(nonatomic,strong)UILabel *devicePath; // 设备路径

@end

@implementation DeviceInfoView

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
    [self titleLabel];
    [self underLine];
    [self deviceName];
    [self devicePath];
}

#pragma mark - private method
-(void)setDeviceName:(NSString *)deviceName withParentAreaName:(NSString *)parentAreaName
{
    _deviceName.attributedText = [self setNormalLabelWithTitle:@"设备名称: " withContent:deviceName];
    _devicePath.attributedText = [self setNormalLabelWithTitle:@"设备路径: " withContent:parentAreaName];
}

-(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

#pragma mark - lazy load
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 15.0f;
        CGFloat width = 100.0f;
        CGFloat height = 15.0f;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.text = @"设备信息";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 15.0f;;
        CGFloat wdith = self.frame.size.width;
        CGFloat height = 0.5;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(UILabel *)deviceName
{
    if (!_deviceName) {
        CGFloat x = 15.0f;
        CGFloat y = _underLine.frame.origin.y + _underLine.frame.size.height + 15.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 13.0f;
        _deviceName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_deviceName];
    }
    return _deviceName;
}

-(UILabel *)devicePath
{
    if (!_devicePath) {
        CGFloat x = 15.0f;
        CGFloat y = _deviceName.frame.origin.y + _deviceName.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 13.0f;
        _devicePath = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _devicePath.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_devicePath];
    }
    return _devicePath;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
