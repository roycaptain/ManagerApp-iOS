//
//  PieWarnView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 充电桩告警数量
 */
#import <UIKit/UIKit.h>

@class PieWarnModel;

@interface PieWarnView : UIView

-(void)updateWithPieWarnModel:(PieWarnModel *)model;

@end
