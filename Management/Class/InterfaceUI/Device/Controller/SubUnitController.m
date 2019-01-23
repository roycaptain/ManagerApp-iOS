//
//  SubUnitController.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SubUnitController.h"
#import "DeviceInfoView.h"
#import "SubUnitDetailView.h"
#import "AAChartKit.h"

@interface SubUnitController ()

@property(nonatomic,strong)DeviceInfoView *deviceInfo; // 设备信息
@property(nonatomic,strong)SubUnitDetailView *subUnitView; // 子部件详情

@property(nonatomic,strong)AAChartView *aaChartView;
@property(nonatomic,strong)AAChartModel *aaChartModel;

@end

@implementation SubUnitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self startRequestNetwork];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"子部件详情"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self deviceInfo];
    [self subUnitView];
    
    [self aaChartView];
    [self aaChartModel];
    
    [_deviceInfo setDeviceName:self.deviceName withParentAreaName:self.parentAreaName];
    [_subUnitView setSubUnitName:self.subUnitName withSingalName:self.singalName withTime:self.createTime withSingalValue:self.singalValue];
}

#pragma mark - private method
-(void)startRequestNetwork
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"signalCode" : self.singalCode,@"deviceId" : self.subDeviceId,@"deviceFinalId" : self.deviceFinalId};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceSingalChart WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
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
        NSArray *data = resultDictionary[@"data"];
        if (data.count == 0) {
            [CustomAlertView showWithFailureMessage:@"暂无数据"];
            return;
        }
        
        NSMutableArray *mutableTimes = [[NSMutableArray alloc] init];
        NSMutableArray *mutableValues = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in data) {
            NSInteger value = [dictionary[@"sigValue"] integerValue];
            [mutableTimes addObject:dictionary[@"createtime"]];
            [mutableValues addObject:[NSNumber numberWithInteger:value]];
        }
        
        weakSelf.aaChartView.contentWidth = data.count * 20.0f;
        weakSelf.aaChartModel = weakSelf.aaChartModel
        .chartTypeSet(AAChartTypeLine) // 折线
        .symbolSet(AAChartSymbolTypeCircle)
        .titleSet(@"")
        .subtitleSet(@"")
        .yAxisTitleSet(@"")
        .subtitleSet(@"信号值")
        .colorsThemeSet(@[@"#3399FF"])//设置主体颜色数组
        .categoriesSet([mutableTimes mutableCopy])
        .seriesSet(@[
                     AASeriesElement.new
                     .showInLegendSet(false)
                     .nameSet(@"")
                     .dataSet([mutableValues mutableCopy]),
                     ]);
        
        [weakSelf.aaChartView aa_drawChartWithChartModel:weakSelf.aaChartModel];
        
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(DeviceInfoView *)deviceInfo
{
    if (!_deviceInfo) {
        CGFloat x = 0.0f;
        CGFloat y = 12.0f;
        CGFloat with = [GeneralSize getMainScreenWidth];
        CGFloat height = 115.0f;
        _deviceInfo = [[DeviceInfoView alloc] initWithFrame:CGRectMake(x, y, with, height)];
        [self.view addSubview:_deviceInfo];
    }
    return _deviceInfo;
}

-(SubUnitDetailView *)subUnitView
{
    if (!_subUnitView) {
        CGFloat x = 0.0f;
        CGFloat y = _deviceInfo.frame.origin.y + _deviceInfo.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 54.0f;
        _subUnitView = [[SubUnitDetailView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_subUnitView];
    }
    return _subUnitView;
}

-(AAChartView *)aaChartView
{
    if (!_aaChartView) {
        CGFloat x = 0.0f;
        CGFloat y = _subUnitView.frame.origin.y + _subUnitView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = self.view.frame.size.height - y - NavigationBarHeight - [GeneralSize getStatusBarHeight];
        
        _aaChartView = [[AAChartView alloc] init];
        _aaChartView.frame = CGRectMake(x, y, width, height);
        [self.view addSubview:_aaChartView];
    }
    return _aaChartView;
}

-(AAChartModel *)aaChartModel
{
    if (!_aaChartModel) {
        _aaChartModel = [[AAChartModel alloc] init];
    }
    return _aaChartModel;
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
