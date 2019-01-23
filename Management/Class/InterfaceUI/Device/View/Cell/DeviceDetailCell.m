//
//  DeviceDetailCell.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceDetailCell.h"
#import "SubUnitModel.h"

@interface DeviceDetailCell ()

@property(nonatomic,strong)UILabel *subUnitLabel; // 子部件
@property(nonatomic,strong)UILabel *singleLabel; // 信号名
@property(nonatomic,strong)UILabel *timeLabel; // 时间点
@property(nonatomic,strong)UILabel *singleValueLabel; // 信号值

@end

@implementation DeviceDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_model.showExpression) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

#pragma mark - createUI
-(void)createUI
{
//    [self subUnitLabel];
    [self singleLabel];
//    [self timeLabel];
    [self singleValueLabel];
}

#pragma mark - private method
-(void)setModel:(SubUnitModel *)model
{
    _model = model;
    _singleLabel.attributedText = [self setNormalLabelWithTitle:@"信号名: " withContent:model.singleName];
    _singleValueLabel.attributedText = [self setNormalLabelWithTitle:@"信号值: " withContent:model.singleValue];
}

-(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

#pragma mark - lazy load
-(UILabel *)subUnitLabel
{
    if (!_subUnitLabel) {
        CGFloat x = 10.0f;
        CGFloat y = 10.0f;
        CGFloat wdith = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 12.0f;
        _subUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        _subUnitLabel.textAlignment = NSTextAlignmentLeft;
        _subUnitLabel.attributedText = [self setNormalLabelWithTitle:@"子部件: " withContent:@"超业充电桩"];
        [self.contentView addSubview:_subUnitLabel];
    }
    return _subUnitLabel;
}

// 信号名
-(UILabel *)singleLabel
{
    if (!_singleLabel) {
        CGFloat x = 10.0f;
        CGFloat y = 15.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 12.0f;
        _singleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _singleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_singleLabel];
    }
    return _singleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        CGFloat x = 10.0f;
        CGFloat y = _subUnitLabel.frame.origin.y + _subUnitLabel.frame.size.height + 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 12.0f;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.attributedText = [self setNormalLabelWithTitle:@"时间点: " withContent:@"2017/12/29"];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

// 信号值
-(UILabel *)singleValueLabel
{
    if (!_singleValueLabel) {
        CGFloat x = _singleLabel.frame.origin.x + _singleLabel.frame.size.width;
        CGFloat y = _singleLabel.frame.origin.y;
        CGFloat width = _singleLabel.frame.size.width;
        CGFloat height = 12.0f;
        _singleValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _singleValueLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_singleValueLabel];
    }
    return _singleValueLabel;
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
