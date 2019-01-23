//
//  DeviceController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceController.h"
#import "AccessoryButton.h"
#import "ActualView.h"
#import "WarnDataView.h"
#import "DeviceListController.h"
#import "WarnListController.h"

#import "DeviceModel.h"

@interface DeviceController ()

@property(nonatomic,strong)UIScrollView *baseScrollView;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)AccessoryButton *actualButton; // 实时数据
@property(nonatomic,strong)ActualView *actualView; // 实时数据

@property(nonatomic,strong)AccessoryButton *warnButton; // 告警数据
@property(nonatomic,strong)WarnDataView *warnView; // 告警数据

@property(nonatomic,copy)NSString *parentAreaName; //路径

@end

@implementation DeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self startRequestMonitorData]; // 获取设备监控数据
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - createUI
-(void)createUI
{
    // navigationbar左标题
    UILabel *leftTitleLaebl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 17.0f)];
    leftTitleLaebl.text = @"设备监控";
    leftTitleLaebl.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    leftTitleLaebl.textAlignment = NSTextAlignmentLeft;
    leftTitleLaebl.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftTitleLaebl];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self baseScrollView];
    [self actualButton];
    [self actualView];
    [self warnButton];
    [self warnView];
}

#pragma mark - private method
// 获取设备监控数据
-(void)startRequestMonitorData
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"id" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaID],@"level" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaLevel]};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceMonitor WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        if ([weakSelf.refreshControl isRefreshing]) {
            [weakSelf.refreshControl endRefreshing];
        }
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
        DeviceModel *deviceModel = [DeviceModel modelWithDictionary:data];
        [weakSelf.actualView setActualDataWithDeviceModel:deviceModel];
        [weakSelf.warnView setWarnSiteWithDeviceModel:deviceModel];
        weakSelf.parentAreaName = deviceModel.parentAreaName;
        
        
    } failure:^(NSError *error) {
        if ([weakSelf.refreshControl isRefreshing]) {
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

-(void)refreshAction
{
    [self startRequestMonitorData];
}


#pragma mark - click action
// 实时数据
-(void)actualAction
{
    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    DeviceListController *deviceListVC = [deviceSB instantiateViewControllerWithIdentifier:@"DeviceListController"];
    deviceListVC.parentAreaName = self.parentAreaName;
    [self.navigationController pushViewController:deviceListVC animated:YES];
}

// 告警数据
-(void)warnAction
{
    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    WarnListController *warnListVC = [deviceSB instantiateViewControllerWithIdentifier:@"WarnListController"];
    warnListVC.parentAreaName = self.parentAreaName;
    [self.navigationController pushViewController:warnListVC animated:YES];
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
        _baseScrollView.contentSize = CGSizeMake(0.0f, 573.0f);
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

-(AccessoryButton *)actualButton
{
    if (!_actualButton) {
        CGFloat x = 0.0f;
        CGFloat y = 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _actualButton = [[AccessoryButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_actualButton addTarget:self action:@selector(actualAction) forControlEvents:UIControlEventTouchUpInside];
        [_actualButton setButtonLeftTitleWithText:@"实时数据"];
        [self.baseScrollView addSubview:_actualButton];
    }
    return _actualButton;
}

-(ActualView *)actualView
{
    if (!_actualView) {
        CGFloat x = 0.0f;
        CGFloat y = _actualButton.frame.origin.y + _actualButton.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 248.0f;
        
        _actualView = [[ActualView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.baseScrollView addSubview:_actualView];
    }
    return _actualView;
}

-(AccessoryButton *)warnButton
{
    if (!_warnButton) {
        CGFloat x = 0.0f;
        CGFloat y = _actualView.frame.origin.y + _actualView.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _warnButton = [[AccessoryButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_warnButton addTarget:self action:@selector(warnAction) forControlEvents:UIControlEventTouchUpInside];
        [_warnButton setButtonLeftTitleWithText:@"告警数据"];
        [self.baseScrollView addSubview:_warnButton];
    }
    return _warnButton;
}

-(WarnDataView *)warnView
{
    if (!_warnView) {
        CGFloat x = 0.0f;
        CGFloat y = _warnButton.frame.origin.y + _warnButton.frame.size.height;
        CGFloat wdith = [GeneralSize getMainScreenWidth];
        CGFloat height = 170.0f;
        
        _warnView = [[WarnDataView alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        [self.baseScrollView addSubview:_warnView];
    }
    return _warnView;
}

-(NSString *)parentAreaName
{
    if (!_parentAreaName) {
        _parentAreaName = @"";
    }
    return _parentAreaName;
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
