//
//  DeviceListController.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceListController.h"
#import "DeviceListCell.h"
#import "FillterView.h"
#import "DeviceDetailController.h"
#import "DeviceListModel.h"

@interface DeviceListController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *listTableView;
@property(nonatomic,strong)FillterView *fillterView;

@property(nonatomic,strong)NSArray *data;

@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self startRequestDeviceListInfo]; // 获取实时设备列表
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"设备列表"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    self.tabBarController.tabBar.hidden = YES;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(fillterAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    
    [self listTableView];
}

#pragma mark - private method
// 获取设备列表
-(void)startRequestDeviceListInfo
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"id" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaID],@"level" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaLevel]};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceDeviceListInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
        
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
        NSArray *deviceList = data[@"deviceList"];
        if (deviceList.count == 0) {
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *device in deviceList) {
            DeviceListModel *model = [DeviceListModel modelWithDictionary:device];
            [mutableArray addObject:model];
        }
        weakSelf.data = [mutableArray mutableCopy];
        [weakSelf.listTableView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - click action
-(void)fillterAction
{
    [self.fillterView presentFillterView];
}

#pragma mark - lazy load
-(UITableView *)listTableView
{
    if (!_listTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - NavigationBarHeight - [GeneralSize getStatusBarHeight];
        
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
}

-(FillterView *)fillterView
{
    if (!_fillterView) {
        CGFloat x = [GeneralSize getMainScreenWidth];
        CGFloat y = [GeneralSize getStatusBarHeight];
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight];
        
        _fillterView = [[FillterView alloc] initWithFrame:CGRectMake(x, y, width, height)];
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
    static NSString *ListCellIdentifier = @"ListCellIdentifier";
    DeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    if (cell == nil) {
        cell = [[DeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceListModel *model = self.data[indexPath.row];
    
    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    DeviceDetailController *deviceDetailVC = [deviceSB instantiateViewControllerWithIdentifier:@"DeviceDetailController"];
    deviceDetailVC.deviceName = model.deviceName;
    deviceDetailVC.parentAreaName = self.parentAreaName;
    deviceDetailVC.deviceId = model.deviceId;
    deviceDetailVC.deviceSerialNum = model.deviceSerialNum;
    [self.navigationController pushViewController:deviceDetailVC animated:YES];
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
