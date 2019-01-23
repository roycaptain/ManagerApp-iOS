//
//  MineCell.h
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIImageView *accessory;

@end
