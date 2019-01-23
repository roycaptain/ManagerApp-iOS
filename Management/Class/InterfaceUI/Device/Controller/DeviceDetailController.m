//
//  DeviceDetailController.m
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceDetailController.h"
#import "DeviceHeaderView.h"
#import "SubUnitFillterView.h"
#import "SubUnitListController.h"

#import "ComponentModel.h"

@interface DeviceDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)DeviceHeaderView *headerView;
@property(nonatomic,strong)UITableView *deviceTableView;

@property(nonatomic,strong)SubUnitFillterView *fillterView;

@property(nonatomic,copy)NSArray *data;

@end

@implementation DeviceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self startRequestNetwork];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"设备详情"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self deviceTableView];
    [self headerView];
    
    [_headerView setDeviceName:self.deviceName andParentAreaName:self.parentAreaName];
}

#pragma mark - private method
-(void)startRequestNetwork
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"deviceId" : self.deviceId,@"deviceSerialNum" : self.deviceSerialNum};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceDeviceDetailListInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
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

        [weakSelf.headerView setWarnCount:[NSString stringWithFormat:@"%@",data[@"warnCount"]] andCategories:data[@"warnLevels"] andData:data[@"warnInfo"]];
        
        NSArray *components = data[@"components"];
        NSMutableArray *mutableComponent = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in components) {
            ComponentModel *model = [ComponentModel modelWithDictionary:dictionary];
            [mutableComponent addObject:model];
        }
        weakSelf.data = [mutableComponent copy];
        [weakSelf.deviceTableView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - click action
// 筛选
-(void)fillterClickAction
{
    [self.fillterView presentFillterView];
}

#pragma mark - lazy load
-(DeviceHeaderView *)headerView
{
    if (!_headerView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 300.0f;
        _headerView = [[DeviceHeaderView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_headerView setFillterClickWithTarget:self withAction:@selector(fillterClickAction)];
        [_deviceTableView setTableHeaderView:_headerView];
    }
    return _headerView;
}

-(UITableView *)deviceTableView
{
    if (!_deviceTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight] - NavigationBarHeight;
        _deviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _deviceTableView.dataSource = self;
        _deviceTableView.delegate = self;
        _deviceTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_deviceTableView];
    }
    return _deviceTableView;
}

-(SubUnitFillterView *)fillterView
{
    if (!_fillterView) {
        CGFloat x = [GeneralSize getMainScreenWidth];
        CGFloat y = [GeneralSize getStatusBarHeight];
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight];
        
        _fillterView = [[SubUnitFillterView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_fillterView];
    }
    return _fillterView;
}

-(NSArray *)data
{
    if (!_data) {
        _data = [[NSArray alloc] init];
    }
    return _data;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ComponentModel *model = self.data[indexPath.row];
    cell.textLabel.attributedText = model.deviceTitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 54.0f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComponentModel *model = self.data[indexPath.row];

    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    SubUnitListController *subVC = [deviceSB instantiateViewControllerWithIdentifier:@"SubUnitListController"];
    
    subVC.subDeviceId = model.deviceId;
    subVC.subDeviceFinalId = model.deviceFinalId;
    subVC.subDeviceName = [NSString stringWithFormat:@"%@",model.deviceName];
    subVC.deviceName = self.deviceName;
    subVC.parentAreaName = self.parentAreaName;
    [self.navigationController pushViewController:subVC animated:YES];
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
