//
//  TurnOverView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 累计营收金额
 */
#import <UIKit/UIKit.h>

@class TurnOverModel;

@interface TurnOverView : UIView

-(void)updateWithTurnOverModel:(TurnOverModel *)model;

@end
