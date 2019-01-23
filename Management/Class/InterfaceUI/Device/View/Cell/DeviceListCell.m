//
//  DeviceListCell.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceListCell.h"
#import "DeviceListModel.h"

@interface DeviceListCell ()

@property(nonatomic,strong)UILabel *deviceNameLabel; // 设备名称
@property(nonatomic,strong)UILabel *onlineLabel; // 是否在线
@property(nonatomic,strong)UILabel *numberLabel; // 设备编号
@property(nonatomic,strong)UILabel *chargeLabel; // 是否充电
@property(nonatomic,strong)UILabel *warnLabel; // 警告级别

@end

@implementation DeviceListCell

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
    [self deviceNameLabel];
    [self onlineLabel];
    [self numberLabel];
    [self chargeLabel];
    [self warnLabel];
}

#pragma mark - private method
-(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, titleAttri.length)];

    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    
    [titleAttri appendAttributedString:contentAttri];
    
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

-(NSAttributedString *)setWarnLabelWithContent:(NSString *)content withColor:(NSString *)color
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:@"告警级别: "];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:color],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

- (void)setModel:(DeviceListModel *)model
{
    _deviceNameLabel.attributedText = [self setNormalLabelWithTitle:@"设备名称: " withContent:model.deviceName];
    _onlineLabel.attributedText = model.deviceStatus;
    _numberLabel.attributedText = [self setNormalLabelWithTitle:@"设备编号: " withContent:model.deviceId];
    _chargeLabel.attributedText = [self setNormalLabelWithTitle:@"是否告警: " withContent:model.warn];
    _warnLabel.attributedText = [self setWarnLabelWithContent:model.warnLevel withColor:model.warnColor];
}


#pragma mark - lazy load
-(UILabel *)deviceNameLabel
{
    if (!_deviceNameLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 15.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 15.0f;
        _deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_deviceNameLabel];
    }
    return _deviceNameLabel;
}

-(UILabel *)onlineLabel
{
    if (!_onlineLabel) {
        CGFloat x = _deviceNameLabel.frame.origin.x + _deviceNameLabel.frame.size.width;
        CGFloat y = 15.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 15.0f;
        _onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _onlineLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_onlineLabel];
    }
    return _onlineLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _deviceNameLabel.frame.origin.y + _deviceNameLabel.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 15.0f;
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
}

-(UILabel *)chargeLabel
{
    if (!_chargeLabel) {
        CGFloat x = _numberLabel.frame.origin.x + _numberLabel.frame.size.width;
        CGFloat y = _numberLabel.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 15.0f;
        _chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _chargeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_chargeLabel];
    }
    return _chargeLabel;
}

-(UILabel *)warnLabel
{
    if (!_warnLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _numberLabel.frame.origin.y + _numberLabel.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 15.0f;
        _warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_warnLabel];
    }
    return _warnLabel;
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
