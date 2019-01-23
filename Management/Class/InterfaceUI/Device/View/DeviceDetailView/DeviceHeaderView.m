//
//  DeviceHeaderView.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceHeaderView.h"
#import "AAChartKit.h"

@interface DeviceHeaderView ()

@property(nonatomic,strong)UILabel *deviceLabel; // 设备名称
@property(nonatomic,strong)UILabel *devicePathLabel; // 设备路径
@property(nonatomic,strong)UILabel *underLine; // 分割线
@property(nonatomic,strong)UILabel *warnLabel; // 告警数据
@property(nonatomic,strong)UILabel *warnDataLabel; // 产生告警总次数

@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UILabel *subUnitLabel; // 子部件列表
@property(nonatomic,strong)UIButton *fillterButton; // 筛选按钮
@property(nonatomic,strong)UILabel *cutLabel; // 分割线

@end

@implementation DeviceHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
//        self.layer.masksToBounds = YES;
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self deviceLabel];
    [self devicePathLabel];
    [self underLine];
    [self warnLabel];
    [self warnDataLabel];
    [self aaChartView];
    [self aaChartModel];
    [self backgroundView];
    [self containerView];
    [self subUnitLabel];
    [self fillterButton];
    [self cutLabel];
}

#pragma mark - private method
-(void)setDeviceName:(NSString *)deviceName andParentAreaName:(NSString *)parentAreaName
{
    _deviceLabel.attributedText = [self setNormalLabelWithTitle:@"设备名称: " withContent:deviceName];
    _devicePathLabel.attributedText = [self setNormalLabelWithTitle:@"设备路径: " withContent:parentAreaName];
}

-(void)setWarnCount:(NSString *)warnCount andCategories:(NSArray *)categories andData:(NSArray *)data
{
    _warnDataLabel.attributedText = [self setWarnLabelWithContent:warnCount];
    
    _aaChartModel = _aaChartModel
    .chartTypeSet(AAChartTypeBar)
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"")
//    .yAxisVisibleSet(false)
    .categoriesSet(categories)
    .dataLabelEnabledSet(YES)
    .seriesSet(@[
                 AASeriesElement.new
                 .showInLegendSet(false)
                 .nameSet(@"")
                 .dataSet(data)
                 ]);
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
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

-(NSAttributedString *)setWarnLabelWithContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:@"产生告警总次数: "];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#3399FF"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

-(void)setFillterClickWithTarget:(id)target withAction:(SEL)buttonAction
{
    [_fillterButton addTarget:target action:buttonAction forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - lazy load
-(UILabel *)deviceLabel
{
    if (!_deviceLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 17.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 13.0f;
        _deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_deviceLabel];
    }
    return _deviceLabel;
}

-(UILabel *)devicePathLabel
{
    if (!_devicePathLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _deviceLabel.frame.origin.y + _deviceLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 13.0f;
        _devicePathLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _devicePathLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_devicePathLabel];
    }
    return _devicePathLabel;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _devicePathLabel.frame.origin.y + _devicePathLabel.frame.size.height + 10.0f;
        CGFloat wdith = self.frame.size.width;
        CGFloat height = 0.5;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(UILabel *)warnLabel
{
    if (!_warnLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _underLine.frame.origin.y + _underLine.frame.size.height + 10.0f;
        CGFloat width = 100.0f;
        CGFloat height = 17.0f;
        _warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnLabel.textAlignment = NSTextAlignmentLeft;
        _warnLabel.text = @"告警数据";
        _warnLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:_warnLabel];
    }
    return _warnLabel;
}

-(UILabel *)warnDataLabel
{
    if (!_warnDataLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _warnLabel.frame.origin.y + _warnLabel.frame.size.height + 10.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 14.0f;
        _warnDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnDataLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_warnDataLabel];
    }
    return _warnDataLabel;
}

-(AAChartView *)aaChartView
{
    if (!_aaChartView) {
        CGFloat x = 0.0f;
        CGFloat y = _warnDataLabel.frame.origin.y + _warnDataLabel.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width;
        CGFloat height = 135.0f;
        
        _aaChartView = [[AAChartView alloc] init];
        _aaChartView.frame = CGRectMake(x, y, width, height);
        [self addSubview:_aaChartView];
    }
    return _aaChartView;
}

-(AAChartModel *)aaChartModel
{
    if (!_aaChartModel) {
        _aaChartModel = [[AAChartModel alloc] init];
    }
    return _aaChartModel;
}

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        CGFloat width = self.frame.size.width;
        CGFloat height = 41.0f;
        CGFloat x = 0.0f;
        CGFloat y = _aaChartView.frame.origin.y + _aaChartView.frame.size.height;
        _backgroundView = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _backgroundView.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

-(UIView *)containerView
{
    if (!_containerView) {
        CGFloat x = 0.0f;
        CGFloat y = 10.0f;
        CGFloat width = _backgroundView.frame.size.width;
        CGFloat height = 40.0f;
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.userInteractionEnabled = YES;
        [_backgroundView addSubview:_containerView];
    }
    return _containerView;
}

-(UILabel *)subUnitLabel
{
    if (!_subUnitLabel) {
        CGFloat x = 16.0f;
        CGFloat y = 10.0f;
        CGFloat width = 100.0f;
        CGFloat height = 15.0f;
        _subUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _subUnitLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _subUnitLabel.text = @"子部件列表";
        _subUnitLabel.font = [UIFont systemFontOfSize:15.0f];
        _subUnitLabel.textAlignment = NSTextAlignmentLeft;
        [_containerView addSubview:_subUnitLabel];
    }
    return _subUnitLabel;
}

-(UIButton *)fillterButton
{
    if (!_fillterButton) {
        CGFloat width = 80.0f;
        CGFloat height = 35.0f;
        CGFloat x = _containerView.frame.size.width - width;
        CGFloat y = 0.0f;
        _fillterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fillterButton.frame = CGRectMake(x, y, width, height);
        _fillterButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_fillterButton setTitle:@"筛选" forState:UIControlStateNormal];
        [_fillterButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_containerView addSubview:_fillterButton];
    }
    return _fillterButton;
}

-(UILabel *)cutLabel
{
    if (!_cutLabel) {
        CGFloat width = self.frame.size.width;
        CGFloat height = 0.5f;
        CGFloat x = 0.0f;
        CGFloat y = _backgroundView.frame.size.height - height;
        
        _cutLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _cutLabel.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_backgroundView addSubview:_cutLabel];
    }
    return _cutLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
