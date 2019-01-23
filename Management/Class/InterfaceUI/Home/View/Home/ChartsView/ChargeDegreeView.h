//
//  ChargeDegreeView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 累计充电人次(个)
 */
#import <UIKit/UIKit.h>

@class ChargeDegreeModel;

@interface ChargeDegreeView : UIView

-(void)updateWithChargeDegreeModel:(ChargeDegreeModel *)model;

@end
