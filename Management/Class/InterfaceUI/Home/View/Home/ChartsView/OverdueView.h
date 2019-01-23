//
//  OverdueView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 超期服役的充电桩
 */
#import <UIKit/UIKit.h>

@class OverdueModel;

@interface OverdueView : UIView

-(void)updateWithOverdueModel:(OverdueModel *)model;

@end
