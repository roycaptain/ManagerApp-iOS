//
//  ActualView.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ActualView.h"
#import "ActualLabel.h"
#import "ActualCircleView.h"
#import "DeviceModel.h"

@interface ActualView ()

@property(nonatomic,strong)ActualLabel *areaLabel; // 区域名称
@property(nonatomic,strong)ActualLabel *areaPathLabel; // 区域路径
@property(nonatomic,strong)ActualLabel *belongObjectLabel; // 所属对象
@property(nonatomic,strong)ActualLabel *linkmanLabel; // 联系人
@property(nonatomic,strong)ActualLabel *linkNumberLabel; // 联系方式

@property(nonatomic,strong)ActualCircleView *chargeView; // 累计充电量
@property(nonatomic,strong)ActualCircleView *incomeView; // 累计收入
@property(nonatomic,strong)ActualCircleView *timeView; // 累计充电次数

@end

@implementation ActualView

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
    [self areaLabel];
    [self areaPathLabel];
    [self belongObjectLabel];
    [self linkmanLabel];
    [self linkNumberLabel];
    
    [self chargeView];
    [self incomeView];
    [self timeView];
}

#pragma mark - private method
-(void)setActualDataWithDeviceModel:(DeviceModel *)model
{
    [_areaLabel setLabelTextWithTitle:@"站点名称: " withContent:model.stationName];
    [_areaPathLabel setLabelTextWithTitle:@"区域路径: " withContent:model.parentAreaName];
    [_belongObjectLabel setLabelTextWithTitle:@"所属对象: " withContent:model.homeTitle];
    [_linkmanLabel setLabelTextWithTitle:@"联系人: " withContent:model.companyName];
    [_linkNumberLabel setLabelTextWithTitle:@"联系方式: " withContent:model.mobile];
    
    [_chargeView setDetailLabelWithText:model.filedName];
    CGFloat data = [model.filed isEqualToString:@"ELECTRIC_BICYCLE"] ? model.totalChargeSeconds : model.chargeEnergyTotal;
    [_chargeView setDataLabelWithText:[NSString stringWithFormat:@"%.2f",data]]; // 累计充电量
    [_incomeView setDataLabelWithText:[NSString stringWithFormat:@"%.2f",model.elecFeeTotal]]; // 累计收入
    [_timeView setDataLabelWithText:[NSString stringWithFormat:@"%ld",(long)model.totalChargeTime]]; // 累计充电次数
}

#pragma mark - lazy load
-(UILabel *)areaLabel
{
    if (!_areaLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 15.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 16.0f;
        _areaLabel = [[ActualLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_areaLabel setLabelTextWithTitle:@"站点名称: " withContent:@"--"];
        [self addSubview:_areaLabel];
    }
    return _areaLabel;
}

-(ActualLabel *)areaPathLabel
{
    if (!_areaPathLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _areaLabel.frame.origin.y + _areaLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 16.0f;
        _areaPathLabel = [[ActualLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_areaPathLabel setLabelTextWithTitle:@"区域路径: " withContent:@"--"];
        [self addSubview:_areaPathLabel];
    }
    return _areaPathLabel;
}

-(ActualLabel *)belongObjectLabel
{
    if (!_belongObjectLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _areaPathLabel.frame.origin.y + _areaPathLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 16.0f;
        _belongObjectLabel = [[ActualLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_belongObjectLabel setLabelTextWithTitle:@"所属对象: " withContent:@"--"];
        [self addSubview:_belongObjectLabel];
    }
    return _belongObjectLabel;
}

-(ActualLabel *)linkmanLabel
{
    if (!_linkmanLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _belongObjectLabel.frame.origin.y + _belongObjectLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 16.0f;
        _linkmanLabel = [[ActualLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_linkmanLabel setLabelTextWithTitle:@"联系人: " withContent:@"--"];
        [self addSubview:_linkmanLabel];
    }
    return _linkmanLabel;
}

-(ActualLabel *)linkNumberLabel
{
    if (!_linkNumberLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _linkmanLabel.frame.origin.y + _linkmanLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 16.0f;
        _linkNumberLabel = [[ActualLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_linkNumberLabel setLabelTextWithTitle:@"联系方式: " withContent:@"--"];
        [self addSubview:_linkNumberLabel];
    }
    return _linkNumberLabel;
}

-(ActualCircleView *)chargeView
{
    if (!_chargeView) {
        CGFloat x = 30.0f;
        CGFloat y = _linkNumberLabel.frame.origin.y + _linkNumberLabel.frame.size.height + 10.0f;
        CGFloat height = 90.0f;
        CGFloat width = (self.frame.size.width - 110.0f) / 3;
        _chargeView = [[ActualCircleView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_chargeView setBackgroundImageWithImageName:@"circle_charge_cap"];
        [_chargeView setDataLabelWithText:@"--"];
        [_chargeView setDetailLabelWithText:@"累计充电量(kW/h)"];
        [self addSubview:_chargeView];
    }
    return _chargeView;
}

-(ActualCircleView *)incomeView
{
    if (!_incomeView) {
        CGFloat x = _chargeView.frame.origin.x + _chargeView.frame.size.width + 25.0f;
        CGFloat y = _chargeView.frame.origin.y;
        CGFloat height = 90.0f;
        CGFloat width = (self.frame.size.width - 110.0f) / 3;
        _incomeView = [[ActualCircleView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_incomeView setBackgroundImageWithImageName:@"circle_income"];
        [_incomeView setDataLabelWithText:@"--"];
        [_incomeView setDetailLabelWithText:@"累计收入(元)"];
        [self addSubview:_incomeView];
    }
    return _incomeView;
}

-(ActualCircleView *)timeView
{
    if (!_timeView) {
        CGFloat x = _incomeView.frame.origin.x + _incomeView.frame.size.width + 25.0f;
        CGFloat y = _chargeView.frame.origin.y;
        CGFloat height = 90.0f;
        CGFloat width = (self.frame.size.width - 110.0f) / 3;
        _timeView = [[ActualCircleView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_timeView setBackgroundImageWithImageName:@"circle_charge_time"];
        [_timeView setDataLabelWithText:@"--"];
        [_timeView setDetailLabelWithText:@"累计充电次数"];
        [self addSubview:_timeView];
    }
    return _timeView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
