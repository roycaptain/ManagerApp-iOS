//
//  SettingController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SettingController.h"
#import "AboutController.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *setTableView;
@property(nonatomic,strong)UIButton *loginoutBtn;

@property(nonatomic,copy)NSString *cacheSzie;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // 计算缓存
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *cacheSize = [NSString stringWithFormat:@"%.1fM",[[FileManager shareInstance] getCachesSize]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.cacheSzie = [cacheSize copy];
            [weakSelf.setTableView reloadData];
        });
    });
    
    
}

#pragma mark - private initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"设置"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self setTableView];
    [self loginoutBtn];
    
}

#pragma mark - private method

#pragma mark - click Action
// 退出登录
-(void)loginOutAction
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestDeleteWithURLString:URLInterfaceLoginOut WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        
        NSString *code = [resultDictionary objectForKey:@"code"];
        NSString *msg = [resultDictionary objectForKey:@"msg"];
        if ([code integerValue] == RequestNetworkSuccess) { // 退出登录成功
            [super redirectTargetLoginController];
            return ;
        }
        if ([code integerValue] == RequestAccessTokenLose) { // access_token 失效
            [CustomAlertView showWithWarnMessage:msg];
            [super redirectTargetLoginController];
            return ;
        }
        [CustomAlertView showWithWarnMessage:msg];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(UITableView *)setTableView
{
    if (!_setTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 110.0f;
        
        _setTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _setTableView.dataSource = self;
        _setTableView.delegate = self;
        _setTableView.scrollEnabled = NO;
        [self.view addSubview:_setTableView];
    }
    return _setTableView;
}

-(UIButton *)loginoutBtn
{
    if (!_loginoutBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _setTableView.frame.origin.y + _setTableView.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _loginoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginoutBtn.frame = CGRectMake(x, y, width, height);
        [_loginoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginoutBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_loginoutBtn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginoutBtn];
    }
    return _loginoutBtn;
}

-(NSString *)cacheSzie
{
    if (!_cacheSzie) {
        _cacheSzie = [[NSString alloc] init];
    }
    return _cacheSzie;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SettingCellIdentifier = @"MessageCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"mine_set_clean"];
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = _cacheSzie;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"mine_settip"];
            cell.textLabel.text = @"关于平台";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:NULL message:NULL preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cleanAction = [UIAlertAction actionWithTitle:@"清除缓存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[FileManager shareInstance] clearCachesSize];
            __weak typeof(self) weakSelf = self;
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                NSString *cacheSize = [NSString stringWithFormat:@"%.1fM",[[FileManager shareInstance] getCachesSize]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.cacheSzie = [cacheSize copy];
                    [weakSelf.setTableView reloadData];
                });
            });
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:NULL];
        [alertSheet addAction:cleanAction];
        [alertSheet addAction:cancel];
        [self presentViewController:alertSheet animated:YES completion:NULL];
    } else {
        UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
        AboutController *aboutVC = [mineSB instantiateViewControllerWithIdentifier:@"AboutController"];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
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
