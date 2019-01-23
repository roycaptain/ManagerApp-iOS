//
//  SubUnitDetailView.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SubUnitDetailView.h"

@interface SubUnitDetailView ()

@property(nonatomic,strong)UILabel *subUnitLabel; // 子部件
@property(nonatomic,strong)UILabel *singleLabel; // 信号名
@property(nonatomic,strong)UILabel *timeLabel; // 时间点
@property(nonatomic,strong)UILabel *singleValueLabel; // 信号值

@end

@implementation SubUnitDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#35B5FF"];
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self subUnitLabel];
    [self singleLabel];
    [self timeLabel];
    [self singleValueLabel];
}

#pragma mark - private method
-(void)setSubUnitName:(NSString *)subUnitName withSingalName:(NSString *)singalName withTime:(NSString *)time withSingalValue:(NSString *)singalValue
{
    _subUnitLabel.attributedText = [self setNormalLabelWithTitle:@"子部件: " withContent:subUnitName];
    _singleLabel.attributedText = [self setNormalLabelWithTitle:@"信号名: " withContent:singalName];
    _timeLabel.attributedText = [self setNormalLabelWithTitle:@"时间点: " withContent:time];
    _singleValueLabel.attributedText = [self setNormalLabelWithTitle:@"信号值: " withContent:singalValue];
}

-(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

#pragma mark - lazy load
-(UILabel *)subUnitLabel
{
    if (!_subUnitLabel) {
        CGFloat x = 10.0f;
        CGFloat y = 10.0f;
        CGFloat wdith = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 12.0f;
        _subUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        _subUnitLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_subUnitLabel];
    }
    return _subUnitLabel;
}

-(UILabel *)singleLabel
{
    if (!_singleLabel) {
        CGFloat x = _subUnitLabel.frame.origin.x + _subUnitLabel.frame.size.width;
        CGFloat y = 10.0f;
        CGFloat width = _subUnitLabel.frame.size.width;
        CGFloat height = 12.0f;
        _singleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _singleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_singleLabel];
    }
    return _singleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        CGFloat x = 10.0f;
        CGFloat y = _subUnitLabel.frame.origin.y + _subUnitLabel.frame.size.height + 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 12.0f;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UILabel *)singleValueLabel
{
    if (!_singleValueLabel) {
        CGFloat x = _timeLabel.frame.origin.x + _timeLabel.frame.size.width;
        CGFloat y = _timeLabel.frame.origin.y;
        CGFloat width = _timeLabel.frame.size.width;
        CGFloat height = 12.0f;
        _singleValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _singleValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_singleValueLabel];
    }
    return _singleValueLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
