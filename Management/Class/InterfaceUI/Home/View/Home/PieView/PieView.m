//
//  PieView.m
//  CircleProgress
//
//  Created by 王雷 on 2018/11/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "PieView.h"

@interface PieView ()

@property(nonatomic,strong)CAShapeLayer *maskLayer;
@property(nonatomic,strong)UIBezierPath *path;

@end

@implementation PieView

-(instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius bgColor:(UIColor *)bgColor andstartAngle:(CGFloat)startAngle andAngle:(CGFloat)angle {
    
    self = [super init];
    if (self) {
        //设置self的frame和center
        self.backgroundColor = bgColor;
        self.frame = CGRectMake(0, 0, radius * 2, radius * 2);
        self.center = center;
        
        if (self.path) {
            [self setPath:nil];
        }
        if (self.maskLayer) {
            [self setMaskLayer:nil];
        }
        
    
        //特别注意：贝塞尔曲线的radius必须为self高度的四分之一，CAShapeLayer的线宽必须为self高度的二分之一
        _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius / 2 startAngle:(startAngle * M_PI * 2) endAngle:((startAngle + angle) * M_PI * 2) clockwise:YES];
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.path = _path.CGPath;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = bgColor.CGColor;
        _maskLayer.lineWidth = radius; //等于半径的2倍，以圆的边缘为中心，向圆内部伸展一个半径，向外伸展一个半径，所以看上去以为圆的半径是self高度的一半。
        self.layer.mask = _maskLayer;
        
        [self startAnimaiton];
    }
    
    return self;
}

- (void)startAnimaiton
{
    //开始执行扇形动画
    CABasicAnimation *strokeEndAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAni.fromValue = @0;
    strokeEndAni.toValue = @1;
    strokeEndAni.duration = 0.78;
    strokeEndAni.repeatCount = 1; // 重复次数
    [_maskLayer addAnimation:strokeEndAni forKey:@"ani"];
}

//#pragma mark - lazy load
//-(UIBezierPath *)path
//{
//    if (!_path) {
//        _path = [[UIBezierPath alloc] init];
//    }
//    return _path;
//}
//
//-(CAShapeLayer *)maskLayer
//{
//    if (!_maskLayer) {
//        _maskLayer = [[CAShapeLayer alloc] init];
//    }
//    return _maskLayer;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
}

@end
