//
//  SubUnitFillterView.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SubUnitFillterView.h"
#import "FillterButton.h"

@interface SubUnitFillterView ()

@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UILabel *titleLabel; // 子部件筛选列表
@property(nonatomic,strong)UILabel *underLineLabel; // 分割线
@property(nonatomic,strong)UILabel *subUnitName; // 子部件名称
@property(nonatomic,strong)UILabel *singleType; // 信号类型
@property(nonatomic,strong)UILabel *underLine;
@property(nonatomic,strong)UILabel *intervalLabel; // 时间区间
@property(nonatomic,strong)UILabel *beginLabel; // 开始时间
@property(nonatomic,strong)UILabel *endLabel; // 结束时间

@property(nonatomic,strong)FillterButton *subUnitButton; // 子部件
@property(nonatomic,strong)FillterButton *singleTypeButton; // 信号类型
@property(nonatomic,strong)FillterButton *beginButton; // 开始时间
@property(nonatomic,strong)FillterButton *endButton; // 结束时间

@property(nonatomic,strong)UIButton *resetButton; // 重置按钮
@property(nonatomic,strong)UIButton *sureButton; // 确定按钮

@end

@implementation SubUnitFillterView

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
    [self underLineLabel];
    [self subUnitName];
    [self singleType];
    [self underLine];
    [self intervalLabel];
    [self beginLabel];
    [self endLabel];
    
    [self subUnitButton];
    [self singleTypeButton];
    [self beginButton];
    [self endButton];
    
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
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self]) {
        [self dismissFilterView];
    }
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
        _titleLabel.text = @"子部件列表筛选:";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [_baseView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)underLineLabel
{
    if (!_underLineLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 15.0f;
        CGFloat width = _baseView.frame.size.width;
        CGFloat height = 0.5f;
        _underLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLineLabel.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_baseView addSubview:_underLineLabel];
    }
    return _underLineLabel;
}

// 子部件名称
-(UILabel *)subUnitName
{
    if (!_subUnitName) {
        CGFloat x = 0.0f;
        CGFloat y = _underLineLabel.frame.origin.y + _underLineLabel.frame.size.height + 30.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _subUnitName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _subUnitName.text = @"子部件名称";
        _subUnitName.textAlignment = NSTextAlignmentCenter;
        _subUnitName.font = [UIFont systemFontOfSize:16.0f];
        _subUnitName.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_subUnitName];
    }
    return _subUnitName;
}

-(FillterButton *)subUnitButton
{
    if (!_subUnitButton) {
        CGFloat x = _subUnitName.frame.origin.x + _subUnitName.frame.size.width;
        CGFloat y = _subUnitName.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _subUnitButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_subUnitButton setHeadTitleWithText:@"不限"];
//        [_subUnitButton addTarget:self action:@selector(subUnitClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_subUnitButton];
    }
    return _subUnitButton;
}

// 信号类型
-(UILabel *)singleType
{
    if (!_singleType) {
        CGFloat x = 0.0f;
        CGFloat y = _subUnitName.frame.origin.y + _subUnitName.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _singleType = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _singleType.text = @"信号类型";
        _singleType.textAlignment = NSTextAlignmentCenter;
        _singleType.font = [UIFont systemFontOfSize:16.0f];
        _singleType.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_singleType];
    }
    return _singleType;
}

-(FillterButton *)singleTypeButton
{
    if (!_singleTypeButton) {
        CGFloat x = _singleType.frame.origin.x + _singleType.frame.size.width;
        CGFloat y = _singleType.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _singleTypeButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_singleTypeButton setHeadTitleWithText:@"输出电流"];
//        [_singleTypeButton addTarget:self action:@selector(subUnitClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_singleTypeButton];
    }
    return _singleTypeButton;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _singleType.frame.origin.y + _singleType.frame.size.height + 20.0f;
        CGFloat width = _baseView.frame.size.width;
        CGFloat height = 0.5;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_baseView addSubview:_underLine];
    }
    return _underLine;
}

-(UILabel *)intervalLabel
{
    if (!_intervalLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _underLine.frame.origin.y + _underLine.frame.size.height + 15.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _intervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _intervalLabel.text = @"时间区间:";
        _intervalLabel.textAlignment = NSTextAlignmentCenter;
        _intervalLabel.font = [UIFont systemFontOfSize:16.0f];
        _intervalLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_intervalLabel];
    }
    return _intervalLabel;
}

-(UILabel *)beginLabel
{
    if (!_beginLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _intervalLabel.frame.origin.y + _intervalLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _beginLabel.text = @"开始时间";
        _beginLabel.textAlignment = NSTextAlignmentCenter;
        _beginLabel.font = [UIFont systemFontOfSize:16.0f];
        _beginLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_beginLabel];
    }
    return _beginLabel;
}

-(FillterButton *)beginButton
{
    if (!_beginButton) {
        CGFloat x = _beginLabel.frame.origin.x + _beginLabel.frame.size.width;
        CGFloat y = _beginLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _beginButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_beginButton setHeadTitleWithText:@"不限"];
//        [_beginButton addTarget:self action:@selector(subUnitClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_beginButton];
    }
    return _beginButton;
}

-(UILabel *)endLabel
{
    if (!_endLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _beginLabel.frame.origin.y + _beginLabel.frame.size.height + 25.0f;
        CGFloat width = 90.0f;
        CGFloat height = 44.0f;
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _endLabel.text = @"结束时间";
        _endLabel.textAlignment = NSTextAlignmentCenter;
        _endLabel.font = [UIFont systemFontOfSize:16.0f];
        _endLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_baseView addSubview:_endLabel];
    }
    return _endLabel;
}

-(FillterButton *)endButton
{
    if (!_endButton) {
        CGFloat x = _endLabel.frame.origin.x + _endLabel.frame.size.width;
        CGFloat y = _endLabel.frame.origin.y;
        CGFloat width = _baseView.frame.size.width - x - 26.0f;
        CGFloat height = 44.0f;
        _endButton = [[FillterButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_endButton setHeadTitleWithText:@"不限"];
//        [_endButton addTarget:self action:@selector(subUnitClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_endButton];
    }
    return _endButton;
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
//        [_resetButton addTarget:self action:@selector(resetClickAction) forControlEvents:UIControlEventTouchUpInside];
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
//        [_sureButton addTarget:self action:@selector(sureClickAction) forControlEvents:UIControlEventTouchUpInside];
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
