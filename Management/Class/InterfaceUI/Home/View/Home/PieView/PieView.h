//
//  PieView.h
//  CircleProgress
//
//  Created by 王雷 on 2018/11/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieView : UIView

-(instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius bgColor:(UIColor *)bgColor andstartAngle:(CGFloat)startAngle andAngle:(CGFloat)angle;

@end
