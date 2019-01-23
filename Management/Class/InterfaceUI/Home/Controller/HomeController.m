//
//  HomeController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "HomeController.h"
#import "ChargeSiteView.h"
#import "ChargePieView.h"
#import "WarnView.h"
#import "ChargeCapacityView.h"
#import "ChargeDegreeView.h"
#import "TurnOverView.h"
#import "PieWarnView.h"
#import "RatioView.h"
#import "OverdueView.h"
#import "MapController.h"
#import "SiteFillterView.h"

#import "HomeInfoModel.h"
#import "ChargeQuantityModel.h"
#import "ChargeDegreeModel.h"
#import "TurnOverModel.h"
#import "PieWarnModel.h"
#import "RatioModel.h"
#import "OverdueModel.h"

#import "ProvAreaModel.h"

@interface HomeController ()<SiteFilterDelegate>

@property(nonatomic,strong)SiteFillterView *siteFilterView; // 区域选择

@property(nonatomic,strong)UIScrollView *baseScrollView;
@property(nonatomic,strong)ChargeSiteView *chargeSiteView; // 充电桩站点总数数
@property(nonatomic,strong)ChargeSiteView *chargePieView; // 充电桩总数
@property(nonatomic,strong)ChargePieView *chargeStakeView; // 充电桩饼状图
@property(nonatomic,strong)ChargePieView *chargeStateView; // 充电状态饼状图
@property(nonatomic,strong)WarnView *warnView; // 告警充电桩数量
@property(nonatomic,strong)ChargeCapacityView *chargeCapaView; // 累计充电量
@property(nonatomic,strong)ChargeDegreeView *chargeDegView; // 累计充电人次
@property(nonatomic,strong)TurnOverView *turnOverView; // 累计充电费用
@property(nonatomic,strong)PieWarnView *pieWarnView; // 充电桩告警数量
@property(nonatomic,strong)RatioView *ratioView; // 充电桩使用率
@property(nonatomic,strong)OverdueView *overdueView; // 超期服役充电桩

@property(nonatomic,strong)UIRefreshControl *refreshControl;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self getHomeInfoData]; // 获取首页数据
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}

#pragma mark - creatUI
-(void)creatUI
{
    [super setHomeNavigationTitleViewWithTitle:@"全国" withTarget:self withAction:@selector(siteFillterAction)];// 设置站点搜索
    [super setHomeNavigationLeftItem]; // navigationbar左标题
    [super setHomeNavigationRightItemWithTarget:self withAction:@selector(mapAction)]; // navigationbar 右按钮
    
    //
    [self baseScrollView];
    [self chargeSiteView];
    [self chargePieView];
    [self chargeStakeView];
    [self chargeStateView];
    [self warnView];
//    [self chargeCapaView]; // 累计充电量
//    [self chargeDegView]; // 累计充电人次
//    [self turnOverView]; // 累计充电费用
//    [self pieWarnView]; // 充电桩告警个数
//    [self ratioView]; // 充电桩使用率
//    [self overdueView]; // 超期服役d充电桩
}

#pragma mark - private method
// 获取首页数据
-(void)getHomeInfoData
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"id" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaID],@"level" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaLevel]};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView showWithMessage:@"正在加载数据..."];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceHomeInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary - %@",resultDictionary);
        if ([weakSelf.refreshControl isRefreshing]) {
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] == RequestAccessTokenLose) {
            [CustomAlertView showWithWarnMessage:msg];
            [super redirectTargetLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSDictionary *data = resultDictionary[@"data"];
        HomeInfoModel *model = [HomeInfoModel modelWithDictionary:data];
        
        [weakSelf.chargeSiteView setSiteCountWithCount:model.stationCount andCountColor:@"#3399FF"]; // 充电桩站点总数
        [weakSelf.chargePieView setSiteCountWithCount:model.deviceCount andCountColor:@"#3399FF"]; // 充电桩总数
        
        [weakSelf.chargeStakeView setPierViewWithMainAngle:model.onlinePercent andMinorAngle:model.offlinePercent]; // 充电桩百分比
        [weakSelf.chargeStakeView setMainLabelContentWithCount:model.onlineDeviceCount]; // 在线充电桩数量
        [weakSelf.chargeStakeView setMinorLabelContentWithCount:model.offlineDeviceCount]; // 离线充电桩数量
        
        [weakSelf.chargeStateView setPierViewWithMainAngle:model.chargingPercent andMinorAngle:model.freePercent]; // 充电百分比
        [weakSelf.chargeStateView setMainLabelContentWithCount:model.chargingCount]; // 充电中
        [weakSelf.chargeStateView setMinorLabelContentWithCount:model.freeCount]; // 空闲中
        
        [weakSelf.warnView updateProgressWithprogress:model.warnPercent withCount:model.warnDeviceCount]; // 告警充电桩数量
        
        // 累计充电量
        ChargeQuantityModel *chargeQuantityModel = [ChargeQuantityModel modelWithDictionary:data[@"INDEX_CHARGE_POWER"]];
        [weakSelf loadChargeCaacityData:chargeQuantityModel];
        // 累计充电次数
        ChargeDegreeModel *chargeDegreeModel = [ChargeDegreeModel modelWithDictionary:data[@"INDEX_CHARGE_CYCLES"]];
        [weakSelf loadChargeDegreeData:chargeDegreeModel];
        // 累计充电费用
        TurnOverModel *turnModel = [TurnOverModel modelWithDictionary:data[@"INDEX_CHARGE_FEE"]];
        [weakSelf loadTurnOverData:turnModel];
        // 充电桩告警数量
        PieWarnModel *pieWarnModel = [PieWarnModel modelWithDictionary:data[@"INDEX_CHARGING_PILE_WARNING"]];
        [weakSelf loadPieWarnData:pieWarnModel];
        // 充电桩使用率
        RatioModel *ratioModel = [RatioModel modelWithDictionary:data[@"INDEX_CHARGING_PILE_RATE"]];
        [weakSelf loadRatioData:ratioModel];
        // 超期服役充电桩
        OverdueModel *overdueModel = [OverdueModel modelWithDictionary:data[@"INDEX_CHARGING_PILE_AGE"]];
        [weakSelf loadOverduoData:overdueModel];
        
        // baseScrollView 的 contentHeight
        CGFloat scrollHeight = 608.0f + chargeQuantityModel.viewHeight + chargeDegreeModel.viewHeight + turnModel.viewHeight
        + pieWarnModel.viewHeight + ratioModel.viewHeight + overdueModel.viewHeight;
        weakSelf.baseScrollView.contentSize = CGSizeMake(0.0f, scrollHeight);

    } failure:^(NSError *error) {
        if ([weakSelf.refreshControl isRefreshing]) {
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

// 加载累计充电量数据
-(void)loadChargeCaacityData:(ChargeQuantityModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = self.warnView.frame.origin.y + self.warnView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.chargeCapaView.frame = CGRectMake(x, y, width, height);
    [self.chargeCapaView updateCapacityWithChargeQuantity:model];
}

// 加载累计充电人次数据
-(void)loadChargeDegreeData:(ChargeDegreeModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = self.chargeCapaView.frame.origin.y + self.chargeCapaView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.chargeDegView.frame = CGRectMake(x, y, width, height);
    [self.chargeDegView updateWithChargeDegreeModel:model];
}

// 加载充电费用金额
-(void)loadTurnOverData:(TurnOverModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = self.chargeDegView.frame.origin.y + self.chargeDegView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.turnOverView.frame = CGRectMake(x, y, width, height);
    [self.turnOverView updateWithTurnOverModel:model];
}

// 加载充电桩告警数据
-(void)loadPieWarnData:(PieWarnModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = self.turnOverView.frame.origin.y + self.turnOverView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.pieWarnView.frame = CGRectMake(x, y, width, height);
    [self.pieWarnView updateWithPieWarnModel:model];
}

// 加载充电桩使用率数据
-(void)loadRatioData:(RatioModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = _pieWarnView.frame.origin.y + _pieWarnView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.ratioView.frame = CGRectMake(x, y, width, height);
    [self.ratioView updateWithRatioModel:model];
}

// 加载充电桩使用时长数据
-(void)loadOverduoData:(OverdueModel *)model
{
    CGFloat x = 10.0f;
    CGFloat y = self.ratioView.frame.origin.y + self.ratioView.frame.size.height + 12.0f;
    CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
    CGFloat height = model.viewHeight;
    
    self.overdueView.frame = CGRectMake(x, y, width, height);
    [self.overdueView updateWithOverdueModel:model];
}

-(void)getSiteFilterData
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};

    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceAreaList WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] == RequestAccessTokenLose) {
            [CustomAlertView showWithWarnMessage:msg];
            [super redirectTargetLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        
        NSDictionary *data = resultDictionary[@"data"];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        
        //----------------------------------建立区域站点数据模型---------------------------------
        // 省级 Root areaID 1 areaLevel ROOT
        ProvAreaModel *model = [[ProvAreaModel alloc] init];
        model.areaId = data[@"areaId"];
        model.areaLevel = data[@"areaLevel"];
        model.areaName = data[@"areaLevel"];
        [mutableArray addObject:model];
        
        NSArray *areaList = data[@"areaList"];
        for (NSDictionary *dictionary in areaList) {
            ProvAreaModel *model = [ProvAreaModel modelWithDictionary:dictionary];
            [mutableArray addObject:model];
        }
        [SiteFillterView initSiteFilterViewWithData:[mutableArray mutableCopy] withSiteFilterDelegeate:self];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}


#pragma mark - click method
-(void)mapAction
{
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    MapController *mapVC = [homeSB instantiateViewControllerWithIdentifier:@"MapController"];
    [self.navigationController pushViewController:mapVC animated:YES];
}

// 站点筛选
-(void)siteFillterAction
{
    [self getSiteFilterData]; // 获取筛选站点区域数据
}

-(void)refreshAction
{
    [self getHomeInfoData];
}

#pragma mark - SiteFilterDelegate
-(void)siteFilterConfirmActionWithAreaID:(NSString *)areaID withAreaLevel:(NSString *)areaLevel withAreaName:(NSString *)areaName
{
    [[SiteInfoManager shareInstance] setSiteInfoWithAreaID:areaID withAreaLevel:areaLevel];
    [super setHomeNavigationTitleViewWithTitle:areaName withTarget:self withAction:@selector(siteFillterAction)];
    [self getHomeInfoData];
}

#pragma mark - lazy load

-(UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - NavigationBarHeight - TabBarHeight;
        
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
        if (@available(iOS 10.0, *)) {
            _baseScrollView.refreshControl = self.refreshControl;
        } else {
            // Fallback on earlier versions
        }
        [self.view addSubview:_baseScrollView];
    }
    return _baseScrollView;
}

-(UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}


-(ChargeSiteView *)chargeSiteView
{
    if (!_chargeSiteView) {
        CGFloat width = ([GeneralSize getMainScreenWidth] - 30.0f) / 2;
        CGFloat height = 125.0f;
        CGFloat x = 10.0f;
        CGFloat y = 12.0f;
        
        _chargeSiteView = [[ChargeSiteView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_chargeSiteView setIconImageWithImageName:@"home_charge_site"];
        [_chargeSiteView setStartDescribe:@"充电桩站点总数"];
        [_chargeSiteView setEndDescribe:@"个"];
        [_chargeSiteView setSiteCountWithCount:0 andCountColor:@"#3399FF"];
        [self.baseScrollView addSubview:_chargeSiteView];
    }
    return _chargeSiteView;
}

-(ChargeSiteView *)chargePieView
{
    if (!_chargePieView) {
        CGFloat width = ([GeneralSize getMainScreenWidth] - 30.0f) / 2;
        CGFloat height = 125.0f;
        CGFloat x = _chargeSiteView.frame.origin.x + _chargeSiteView.frame.size.width + 10.0f;
        CGFloat y = 12.0f;
        
        _chargePieView = [[ChargeSiteView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_chargePieView setIconImageWithImageName:@"hone_charge_pie"];
        [_chargePieView setStartDescribe:@"充电桩总数"];
        [_chargePieView setEndDescribe:@"个"];
        [_chargePieView setSiteCountWithCount:0 andCountColor:@"#3399FF"];
        [self.baseScrollView addSubview:_chargePieView];
    }
    return _chargePieView;
}

-(ChargePieView *)chargeStakeView
{
    if (!_chargeStakeView) {
        CGFloat width = ([GeneralSize getMainScreenWidth] - 30.0f) / 2;
        CGFloat height = 125.0f;
        CGFloat x = 10.0f;
        CGFloat y = _chargeSiteView.frame.origin.y + _chargeSiteView.frame.size.height + 12.0f;
        
        _chargeStakeView = [[ChargePieView alloc] initWithFrame:CGRectMake(x, y, width, height) withMainColor:@"#00BD9D" withMinorColor:@"#8BD7D2" withStartMainDescribe:@"在线充电桩数量" withEndMainDescribe:@"个" withStartMinorDescribe:@"离线充电桩数量" withEndMinorDescribe:@"个"];
        [_chargeStakeView setPierViewWithMainAngle:0.0f andMinorAngle:1.0f];
        [_chargeStakeView setMainLabelContentWithCount:0];
        [_chargeStakeView setMinorLabelContentWithCount:0];
        [self.baseScrollView addSubview:_chargeStakeView];
    }
    return _chargeStakeView;
}

-(ChargePieView *)chargeStateView
{
    if (!_chargeStateView) {
        CGFloat width = ([GeneralSize getMainScreenWidth] - 30.0f) / 2;
        CGFloat height = 125.0f;
        CGFloat x = _chargeStakeView.frame.origin.x + _chargeStakeView.frame.size.width + 10.0f;
        CGFloat y = _chargeSiteView.frame.origin.y + _chargeSiteView.frame.size.height + 12.0f;
        
        _chargeStateView = [[ChargePieView alloc] initWithFrame:CGRectMake(x, y, width, height) withMainColor:@"#3399FF" withMinorColor:@"#66CCFF" withStartMainDescribe:@"充电中" withEndMainDescribe:@"个" withStartMinorDescribe:@"空闲中" withEndMinorDescribe:@"个"];
        [_chargeStateView setPierViewWithMainAngle:0.0f andMinorAngle:1.0f];
        [_chargeStateView setMainLabelContentWithCount:0];
        [_chargeStateView setMinorLabelContentWithCount:0];
        [self.baseScrollView addSubview:_chargeStateView];
    }
    return _chargeStateView;
}

-(WarnView *)warnView
{
    if (!_warnView) {
        CGFloat x = 10.0f;
        CGFloat y = _chargeStakeView.frame.origin.y + _chargeStakeView.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 240.0f;
        
        _warnView = [[WarnView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_warnView updateProgressWithprogress:0.0f withCount:0];
        [self.baseScrollView addSubview:_warnView];
    }
    return _warnView;
}

// 累计充电量
-(ChargeCapacityView *)chargeCapaView
{
    if (!_chargeCapaView) {
        _chargeCapaView = [[ChargeCapacityView alloc] init];
        [self.baseScrollView addSubview:_chargeCapaView];
    }
    return _chargeCapaView;
}

// 累计充电次数
-(ChargeDegreeView *)chargeDegView
{
    if (!_chargeDegView) {
        _chargeDegView = [[ChargeDegreeView alloc] init];
        [self.baseScrollView addSubview:_chargeDegView];
    }
    return _chargeDegView;
}

// 累计充电费用
-(TurnOverView *)turnOverView
{
    if (!_turnOverView) {
        _turnOverView = [[TurnOverView alloc] init];
        [self.baseScrollView addSubview:_turnOverView];
    }
    return _turnOverView;
}

-(PieWarnView *)pieWarnView
{
    if (!_pieWarnView) {
        _pieWarnView = [[PieWarnView alloc] init];
        [self.baseScrollView addSubview:_pieWarnView];
    }
    return _pieWarnView;
}

-(RatioView *)ratioView
{
    if (!_ratioView) {
        _ratioView = [[RatioView alloc] init];
        [self.baseScrollView addSubview:_ratioView];
    }
    return _ratioView;
}

-(OverdueView *)overdueView
{
    if (!_overdueView) {
        _overdueView = [[OverdueView alloc] init];
        [self.baseScrollView addSubview:_overdueView];
    }
    return _overdueView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
