//
//  ChargePieView.m
//  Management
//
//  Created by 王雷 on 2018/11/23.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargePieView.h"
#import "PieView.h"

@implementation ChargePieView

-(instancetype)initWithFrame:(CGRect)frame withMainColor:(NSString *)mainColor withMinorColor:(NSString *)minorColor withStartMainDescribe:(NSString *)startMainDescribe withEndMainDescribe:(NSString *)endMainDescribe withStartMinorDescribe:(NSString *)startMinorDescribe withEndMinorDescribe:(NSString *)endMinorDescribe
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        self.mainColor = [mainColor copy];
        self.minorColor = [minorColor copy];
        
        self.mainPointView.backgroundColor = [UIColor colorWithHexString:mainColor];
        self.minorPointView.backgroundColor = [UIColor colorWithHexString:minorColor];
        
        self.startMainDescribe = [startMainDescribe copy];
        self.endMainDescribe = [endMainDescribe copy];
        self.startMinorDescribe = [startMinorDescribe copy];
        self.endMinorDescribe = [endMinorDescribe copy];
        
        [self mainLabel];
        [self minorLabel];
    }
    return self;
}

#pragma mark - private method
-(void)setPierViewWithMainAngle:(CGFloat)mainAngle andMinorAngle:(CGFloat)minorAngle
{
    if (self.mainPieView) {
        [self.mainPieView removeFromSuperview];
        [self setMainPieView:nil];
    }
    if (self.minorPieView) {
        [self.minorPieView removeFromSuperview];
        [self setMinorPieView:nil];
    }
    
    CGFloat centerX = self.frame.size.width / 2;
    CGFloat centerY = 40.0f;
    
    CGPoint point = CGPointMake(centerX, centerY);
    self.mainPieView = [[PieView alloc] initWithCenter:point radius:25.0f bgColor:[UIColor colorWithHexString:self.mainColor] andstartAngle:0.0f andAngle:mainAngle];
    [self addSubview:self.mainPieView];
    
    self.minorPieView = [[PieView alloc] initWithCenter:point radius:21.0f bgColor:[UIColor colorWithHexString:self.minorColor] andstartAngle:mainAngle andAngle:minorAngle];
    [self addSubview:self.minorPieView];
}

-(void)setMainLabelContentWithCount:(NSInteger)count
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:_startMainDescribe];
    [firstAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, firstAttri.length)];
    
    NSString *countStr = [NSString stringWithFormat:@" %ld ",(long)count];
    NSMutableAttributedString *secondAttri = [[NSMutableAttributedString alloc] initWithString:countStr];
    [secondAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:self.mainColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14.0f]} range:NSMakeRange(0, secondAttri.length)];
    
    NSMutableAttributedString *thirdAttri = [[NSMutableAttributedString alloc] initWithString:_endMainDescribe];
    [thirdAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0F]} range:NSMakeRange(0, thirdAttri.length)];
    
    [firstAttri appendAttributedString:secondAttri];
    [firstAttri appendAttributedString:thirdAttri];
    
    _mainLabel.attributedText = firstAttri;
}

-(void)setMinorLabelContentWithCount:(NSInteger)count
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:_startMinorDescribe];
    [firstAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, firstAttri.length)];
    
    NSString *countStr = [NSString stringWithFormat:@" %ld ",(long)count];
    NSMutableAttributedString *secondAttri = [[NSMutableAttributedString alloc] initWithString:countStr];
    [secondAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:self.minorColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14.0f]} range:NSMakeRange(0, secondAttri.length)];
    
    NSMutableAttributedString *thirdAttri = [[NSMutableAttributedString alloc] initWithString:_endMinorDescribe];
    [thirdAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0F]} range:NSMakeRange(0, thirdAttri.length)];
    
    [firstAttri appendAttributedString:secondAttri];
    [firstAttri appendAttributedString:thirdAttri];
    
    _minorLabel.attributedText = firstAttri;
}



#pragma mark - lazy load
-(UILabel *)mainPointView
{
    if (!_mainPointView) {
        CGFloat width = 10.0f;
        CGFloat x = 12.0f;
        CGFloat y = 83.0f;
        
        _mainPointView = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _mainPointView.layer.cornerRadius = 1.0f;
        _mainPointView.layer.masksToBounds = YES;
        [self addSubview:_mainPointView];
    }
    return _mainPointView;
}

-(UILabel *)minorPointView
{
    if (!_minorPointView) {
        CGFloat width = 10.0f;
        CGFloat x = 12.0f;
        CGFloat y = _mainPointView.frame.origin.y + _mainPointView.frame.size.height + 13.0f;
        
        _minorPointView = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _minorPointView.layer.cornerRadius = 1.0f;
        _minorPointView.layer.masksToBounds = YES;
        [self addSubview:_minorPointView];
    }
    return _minorPointView;
}

-(UILabel *)mainLabel
{
    if (!_mainLabel) {
        CGFloat x = _mainPointView.frame.origin.x + _mainPointView.frame.size.width + 4.0f;
        CGFloat y = _mainPointView.frame.origin.y - 2.0f;
        CGFloat width = self.frame.size.width - x - 10.0f;
        CGFloat height = 12.0f;
        
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        _mainLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_mainLabel];
    }
    return _mainLabel;
}

-(UILabel *)minorLabel
{
    if (!_minorLabel) {
        CGFloat x = _minorPointView.frame.origin.x + _minorPointView.frame.size.width + 4.0f;
        CGFloat y = _minorPointView.frame.origin.y - 2.0f;
        CGFloat width = self.frame.size.width - x - 10.0f;
        CGFloat height = 12.0f;
        
        _minorLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _minorLabel.textAlignment = NSTextAlignmentCenter;
        _minorLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_minorLabel];
    }
    return _minorLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
