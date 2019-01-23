//
//  MenuCell.h
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface MenuCell : UITableViewCell

@property(nonatomic,strong)MenuModel *model;
@property(nonatomic,assign)BOOL isSelected;

-(void)setCellSelectState:(BOOL)isSelected;

@end
