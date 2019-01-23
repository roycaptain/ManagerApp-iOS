//
//  SiteAreaCell.m
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SiteAreaCell.h"

@interface SiteAreaCell ()

@property(nonatomic,strong)UILabel *headLabel;

@end

@implementation SiteAreaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self headLabel];
}

-(void)setModel:(ProvAreaModel *)model
{
    _model = model;
    _headLabel.text = model.areaName;
}

#pragma mark - private method
-(void)setCellSelectState:(BOOL)isSelected
{
    if (isSelected) {
        _headLabel.textColor = [UIColor colorWithHexString:@"#3399FF"];
        self.selected = YES;
    } else {
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.selected = NO;
    }
    
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat width = 100.0f;
        CGFloat height = 40.0f;
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont systemFontOfSize:13.0f];
        _headLabel.text = @"ROOT";
        [self.contentView addSubview:_headLabel];
    }
    return _headLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
