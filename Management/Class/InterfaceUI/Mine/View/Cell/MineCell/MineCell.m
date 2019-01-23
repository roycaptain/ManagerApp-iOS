//
//  MineCell.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    [self icon];
    [self headLabel];
    [self countLabel];
    [self accessory];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _icon.frame = CGRectMake(32.0f, 17.5f, 14.0f, 20.0f);
    
    CGFloat headWidth = 100.0f;
    CGFloat headHeight = 14.0f;
    CGFloat headX = _icon.frame.origin.x + _icon.frame.size.width + 12.0f;
    CGFloat headY = (self.contentView.frame.size.height - headHeight) / 2;
    _headLabel.frame = CGRectMake(headX, headY, headWidth, headHeight);
    
    CGFloat accessoryWidth = 10.0f;
    CGFloat accessoryHeight = 18.0f;
    CGFloat accessoryX = self.contentView.frame.size.width - 15.0f - accessoryWidth;
    CGFloat accessoryY = (self.contentView.frame.size.height - accessoryHeight) / 2;
    _accessory.frame = CGRectMake(accessoryX, accessoryY, accessoryWidth, accessoryHeight);
    
    CGFloat countWidth = 18.0f;
    CGFloat countX = self.contentView.frame.size.width - countWidth - accessoryWidth - 20.0f;
    CGFloat countY = (self.contentView.frame.size.height - countWidth) / 2;
    _countLabel.frame = CGRectMake(countX, countY, countWidth, countWidth);
    
    
}

#pragma mark - lazy load
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

-(UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14.0f];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_headLabel];
    }
    return _headLabel;
}

-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.backgroundColor = [UIColor colorWithHexString:@"#FF3333"];
        _countLabel.layer.cornerRadius = 9.0f;
        _countLabel.layer.masksToBounds = YES;
        _countLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.adjustsFontSizeToFitWidth = YES;
        _countLabel.hidden = YES;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
        [self.contentView addSubview:_countLabel];
    }
    return _countLabel;
}

-(UIImageView *)accessory
{
    if (!_accessory) {
        _accessory = [[UIImageView alloc] init];
        _accessory.contentMode = UIViewContentModeScaleAspectFill;
        _accessory.image = [UIImage imageNamed:@"mine_accessory"];
        [self.contentView addSubview:_accessory];
    }
    return _accessory;
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
