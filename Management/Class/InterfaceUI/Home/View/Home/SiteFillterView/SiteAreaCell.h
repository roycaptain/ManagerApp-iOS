//
//  SiteAreaCell.h
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvAreaModel.h"

@interface SiteAreaCell : UITableViewCell

@property(nonatomic,strong)ProvAreaModel *model;

-(void)setCellSelectState:(BOOL)isSelected;

@end
