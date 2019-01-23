//
//  WarnListController.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WarnListController.h"
#import "MenuView.h"
#import "WarnListCell.h"
#import "WarnListModel.h"

@interface WarnListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MenuView *menuView;
@property(nonatomic,strong)UITableView *warnTableView;
@property(nonatomic,strong)UIRefreshControl *refreshControl;

@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,strong)NSArray *data;

@end

@implementation WarnListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self startRequestWarnListInfo];
}

#pragma mark - createUI
-(void)createUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navbar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    [super setNavigationTitle:@"告警列表"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self menuView];
    [self warnTableView];
    
    if (@available(iOS 10.0, *)) {
        self.warnTableView.refreshControl = self.refreshControl;
    } else {
        // Fallback on earlier versions
    }
    
    self.pageNum = 1;
    self.pageSize = 10;
}

#pragma mark - private method
-(void)startRequestWarnListInfo
{
    NSNumber *pageNum = [NSNumber numberWithInteger:self.pageNum];
    NSNumber *pageSize = [NSNumber numberWithInteger:self.pageSize];
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"id" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaID],
                                     @"level" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaLevel],
                                     @"pageNum" : pageNum,
                                     @"pageSize" : pageSize
                                     };
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceWarnListInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] == RequestAccessTokenLose) {
            if ([weakSelf.refreshControl isRefreshing]) {
                weakSelf.pageNum--;
                [weakSelf.refreshControl endRefreshing];
            }
            [CustomAlertView showWithWarnMessage:msg];
            [super redirectTargetLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            if ([weakSelf.refreshControl isRefreshing]) {
                weakSelf.pageNum--;
                [weakSelf.refreshControl endRefreshing];
            }
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSDictionary *data = resultDictionary[@"data"];
        NSDictionary *deviceWarnRecords = data[@"deviceWarnRecords"];
        NSArray *list = deviceWarnRecords[@"list"];
        if (list.count == 0) {
            if ([weakSelf.refreshControl isRefreshing]) {
                weakSelf.pageNum--;
                [weakSelf.refreshControl endRefreshing];
            }
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        if ([weakSelf.refreshControl isRefreshing]) {
            [weakSelf.refreshControl endRefreshing];
        }
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:weakSelf.data];
        for (NSDictionary *device in list) {
            WarnListModel *model = [WarnListModel modelWithDictionary:device withParentAreaName:weakSelf.parentAreaName];
            [mutableArray addObject:model];
        }
        weakSelf.data = [mutableArray mutableCopy];
        [weakSelf.warnTableView reloadData];
        NSLog(@"num - %ld count - %lu",(long)weakSelf.pageNum,(unsigned long)weakSelf.data.count);
        
    } failure:^(NSError *error) {
        if ([weakSelf.refreshControl isRefreshing]) {
            weakSelf.pageNum--;
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

// 下拉刷新
-(void)refreshAction
{
    if ([self.refreshControl isRefreshing]) {
        self.pageNum ++;
        [self startRequestWarnListInfo];
    }
}

#pragma mark - click action
-(void)popViewController
{
    __weak typeof(self) weakSelf = self;
    [_menuView dissFillterView];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    
}

#pragma mark - lazy load
-(MenuView *)menuView
{
    if (!_menuView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 44.0f;
        _menuView = [[MenuView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_menuView];
    }
    return _menuView;
}

-(UITableView *)warnTableView
{
    if (!_warnTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _menuView.frame.origin.y + _menuView.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - NavigationBarHeight - [GeneralSize getStatusBarHeight];
        _warnTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _warnTableView.dataSource = self;
        _warnTableView.delegate = self;
        _warnTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if ([_warnTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _warnTableView.separatorInset = UIEdgeInsetsZero;
        }
        [self.view addSubview:_warnTableView];
    }
    return _warnTableView;
}

-(UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
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
    static NSString *WarnCellIdentifier = @"WarnCellIdentifier";
    WarnListCell *cell = [tableView dequeueReusableCellWithIdentifier:WarnCellIdentifier];
    if (cell == nil) {
        cell = [[WarnListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WarnCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0f;
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
