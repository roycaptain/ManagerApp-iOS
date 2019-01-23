//
//  PieWarnView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "PieWarnView.h"
#import "AAChartKit.h"
#import "PieWarnModel.h"

@interface PieWarnView ()

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@end

@implementation PieWarnView

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
-(void)updateWithPieWarnModel:(PieWarnModel *)model
{
    [self headLabel];
    [self aaChartView];
    [self aaChartModel];
    
    _aaChartView.contentWidth = model.viewWidth;
    [self setContentWithText:[NSString stringWithFormat:@"%ld",(long)model.total]];
    
    _aaChartModel = _aaChartModel
    .chartTypeSet(AAChartTypeColumn)
    .stackingSet(AAChartStackingTypeNormal)
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"")
    .symbolSet(AAChartSymbolTypeSquare)
    .colorsThemeSet(@[@"#920000",@"#c30000",@"#f56400",@"#f79345"])
    .categoriesSet(model.categories)
    .seriesSet(model.data);
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

-(void)setContentWithText:(NSString *)text
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:@"充电桩告警数量(个): "];
    [firstAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:18.0f]} range:NSMakeRange(0, firstAttri.length)];
    NSMutableAttributedString *secondAttri = [[NSMutableAttributedString alloc] initWithString:text];
    [secondAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#3399FF"],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18.0f]} range:NSMakeRange(0, secondAttri.length)];
    [firstAttri appendAttributedString:secondAttri];
    _headLabel.attributedText = firstAttri;
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
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(AAChartView *)aaChartView
{
    if (!_aaChartView) {
        CGFloat x = 0.0f;
        CGFloat y = _headLabel.frame.origin.y + _headLabel.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width - 5.0f;
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
