//
//  MessageController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MessageController.h"
#import "MessageCell.h"
#import "MessageModel.h"

@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *messageTableView;
@property(nonatomic,strong)UIImageView *failImageView;
@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self initUI];
    
//    [self messageTableView];
//    NSArray *trm = @[@{@"title" : @"系统更新了2.5版本",@"time" : @"2018/01/16",@"content":@"原载《史学理论研究》1998年第3期 一、回顾 最早使用“历史哲学”一词的是法国哲学家伏尔泰。伏尔泰于1765年出版了他的《历史哲学》一书，本书是专为夏特莱侯爵夫人[1]而写，最初是以单行本出版……。后来本书作为“导论”收入《风俗论》一书中。 《风俗论》一书也是专门为夏特莱夫人而写的。在伏尔泰看来，“历史哲学”就是寻求在其整体上理解历史、理解支配历史的那些原则及它可能隐含着的意义。 伏尔泰认为，历史……研究不应仅仅是堆积历史事实，它应该用哲学的或理论的高度来理解。这个由伏尔泰创造的名词很快就在哲学和历史学的领"},
//                     @{@"title" : @"在设备监控板块有严重警告通知",@"time":@"2018/01/07",@"content":@"底下坐着聊天的时候，可能天南海北的也都说一说，但是坐在讲台上，我一般倾向于讲自己多多少少做过一点研究的。像这个题目就不是这样，辛教授在这——他是做历史的——实际上我今天倒是本着一个目的，反正我一……个外行在这讲啊讲，到时候把这个floor给你，你给我纠正。因为有些学生，知道我对历史感兴趣，但是我平常在讲堂上讲的还比较窄，这些学生"}];
//    for (NSDictionary *dictionary in trm) {
//        MessageModel *model = [MessageModel modelWithDictionary:dictionary];
//        [self.data addObject:model];
//        [self.messageTableView reloadData];
//    }
    
    [self failImageView];
    [self tipLabel];
}

#pragma mark - private initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"我的消息"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
}

#pragma mark - lazy load
-(UITableView *)messageTableView
{
    if (!_messageTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - TabBarHeight;
        
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [self.view addSubview:_messageTableView];
    }
    return _messageTableView;
}

-(UIImageView *)failImageView
{
    if (!_failImageView) {
        CGFloat width = 100.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = 100.0f;
        
        _failImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _failImageView.contentMode = UIViewContentModeScaleAspectFill;
        _failImageView.image = [UIImage imageNamed:@"mine_message_fail"];
        [self.view addSubview:_failImageView];
    }
    return _failImageView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _failImageView.frame.origin.y + _failImageView.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 13.0f;
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _tipLabel.text = @"您目前还没收到消息哦~";
        _tipLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.view addSubview:_tipLabel];
    }
    return _tipLabel;
}

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MessageCellIdentifier = @"MessageCellIdentifier";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = _data[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = _data[indexPath.row];
    return model.cellHeight;
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
