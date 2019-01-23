//
//  ChargePieView.h
//  Management
//
//  Created by 王雷 on 2018/11/23.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 饼状图
 */
#import <UIKit/UIKit.h>
#import "PieView.h"

@interface ChargePieView : UIView

@property(nonatomic,strong)PieView *mainPieView;
@property(nonatomic,strong)PieView *minorPieView;

@property(nonatomic,copy)NSString *mainColor;
@property(nonatomic,copy)NSString *minorColor;

@property(nonatomic,strong)UILabel *mainPointView;
@property(nonatomic,strong)UILabel *minorPointView;

@property(nonatomic,strong)UILabel *mainLabel;
@property(nonatomic,strong)UILabel *minorLabel;

@property(nonatomic,copy)NSString *startMainDescribe;
@property(nonatomic,copy)NSString *endMainDescribe;

@property(nonatomic,copy)NSString *startMinorDescribe;
@property(nonatomic,copy)NSString *endMinorDescribe;


-(instancetype)initWithFrame:(CGRect)frame withMainColor:(NSString *)mainColor withMinorColor:(NSString *)minorColor withStartMainDescribe:(NSString *)startMainDescribe withEndMainDescribe:(NSString *)endMainDescribe withStartMinorDescribe:(NSString *)startMinorDescribe withEndMinorDescribe:(NSString *)endMinorDescribe;

-(void)setPierViewWithMainAngle:(CGFloat)mainAngle andMinorAngle:(CGFloat)minorAngle;
-(void)setMainLabelContentWithCount:(NSInteger)count;
-(void)setMinorLabelContentWithCount:(NSInteger)count;


@end
