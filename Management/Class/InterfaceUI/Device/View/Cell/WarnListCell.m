//
//  WarnListCell.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WarnListCell.h"
#import "WarnListModel.h"

@interface WarnListCell ()

@property(nonatomic,strong)UILabel *deviceName; // 设备名称
@property(nonatomic,strong)UILabel *warnName; // 告警名称
@property(nonatomic,strong)UILabel *warnType; // 告警种类
@property(nonatomic,strong)UILabel *repeatCount; // 重复次数
@property(nonatomic,strong)UILabel *warnLevel; // 告警级别
@property(nonatomic,strong)UILabel *suggestion; // 修复建议
@property(nonatomic,strong)UILabel *devicePath; // 设备路径
@property(nonatomic,strong)UILabel *reportTime; // 上报时间
@property(nonatomic,strong)UILabel *produceTime; // 产生时间

@end

@implementation WarnListCell

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
    [self deviceName];
    [self warnName];
    [self warnType];
    [self repeatCount];
    [self warnLevel];
//    [self suggestion];
    [self devicePath];
    [self reportTime];
    [self produceTime];
}

#pragma mark - private method
-(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    
    [titleAttri appendAttributedString:contentAttri];
    
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

-(void)setModel:(WarnListModel *)model
{
    _deviceName.attributedText = [self setNormalLabelWithTitle:@"设备名称: " withContent:model.deviceName];
    _warnName.attributedText = [self setNormalLabelWithTitle:@"告警名称: " withContent:model.warnTypeName];
    _warnType.attributedText = [self setNormalLabelWithTitle:@"告警种类: " withContent:model.warnCodeName];
    _repeatCount.attributedText = [self setNormalLabelWithTitle:@"重复次数: " withContent:[NSString stringWithFormat:@"%ld",(long)model.warnCount]];
    _warnLevel.attributedText = [self setNormalLabelWithTitle:@"告警级别: " withContent:model.warnLevelName];
    _devicePath.attributedText = [self setNormalLabelWithTitle:@"设备路径: " withContent:model.parentAreaName];
    _reportTime.attributedText = [self setNormalLabelWithTitle:@"最新上报时间: " withContent:model.firstTime];
    _produceTime.attributedText = [self setNormalLabelWithTitle:@"最新产生时间: " withContent:model.newestTime];
}

#pragma mark - lazy load
-(UILabel *)deviceName
{
    if (!_deviceName) {
        CGFloat x = 10.0f;
        CGFloat y = 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 15.0f;
        _deviceName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _deviceName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_deviceName];
    }
    return _deviceName;
}

-(UILabel *)warnName
{
    if (!_warnName) {
        CGFloat x = _deviceName.frame.origin.x + _deviceName.frame.size.width;
        CGFloat y = 10.0f;
        CGFloat width = _deviceName.frame.size.width;
        CGFloat height = 15.0f;
        _warnName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_warnName];
    }
    return _warnName;
}

-(UILabel *)warnType
{
    if (!_warnType) {
        CGFloat x = 10.0f;
        CGFloat y = _deviceName.frame.origin.y + _deviceName.frame.size.height + 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 15.0f;
        _warnType = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnType.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_warnType];
    }
    return _warnType;
}

-(UILabel *)repeatCount
{
    if (!_repeatCount) {
        CGFloat x = _warnType.frame.origin.x + _warnType.frame.size.width;
        CGFloat y = _warnType.frame.origin.y;
        CGFloat width = _warnType.frame.size.width;
        CGFloat height = 15.0f;
        _repeatCount = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _repeatCount.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_repeatCount];
    }
    return _repeatCount;
}

-(UILabel *)warnLevel
{
    if (!_warnLevel) {
        CGFloat x = 10.0f;
        CGFloat y = _warnType.frame.origin.y + _warnType.frame.size.height + 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        CGFloat height = 15.0f;
        _warnLevel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _warnLevel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_warnLevel];
    }
    return _warnLevel;
}

-(UILabel *)suggestion
{
    if (!_suggestion) {
        CGFloat x = _warnLevel.frame.origin.x + _warnLevel.frame.size.width;
        CGFloat y = _warnLevel.frame.origin.y;
        CGFloat width = _warnLevel.frame.size.width;
        CGFloat height = 15.0f;
        _suggestion = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _suggestion.textAlignment = NSTextAlignmentLeft;
        _suggestion.attributedText = [self setNormalLabelWithTitle:@"修复建议: " withContent:@"重复上传"];
        [self.contentView addSubview:_suggestion];
    }
    return _suggestion;
}

-(UILabel *)devicePath
{
    if (!_devicePath) {
        CGFloat x = 10.0f;
        CGFloat y = _warnLevel.frame.origin.y + _warnLevel.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 15.0f;
        _devicePath = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _devicePath.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_devicePath];
    }
    return _devicePath;
}

-(UILabel *)reportTime
{
    if (!_reportTime) {
        CGFloat x = 10.0f;
        CGFloat y = _devicePath.frame.origin.y + _devicePath.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 15.0f;
        _reportTime = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _reportTime.textAlignment = NSTextAlignmentLeft;
       
        [self.contentView addSubview:_reportTime];
    }
    return _reportTime;
}

-(UILabel *)produceTime
{
    if (!_produceTime) {
        CGFloat x = 10.0f;
        CGFloat y = _reportTime.frame.origin.y + _reportTime.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 15.0f;
        _produceTime = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _produceTime.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_produceTime];
    }
    return _produceTime;
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
