//
//  TurnOverView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "TurnOverView.h"
#import "AAChartKit.h"
#import "TurnOverModel.h"

@interface TurnOverView ()

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@end

@implementation TurnOverView

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
-(void)updateWithTurnOverModel:(TurnOverModel *)model
{
    [self headLabel];
    [self aaChartView];
    [self aaChartModel];
    
    [self setContentWithText:[NSString stringWithFormat:@"%.2f",model.totalTurnOver]];
    
    NSDictionary *gradientColorDic =
    @{
      @"linearGradient": @{
              @"x1": @0,
              @"y1": @1,
              @"x2": @0,
              @"y2": @0
              },
      @"stops": @[@[@0,@"#3399FF"],
                  @[@1,@"#00BD9D"]]//颜色字符串设置支持十六进制类型和 rgba 类型
      };
    
    _aaChartModel = _aaChartModel
    .chartTypeSet(AAChartTypeBar) // 颜色渐变
    .invertedSet(YES)
    .titleSet(@"")
    .subtitleSet(@"")
    .xAxisReversedSet(true)
    .yAxisTitleSet(@"")
    .categoriesSet(model.categories)
    .dataLabelEnabledSet(YES)
    .seriesSet(@[
                 AASeriesElement.new
                 .showInLegendSet(false)
                 .nameSet(@"元")
                 .dataSet(model.data)
                 .colorSet((id)gradientColorDic)
                 ]);
    
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

-(void)setContentWithText:(NSString *)text
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:@"电费收入(元): "];
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
        CGFloat x = 10.0f;
        CGFloat y = _headLabel.frame.origin.y + _headLabel.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width - x * 2;
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
