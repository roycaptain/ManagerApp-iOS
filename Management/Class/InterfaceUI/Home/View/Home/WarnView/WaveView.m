//
//  WaveView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WaveView.h"

@interface WaveView ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation WaveView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = self.bounds.size.height * 0.1;
        self.omega = M_PI * 2 / self.bounds.size.width;
        self.phi = 0;
        self.kappa = self.bounds.size.height * 0.5;
        self.speed = 5;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplay)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

#pragma mark - private method
- (void)handleDisplay
{
    if (!self.isHidden) {
        self.phi -= self.speed * self.omega;
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, self.bounds.size.height);
    //正弦曲线公式为：y=Asin(ωx+φ)+k;
    for (CGFloat x = 0.0f; x <= self.bounds.size.width; x++) {
        CGFloat y = self.alpha * sinf(self.omega * x + self.phi) + self.kappa;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
    CGPathCloseSubpath(path);
    //绘制曲线
    CGContextSetFillColorWithColor(cxt, [UIColor colorWithHexString:@"#F2F7FF"].CGColor);
    CGContextSetLineWidth(cxt, 0.5);
    CGContextAddPath(cxt, path);
    CGContextFillPath(cxt);
    CGPathRelease(path);
    
}


@end
