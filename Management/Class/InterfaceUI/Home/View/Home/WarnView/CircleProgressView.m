//
//  CircleProgressView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView ()

@property(nonatomic,assign)CGFloat radius; // 环半径
@property(nonatomic,assign)CGFloat lineWidth; // 环的宽度
@property(nonatomic,copy)NSString *defaultColor; // 默认环的颜色
@property(nonatomic,copy)NSString *progressColor; // 进度条颜色

@property(nonatomic,strong)CAShapeLayer *progressLayer;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@end

@implementation CircleProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _radius = 81.0f; // 半径
        _lineWidth = 5.0f; // 环的宽度
        _progress = 0.0f;
        _defaultColor = @"#EFF7FF";
        _progressColor = @"#3399FF";
        
        // 环
        CGFloat circleX = frame.size.width / 2 - _radius;
        CGFloat circleY = frame.size.height / 2 - _radius;
        CGFloat circleWidth = _radius * 2;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(circleX, circleY, circleWidth, circleWidth) cornerRadius:_radius];
        
        // 环形layer
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor colorWithHexString:_defaultColor].CGColor;
        circleLayer.lineWidth = _lineWidth;
        circleLayer.path = circlePath.CGPath;
        circleLayer.strokeEnd = 1;
        [self.layer addSublayer:circleLayer];
        // 进度layer
        self.progressLayer = [CAShapeLayer layer];
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.strokeColor = [UIColor colorWithHexString:_progressColor].CGColor;
        self.progressLayer.lineCap = kCALineCapRound;
        self.progressLayer.lineWidth = self.lineWidth;
        self.progressLayer.path = circlePath.CGPath;
        self.progressLayer.strokeEnd = 0;
        [self.layer addSublayer:self.progressLayer];
        
        [self titleLabel];
        [self detailLabel];
        
    }
    return self;
}

#pragma mark - private method
-(void)updateProgress:(CGFloat)progress widthCount:(NSInteger)count
{
    self.progress = progress;
    self.progressLayer.strokeEnd = progress;
    //开始执行扇形动画
    CABasicAnimation *strokeEndAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAni.fromValue = @0;
    strokeEndAni.toValue = @(self.progress);
    strokeEndAni.duration = 1.0f;
    strokeEndAni.repeatCount = 1; // 重复次数
    [self.progressLayer addAnimation:strokeEndAni forKey:@"ani"];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
    self.detailLabel.text = [NSString stringWithFormat:@"告警充电桩数量(%ld个)",(long)count];
}

#pragma mark - lazy load
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat width = 120.0f;
        CGFloat height = 40.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        CGFloat y = 50.0f;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        CGFloat width = 120.0f;
        CGFloat height = 20.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 5.0f;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
