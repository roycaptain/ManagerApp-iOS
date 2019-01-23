//
//  OverdueView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "OverdueView.h"
#import "AAChartKit.h"
#import "OverdueModel.h"

@interface OverdueView ()

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@end

@implementation OverdueView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}

#pragma mark - private method
-(void)updateWithOverdueModel:(OverdueModel *)model
{
    [self headLabel];
    [self aaChartView];
    [self aaChartModel];
    
    _aaChartView.contentWidth = model.viewWidth;
    
    _aaChartModel = _aaChartModel
    .chartTypeSet(AAChartTypeLine)
    .stackingSet(AAChartStackingTypeNormal)
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"")
    .symbolSet(AAChartSymbolTypeCircle)
    .colorsThemeSet(@[@"#54DEFD",@"#3399FF",@"#00BD9D",@"#FF9966"])
    .categoriesSet(model.categories)
    .seriesSet(model.data);
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat x = 20.0f;
        CGFloat y = 20.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = 17.0f;
        
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.adjustsFontSizeToFitWidth = YES;
        _headLabel.text = @"充电桩使用时长";
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(AAChartView *)aaChartView
{
    if (!_aaChartView) {
        CGFloat x = 0.0f;
        CGFloat y = _headLabel.frame.origin.y + _headLabel.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width - 1.0f;
        CGFloat height = self.frame.size.height - y;
        
        _aaChartView = [[AAChartView alloc] init];
        _aaChartView.frame = CGRectMake(x, y, width, height);
        _aaChartView.scrollEnabled = YES;
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
