//
//  FillterView.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "FillterView.h"
#import "FillterButton.h"

@interface FillterView ()

@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UILabel *titleLabel; // 设备列表筛选
@property(nonatomic,strong)UILabel *underLine; // 分割线
@property(nonatomic,strong)UILabel *deviceNameLabel; // 设备名称
@property(nonatomic,strong)UILabel *deviceNumberLabel; // 设备编号
@property(nonatomic,strong)UILabel *onlineLabel; // 是否在线
@property(nonatomic,strong)UILabel *chargeLabel; // 是否充电
@property(nonatomic,strong)UILabel *warnLabel; //是否告警

@property(nonatomic,strong)UITextField *deviceNameField;
@property(nonatomic,strong)UITextField *deviceNumField;

@property(nonatomic,strong)FillterButton *onlineButton; // 在线按钮
@property(nonatomic,strong)FillterButton *chargeButton; // 充电按钮
@property(nonatomic,strong)FillterButton *warnButton;
@property(nonatomic,strong)FillterButton *alertButton;

@property(nonatomic,strong)UIButton *resetButton; // 重置按钮
@property(nonatomic,strong)UIButton *sureButton; // 确定按钮

@end

@implementation FillterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor colorWithHexString:@"#12131A"] colorWithAlphaComponent:0.6f];
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self baseView];
    [self titleLabel];
    [self underLine];
    [self deviceNameLabel];
    [self deviceNumberLabel];
    [self onlineLabel];
    [self chargeLabel];
    [self warnLabel];
    
    [self deviceNameField];
    [self deviceNumField];
    
    [self onlineButton];
    [self chargeButton];
    [self warnButton];
    [self alertButton];
    
    [self resetButton];
    [self sureButton];
}

#pragma mark - private method
-(void)presentFillterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.frame = CGRectMake(0.0f, [GeneralSize getStatusBarHeight], [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight]);
    }];
}

-(void)dismissFilterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.frame = CGRectMake([GeneralSize getMainScreenWidth], [GeneralSize getStatusBarHeight], [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight]);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self]) {
        [self dismissFilterView];
    }
}

#pragma mark - click action
// 是否在线
-(void)onlineAction
{
    NSLog(@"是否在线");
}

// 是否充电
-(void)chargeAction
{
    NSLog(@"是否充电");
}

// 是否告警
-(void)warnAction
{
    NSLog(@"是否告警");
}

-(void)alertClickAction
{
    NSLog(@"点击提示");
}

// 重置
-(void)resetClickAction
{
    NSLog(@"重置");
}

// 确定
-(void)sureClickAction
{
    NSLog(@"确定");
}

#pragma mark - lazy load
-(UIView *)baseView
{
    if (!_baseView) {
        CGFloat x = 50.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = self.frame.size.height;
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 30.0f;
        CGFloat width = 120.0f;
        CGFloat height = 17.0f;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.text = @"设备列表筛选:";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_baseView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 15.0f;
        CGFloat width = _baseView.frame.size.width;
        CGFloat height = 0.5f;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_baseView addSubview:_underLine];
    }
    return _underLine;
}

// 设备名称
-(UILabel *)deviceNameLabel
{
    if (!_deviceNameLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _underLine.frame.origin.y + _underLine.frame.size.height + 30.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceNameLabel.text = @"设备名称";
        _deviceNameLabel.textAlignment = NSTextAlignmentCenter;
        _deviceNameLabel.font = [UIFont systemFontOfSize:16.0f];
        _deviceNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_deviceNameLabel];
    }
    return _deviceNameLabel;
}

-(UITextField *)deviceNameField
{
    if (!_deviceNameField) {
        CGFloat x = _deviceNameLabel.frame.origin.x + _deviceNameLabel.frame.size.width;
        CGFloat y = _deviceNameLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _deviceNameField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceNameField.borderStyle = UITextBorderStyleRoundedRect;
        _deviceNameField.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
        [_baseView addSubview:_deviceNameField];
    }
    return _deviceNameField;
}

// 设备编号
-(UILabel *)deviceNumberLabel
{
    if (!_deviceNumberLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _deviceNameLabel.frame.origin.y + _deviceNameLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _deviceNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceNumberLabel.text = @"设备编号";
        _deviceNumberLabel.textAlignment = NSTextAlignmentCenter;
        _deviceNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        _deviceNumberLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_deviceNumberLabel];
    }
    return _deviceNumberLabel;
}

-(UITextField *)deviceNumField
{
    if (!_deviceNumField) {
        CGFloat x = _deviceNumberLabel.frame.origin.x + _deviceNumberLabel.frame.size.width;
        CGFloat y = _deviceNumberLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _deviceNumField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceNumField.borderStyle = UITextBorderStyleRoundedRect;
        _deviceNumField.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
        [_baseView addSubview:_deviceNumField];
    }
    return _deviceNumField;
}

// 是否在线
-(UILabel *)onlineLabel
{
    if (!_onlineLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _deviceNumberLabel.frame.origin.y + _deviceNumberLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _onlineLabel.text = @"是否在线";
        _onlineLabel.textAlignment = NSTextAlignmentCenter;
        _onlineLabel.font = [UIFont systemFontOfSize:16.0f];
        _onlineLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_onlineLabel];
    }
    return _onlineLabel;
}

-(FillterButton *)onlineButton
{
    if (!_onlineButton) {
        CGFloat x = _onlineLabel.frame.origin.x + _onlineLabel.frame.size.width;
        CGFloat y = _onlineLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _onlineButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_onlineButton setHeadTitleWithText:@"不限"];
        [_onlineButton addTarget:self action:@selector(onlineAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_onlineButton];
    }
    return _onlineButton;
}

// 是否充电
-(UILabel *)chargeLabel
{
    if (!_chargeLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _onlineLabel.frame.origin.y + _onlineLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _chargeLabel.text = @"是否充电";
        _chargeLabel.textAlignment = NSTextAlignmentCenter;
        _chargeLabel.font = [UIFont systemFontOfSize:16.0f];
        _chargeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_chargeLabel];
    }
    return _chargeLabel;
}

-(FillterButton *)chargeButton
{
    if (!_chargeButton) {
        CGFloat x = _chargeLabel.frame.origin.x + _chargeLabel.frame.size.width;
        CGFloat y = _chargeLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _chargeButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_chargeButton setHeadTitleWithText:@"充电中"];
        [_chargeButton addTarget:self action:@selector(chargeAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_chargeButton];
    }
    return _chargeButton;
}

// 是否告警
-(UILabel *)warnLabel
{
    if (!_warnLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _chargeLabel.frame.origin.y + _chargeLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnLabel.text = @"是否告警";
        _warnLabel.textAlignment = NSTextAlignmentCenter;
        _warnLabel.font = [UIFont systemFontOfSize:16.0f];
        _warnLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_warnLabel];
    }
    return _warnLabel;
}

-(FillterButton *)warnButton
{
    if (!_warnButton) {
        CGFloat x = _warnLabel.frame.origin.x + _warnLabel.frame.size.width;
        CGFloat y = _warnLabel.frame.origin.y;
        CGFloat width = (_baseView.frame.size.width - x - 26.0f) / 2;
        CGFloat height = 44.0f;
        _warnButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_warnButton setHeadTitleWithText:@"是"];
        [_warnButton addTarget:self action:@selector(warnAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_warnButton];
    }
    return _warnButton;
}

-(FillterButton *)alertButton
{
    if (!_alertButton) {
        CGFloat x = _warnButton.frame.origin.x + _warnButton.frame.size.width + 10.0f;
        CGFloat y = _warnLabel.frame.origin.y;
        CGFloat width = _warnButton.frame.size.width;
        CGFloat height = 44.0f;
        _alertButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_alertButton setHeadTitleWithText:@"提示"];
        [_alertButton addTarget:self action:@selector(alertClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_alertButton];
    }
    return _alertButton;
}

-(UIButton *)resetButton
{
    if (!_resetButton) {
        CGFloat width = _baseView.frame.size.width / 2;
        CGFloat height = 49.0f;
        CGFloat x = 0.0f;
        CGFloat y = self.frame.size.height - height;
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.frame = CGRectMake(x, y, width, height);
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_resetButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_reset"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_resetButton];
    }
    return _resetButton;
}

-(UIButton *)sureButton
{
    if (!_sureButton) {
        CGFloat width = _baseView.frame.size.width / 2;
        CGFloat height = 49.0f;
        CGFloat x = _resetButton.frame.origin.x + _resetButton.frame.size.width;
        CGFloat y = _resetButton.frame.origin.y;
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(x, y, width, height);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"sure_btn_bg"] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_sureButton];
    }
    return _sureButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
