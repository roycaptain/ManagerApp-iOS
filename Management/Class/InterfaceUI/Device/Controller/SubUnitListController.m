//
//  SubUnitListController.m
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SubUnitListController.h"
#import "SubUnitController.h"
#import "DeviceDetailCell.h"
#import "SubUnitModel.h"

@interface SubUnitListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *listTableView;

@property(nonatomic,copy)NSArray *data;

@end

@implementation SubUnitListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self startRequestMethod];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"子设备详情列表"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self listTableView];
    [self data];
}

#pragma mark - private method
-(void)startRequestMethod
{
//    self.subDeviceId = @"3097";
//    self.subDeviceFinalId = @"10";
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"deviceId" : self.subDeviceId,@"deviceFinalId" : self.subDeviceFinalId};
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceChildDetail WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
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
        NSDictionary *tableInfo = data[@"tableInfo"];
        NSArray *referenceInfo = data[@"referenceInfo"];
        
        NSMutableArray *mutableData = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in referenceInfo) {
            SubUnitModel *model = [SubUnitModel modelWithDictionary:dictionary withInfo:tableInfo];
            [mutableData addObject:model];
        }
        weakSelf.data = [mutableData mutableCopy];
        [weakSelf.listTableView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(UITableView *)listTableView
{
    if (!_listTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight] - NavigationBarHeight;
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
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
    static NSString *DeviceCellIdentifier = @"DeviceCellIdentifier";
    DeviceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:DeviceCellIdentifier];
    if (cell == nil) {
        cell = [[DeviceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeviceCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubUnitModel *model = self.data[indexPath.row];
    if (!model.showExpression) {
        return;
    }
    
    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    SubUnitController *subVC = [deviceSB instantiateViewControllerWithIdentifier:@"SubUnitController"];
    
    subVC.deviceName = self.deviceName;
    subVC.parentAreaName = self.parentAreaName;
    
    subVC.subUnitName = self.subDeviceName;
    subVC.singalName = model.singleName;
    subVC.createTime = model.createtime;
    subVC.singalValue = model.singleValue;
    subVC.singalCode = model.singalCode;
    subVC.subDeviceId = self.subDeviceId;
    subVC.deviceFinalId = self.subDeviceFinalId;
    
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
