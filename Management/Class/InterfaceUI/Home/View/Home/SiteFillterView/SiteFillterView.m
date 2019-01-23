//
//  SiteFillterView.m
//  Management
//
//  Created by 王雷 on 2018/12/3.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SiteFillterView.h"
#import "SiteAreaCell.h"
#import "CityAreaModel.h"
#import "DistAreaModel.h"
#import "StationAreaModel.h"

@interface SiteFillterView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UIButton *oneLevelItem; // 一级按钮
@property(nonatomic,strong)UIButton *secondLevelItem; // 二级按钮
@property(nonatomic,strong)UIButton *thirdLevelItem; // 三级按钮
@property(nonatomic,strong)UIButton *fourLevelItem; // 四级按钮
@property(nonatomic,strong)UILabel *underLine; //
@property(nonatomic,strong)UITableView *areaTableView;

@property(nonatomic,strong)UIButton *resetItem; // 重置
@property(nonatomic,strong)UIButton *confirmItem; //确定

@property(nonatomic,assign)NSUInteger selectedIndex; // 选中索引 从 1 开始

@property(nonatomic,copy )NSArray *data;
// 每一级临时储存的数据
@property(nonatomic,copy)NSArray *tempOneLevelList;
@property(nonatomic,copy)NSArray *tempSecondLevelList;
@property(nonatomic,copy)NSArray *tempThirdLevelList;
@property(nonatomic,copy)NSArray *tempFourLevelList;

@property(nonatomic,copy)NSString *areaID; // 区域或站点唯一标识
@property(nonatomic,copy)NSString *areaLevel; // 区域或站点等级
@property(nonatomic,copy)NSString *areaName; // 区域名称

@end

@implementation SiteFillterView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width = [GeneralSize getMainScreenWidth];
    CGFloat height = [GeneralSize getMainScreenHeight];
    CGRect baseFrame = CGRectMake(x, y, width, height);
    self = [super initWithFrame:baseFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        [self createUI];
        
        [self show];
    }
    return self;
}

-(instancetype)initWithFilterData:(NSArray *)data withSiteFilterDelegeate:(id<SiteFilterDelegate>)delegate;
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.tempOneLevelList = [data copy];
        self.data = [data copy];
        self.selectedIndex = 1;
        self.areaID = @"1";
        self.areaLevel = @"ROOT";
        self.areaName = @"全国";
    }
    return self;
}

+(instancetype)initSiteFilterViewWithData:(NSArray *)data withSiteFilterDelegeate:(id<SiteFilterDelegate>)delegate
{
    return [[self alloc] initWithFilterData:data withSiteFilterDelegeate:delegate];
}


#pragma mark - createUI
-(void)createUI
{
    [self baseView];
}

#pragma mark - click action
// 地点选择按钮
-(void)areaClickAction:(UIButton *)sender
{
    _oneLevelItem.selected = NO;
    _secondLevelItem.selected = NO;
    _thirdLevelItem.selected = NO;
    _fourLevelItem.selected = NO;
    sender.selected = YES;
}

// 重置按钮点击事件
-(void)resetClickAction
{
    [_oneLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
    [_secondLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
    [_thirdLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
    [_fourLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
    [_oneLevelItem setTitle:@"请选择" forState:UIControlStateSelected];
    [_secondLevelItem setTitle:@"请选择" forState:UIControlStateSelected];
    [_thirdLevelItem setTitle:@"请选择" forState:UIControlStateSelected];
    [_fourLevelItem setTitle:@"请选择" forState:UIControlStateSelected];
    
    _secondLevelItem.hidden = YES;
    _thirdLevelItem.hidden = YES;
    _fourLevelItem.hidden = YES;
    
    self.selectedIndex = 1;
    self.areaID = @"1";
    self.areaLevel = @"ROOT";
    self.areaName = @"全国";
    
    self.data = [self.tempOneLevelList copy];
    [_areaTableView reloadData];
}

// 确定按钮点击事件
-(void)confirmClickAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(siteFilterConfirmActionWithAreaID: withAreaLevel:withAreaName:)]) {
        [self.delegate siteFilterConfirmActionWithAreaID:self.areaID withAreaLevel:self.areaLevel withAreaName:self.areaName];
    }
    [self hide];
}

#pragma mark - private method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self]) {
        [self hide];
    }
}

// 显示
-(void)show
{
    __weak typeof(self) weakSelf = self;    
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat x = 0.0f;
        CGFloat y = weakSelf.baseView.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        weakSelf.baseView.frame = CGRectMake(x, y, width, height);
    } completion:^(BOOL finished) {
        [weakSelf searchBar];
        [weakSelf navView];
        [weakSelf oneLevelItem];
        [weakSelf secondLevelItem];
        [weakSelf thirdLevelItem];
        [weakSelf fourLevelItem];
        [weakSelf underLine];
        [weakSelf areaTableView];
        [weakSelf resetItem];
        [weakSelf confirmItem];
    }];
}

// 隐藏
-(void)hide
{
    [self.searchBar removeFromSuperview];
    [self.searchBar removeFromSuperview];
    [self.navView removeFromSuperview];
    [self.oneLevelItem removeFromSuperview];
    [self.secondLevelItem removeFromSuperview];
    [self.thirdLevelItem removeFromSuperview];
    [self.fourLevelItem removeFromSuperview];
    [self.underLine removeFromSuperview];
    [self.areaTableView removeFromSuperview];
    [self.resetItem removeFromSuperview];
    [self.confirmItem removeFromSuperview];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat x = 0.0f;
        CGFloat y = weakSelf.baseView.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 0.0f;
        weakSelf.baseView.frame = CGRectMake(x, y, width, height);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HistoryOrderCellIdentifier = @"HistoryOrderCellIdentifier";
    SiteAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryOrderCellIdentifier];
    if (cell == nil) {
        cell = [[SiteAreaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryOrderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        [self oneLevelItemSelectAction:indexPath];
    } else if (self.selectedIndex == 2) {
        [self secondLevelItemSelectAction:indexPath];
    } else if (self.selectedIndex == 3) {
        [self thirdLevelItemSelectAction:indexPath];
    } else if (self.selectedIndex == 4) {
        [self fourthLevelItemSelectAction:indexPath];
    }
}

// 第一级按钮选择
-(void)oneLevelItemSelectAction:(NSIndexPath *)indexPath
{
    // 省级选择
    ProvAreaModel *model = self.data[indexPath.row];
    [_oneLevelItem setTitle:model.areaName forState:UIControlStateNormal];
    [_oneLevelItem setTitle:model.areaName forState:UIControlStateSelected];
    self.areaID = model.areaId;
    self.areaLevel = model.areaLevel;
    self.areaName = model.areaName;
    if (model.areaList || model.stationList) {
        self.oneLevelItem.selected = NO;
        self.selectedIndex = 2;
        self.secondLevelItem.hidden = NO;
        self.secondLevelItem.selected = YES;
    }
    if (model.areaList) {
        self.data = [model.areaList copy];
        self.tempSecondLevelList = [model.areaList copy];
        [_areaTableView reloadData];
    } else if (model.stationList) {
        self.data = [model.stationList copy];
        self.tempSecondLevelList = [model.stationList copy];
        [_areaTableView reloadData];
    }
}

// 第二级选择
-(void)secondLevelItemSelectAction:(NSIndexPath *)indexPath
{
    NSObject *object = self.data[indexPath.row];
    if ([object isMemberOfClass:[CityAreaModel class]]) { // 城市一级选择
        CityAreaModel *model = self.data[indexPath.row];
        [_secondLevelItem setTitle:model.areaName forState:UIControlStateNormal];
        [_secondLevelItem setTitle:model.areaName forState:UIControlStateSelected];
        self.areaID = model.areaId;
        self.areaLevel = model.areaLevel;
        self.areaName = model.areaName;
        if (model.areaList || model.stationList) {
            self.secondLevelItem.selected = NO;
            self.selectedIndex = 3;
            self.thirdLevelItem.hidden = NO;
            self.thirdLevelItem.selected = YES;
        }
        if (model.areaList) {
            self.data = [model.areaList copy];
            self.tempThirdLevelList = [model.areaList copy];
            [_areaTableView reloadData];
        } else if (model.stationList) {
            self.data = [model.stationList copy];
            self.tempThirdLevelList = [model.stationList copy];
            [_areaTableView reloadData];
        }
    } else if ([object isMemberOfClass:[StationAreaModel class]]) { // 站点选择
        StationAreaModel *model = self.data[indexPath.row];
        self.areaID = model.areaId;
        self.areaLevel = model.areaLevel;
        self.areaName = model.areaName;
        [_secondLevelItem setTitle:model.areaName forState:UIControlStateNormal];
        [_secondLevelItem setTitle:model.areaName forState:UIControlStateSelected];
    }
}

// 第三级选择
-(void)thirdLevelItemSelectAction:(NSIndexPath *)indexPath
{
    NSObject *object = self.data[indexPath.row];
    if ([object isMemberOfClass:[DistAreaModel class]]) { // 区选择
        DistAreaModel *model = self.data[indexPath.row];
        [_thirdLevelItem setTitle:model.areaName forState:UIControlStateNormal];
        [_thirdLevelItem setTitle:model.areaName forState:UIControlStateSelected];
        self.areaID = model.areaId;
        self.areaLevel = model.areaLevel;
        self.areaName = model.areaName;
        if (model.stationList) {
            self.thirdLevelItem.selected = NO;
            self.selectedIndex = 4;
            self.fourLevelItem.hidden = NO;
            self.fourLevelItem.selected = YES;
            
            self.data = [model.stationList copy];
            self.tempFourLevelList = [model.stationList copy];
            [_areaTableView reloadData];
        }
        
    } else if ([object isMemberOfClass:[StationAreaModel class]]) {
        StationAreaModel *model = self.data[indexPath.row];
        self.areaID = model.areaId;
        self.areaLevel = model.areaLevel;
        self.areaName = model.areaName;
        [_thirdLevelItem setTitle:model.areaName forState:UIControlStateNormal];
        [_thirdLevelItem setTitle:model.areaName forState:UIControlStateSelected];
    }
}

// 四级选择
-(void)fourthLevelItemSelectAction:(NSIndexPath *)indexPath
{
    StationAreaModel *model = self.data[indexPath.row];
    self.areaID = model.areaId;
    self.areaLevel = model.areaLevel;
    self.areaName = model.areaName;
    [_fourLevelItem setTitle:model.areaName forState:UIControlStateNormal];
    [_fourLevelItem setTitle:model.areaName forState:UIControlStateSelected];
}

#pragma mark - lazy load
-(UIView *)baseView
{
    if (!_baseView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + 44.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 0.0f;
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchBar.barTintColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_baseView addSubview:_searchBar];
    }
    return _searchBar;
}

-(UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchBar.frame.origin.x + _searchBar.frame.size.height, [GeneralSize getMainScreenWidth], 35)];
        [_baseView addSubview:_navView];
    }
    return _navView;
}

-(UIButton *)oneLevelItem
{
    if (!_oneLevelItem) {
        _oneLevelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneLevelItem.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth] / 4, 35.0f);
        _oneLevelItem.selected = YES;
        _oneLevelItem.tag = 1;
        _oneLevelItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_oneLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
        [_oneLevelItem setTitleColor:[UIColor colorWithHexString:@"#329AFF"] forState:UIControlStateSelected];
        [_oneLevelItem setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_oneLevelItem addTarget:self action:@selector(areaClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_oneLevelItem];
    }
    return _oneLevelItem;
}

-(UIButton *)secondLevelItem
{
    if (!_secondLevelItem) {
        _secondLevelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondLevelItem.frame = CGRectMake(_oneLevelItem.frame.origin.x + _oneLevelItem.frame.size.width, 0, _oneLevelItem.frame.size.width, 35.0f);
        _secondLevelItem.tag = 2;
        _secondLevelItem.hidden = YES;
        _secondLevelItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_secondLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
        [_secondLevelItem setTitleColor:[UIColor colorWithHexString:@"#329AFF"] forState:UIControlStateSelected];
        [_secondLevelItem setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_secondLevelItem addTarget:self action:@selector(areaClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_secondLevelItem];
    }
    return _secondLevelItem;
}

-(UIButton *)thirdLevelItem
{
    if (!_thirdLevelItem) {
        _thirdLevelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdLevelItem.frame = CGRectMake(_secondLevelItem.frame.origin.x + _secondLevelItem.frame.size.width, 0.0f, _oneLevelItem.frame.size.width, 35.0f);
        _thirdLevelItem.tag = 3;
        _thirdLevelItem.hidden = YES;
        _thirdLevelItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_thirdLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
        [_thirdLevelItem setTitleColor:[UIColor colorWithHexString:@"#329AFF"] forState:UIControlStateSelected];
        [_thirdLevelItem setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_thirdLevelItem addTarget:self action:@selector(areaClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_thirdLevelItem];
    }
    return _thirdLevelItem;
}

-(UIButton *)fourLevelItem
{
    if (!_fourLevelItem) {
        _fourLevelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _fourLevelItem.frame = CGRectMake(_thirdLevelItem.frame.origin.x + _thirdLevelItem.frame.size.width, 0.0f, _oneLevelItem.frame.size.width, 35.0f);
        _fourLevelItem.tag = 4;
        _fourLevelItem.hidden = YES;
        _fourLevelItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_fourLevelItem setTitle:@"请选择" forState:UIControlStateNormal];
        [_fourLevelItem setTitleColor:[UIColor colorWithHexString:@"#329AFF"] forState:UIControlStateSelected];
        [_fourLevelItem setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_fourLevelItem addTarget:self action:@selector(areaClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_fourLevelItem];
    }
    return _fourLevelItem;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _navView.frame.origin.y + _navView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 0.5f;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [_baseView addSubview:_underLine];
    }
    return _underLine;
}

-(UITableView *)areaTableView
{
    if (!_areaTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _underLine.frame.origin.y + _underLine.frame.size.height;
        CGFloat width = 100.0f;
        CGFloat height = _baseView.frame.size.height - y;
        
        _areaTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _areaTableView.dataSource = self;
        _areaTableView.delegate = self;
        [_baseView addSubview:_areaTableView];
    }
    return _areaTableView;
}

// 重置按钮
-(UIButton *)resetItem
{
    if (!_resetItem) {
        CGFloat height = 50.0f;
        CGFloat width = (_baseView.frame.size.width - _areaTableView.frame.size.width) / 2;
        CGFloat x = _areaTableView.frame.origin.x + _areaTableView.frame.size.width;
        CGFloat y = _baseView.frame.size.height - height;
        _resetItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetItem.frame = CGRectMake(x, y, width, height);
        [_resetItem setTitle:@"重置" forState:UIControlStateNormal];
        [_resetItem setBackgroundColor:[UIColor colorWithHexString:@"#F3F7FF"]];
        [_resetItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_resetItem addTarget:self action:@selector(resetClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_resetItem];
    }
    return _resetItem;
}

// 确定按钮
-(UIButton *)confirmItem
{
    if (!_confirmItem) {
        CGFloat height = 50.0f;
        CGFloat width = (_baseView.frame.size.width - _areaTableView.frame.size.width) / 2;
        CGFloat x = _resetItem.frame.origin.x + _resetItem.frame.size.width;
        CGFloat y = _baseView.frame.size.height - height;
        _confirmItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmItem.frame = CGRectMake(x, y, width, height);
        [_confirmItem setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmItem setBackgroundColor:[UIColor colorWithHexString:@"#4690FF"]];
        [_confirmItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_confirmItem addTarget:self action:@selector(confirmClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_confirmItem];
    }
    return _confirmItem;
}

-(NSArray *)tempOneLevelList
{
    if (!_tempOneLevelList) {
        _tempOneLevelList = [[NSArray alloc] init];
    }
    return _tempOneLevelList;
}

-(NSArray *)tempSecondLevelList
{
    if (!_tempSecondLevelList) {
        _tempSecondLevelList = [[NSArray alloc] init];
    }
    return _tempSecondLevelList;
}

-(NSArray *)tempThirdLevelList
{
    if (!_tempThirdLevelList) {
        _tempThirdLevelList = [[NSArray alloc] init];
    }
    return _tempThirdLevelList;
}

-(NSArray *)tempFourLevelList
{
    if (!_tempFourLevelList) {
        _tempFourLevelList = [[NSArray alloc] init];
    }
    return _tempFourLevelList;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
