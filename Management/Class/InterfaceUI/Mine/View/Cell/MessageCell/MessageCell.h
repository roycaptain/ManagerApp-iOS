//
//  MessageCell.h
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageCell : UITableViewCell

@property(nonatomic,strong)UILabel *headLabel; // 标题
@property(nonatomic,strong)UILabel *timeLabel; // 时间
@property(nonatomic,strong)UILabel *detailLabel; // 详情

@property(nonatomic,strong)MessageModel *model;

@end
