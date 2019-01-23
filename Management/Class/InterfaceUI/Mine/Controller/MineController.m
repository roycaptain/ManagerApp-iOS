//
//  MineController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MineController.h"
#import "ChangePWController.h"
#import "ChangePhoneController.h"
#import "MineCell.h"

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *topBackImageView;
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UITableView *mineTableView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startNetworkRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - private method
-(void)startNetworkRequest
{
    // 获取用户个人信息
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    
    __weak typeof(self) weakSelf = self;
    
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceUserInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
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
        weakSelf.userNameLabel.text = data[@"username"];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - initUI
-(void)initUI
{
    [self topBackImageView];
    [self headerImageView];
    [self userNameLabel];
    [self mineTableView];
}

#pragma mark - lazy load
-(UIImageView *)topBackImageView
{
    if (!_topBackImageView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 240.0f;
        
        _topBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _topBackImageView.image = [UIImage imageNamed:@"bg_top"];
        [self.view addSubview:_topBackImageView];
    }
    return _topBackImageView;
}

-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        CGFloat width = 80.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = 60.0f;
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _headerImageView.image = [UIImage imageNamed:@"icon_logo"];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 40.0f;
        [self.topBackImageView addSubview:_headerImageView];
    }
    return _headerImageView;
}

-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        CGFloat width = 80.0f;
        CGFloat height = 15.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = _headerImageView.frame.origin.y + _headerImageView.frame.size.height + 10.0f;
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _userNameLabel.text = @"运营平台";
        _userNameLabel.font = [UIFont systemFontOfSize:12.0f];
        _userNameLabel.adjustsFontSizeToFitWidth = YES;
        _userNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.topBackImageView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

-(UITableView *)mineTableView
{
    if (!_mineTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _topBackImageView.frame.origin.y + _topBackImageView.frame.size.height + 20.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 220.0f;
       
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.showsVerticalScrollIndicator = NO;
        _mineTableView.scrollEnabled = NO;
        _mineTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_mineTableView];
    }
    return _mineTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MineVCTableCellIdentifier";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.icon.image = [UIImage imageNamed:@"login_phone"];
            cell.headLabel.text = @"更换手机号";
            break;
        case 1:
            cell.icon.image = [UIImage imageNamed:@"login_pw"];
            cell.headLabel.text = @"修改密码";
            break;
        case 2:
            cell.icon.image = [UIImage imageNamed:@"mine_message"];
            cell.headLabel.text = @"我的消息";
//            cell.countLabel.hidden = NO;
//            cell.countLabel.text = @"10";
            break;
        case 3:
            cell.icon.image = [UIImage imageNamed:@"mine_setting"];
            cell.headLabel.text = @"设置";
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
    NSString *targetVCName = @"";
    switch (indexPath.row) {
        case 0:
            targetVCName = @"ChangePhoneController";
            break;
        case 1: // 修改密码
            targetVCName = @"ChangePWController";
            break;
        case 2:
            targetVCName = @"MessageController";
            break;
        case 3:
            targetVCName = @"SettingController";
            break;
        default:
            break;
    }
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    UIViewController *targetVC = [mineSB instantiateViewControllerWithIdentifier:targetVCName];
    [self.navigationController pushViewController:targetVC animated:YES];
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
