//
//  WarnDataView.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WarnDataView.h"
#import "AAChartKit.h"
#import "DeviceModel.h"

@interface WarnDataView ()

@property(nonatomic,strong)UILabel *warnTitleLabel; // 告警设备个数

@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@end

@implementation WarnDataView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - private method
-(void)setWarnSiteWithDeviceModel:(DeviceModel *)model
{
    NSString *countStr = [NSString stringWithFormat:@" %ld ",(long)model.warnCount];
    
    NSMutableAttributedString *headAttri = [[NSMutableAttributedString alloc] initWithString:@"产生告警设备数量(个):"];
    [headAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} range:NSMakeRange(0, headAttri.length)];
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:countStr];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#3399FF"],NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} range:NSMakeRange(0, contentAttri.length)];
    [headAttri appendAttributedString:contentAttri];
    _warnTitleLabel.attributedText = headAttri;
    
    _aaChartModel = _aaChartModel
    .chartTypeSet(AAChartTypeBar)
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"")
//    .yAxisVisibleSet(false)
    .categoriesSet(model.warnLevels)
    .dataLabelEnabledSet(YES)
    .seriesSet(@[
                 AASeriesElement.new
                 .nameSet(@"个")
                 .showInLegendSet(false)
                 .dataSet(model.warnInfo)
                 ]);
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
    
}

#pragma mark - createUI
-(void)createUI
{
    [self warnTitleLabel];
    
    [self aaChartView];
    [self aaChartModel];
}

#pragma mark - lazy load
-(UILabel *)warnTitleLabel
{
    if (!_warnTitleLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 15.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 14.0f;
        _warnTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:_warnTitleLabel];
    }
    return _warnTitleLabel;
}

-(AAChartView *)aaChartView
{
    if (!_aaChartView) {
        CGFloat x = 0.0f;
        CGFloat y = _warnTitleLabel.frame.origin.y + _warnTitleLabel.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = self.frame.size.height - y;
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
