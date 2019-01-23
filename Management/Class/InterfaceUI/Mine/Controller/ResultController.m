//
//  ResultController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ResultController.h"

@interface ResultController ()

@property(nonatomic,strong)UIImageView *resultImageView;
@property(nonatomic,strong)UILabel *resultTitleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *konwBtn;

@end

@implementation ResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - initUI
-(void)initUI
{
    [super setHideNavigationBarBackItem];
    
    NSString *imageName = _result ? @"mine_change_success" : @"mine_change_fail";
    self.resultImageView.image = [UIImage imageNamed:imageName];
    self.resultTitleLabel.text = _result ? @"更换成功!" : @"更换失败!";
    self.detailLabel.text = _result ? @"请使用新手机号码+新登录密码进行登录!" : @"抱歉~更换失败了,请检查您的网络";
    [self konwBtn];
}

#pragma mark - private method
-(void)konwAction
{
    NSLog(@"我知道了");
}

#pragma mark - lazy load
-(UIImageView *)resultImageView
{
    if (!_resultImageView) {
        CGFloat width = 110.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - width * 2;
        CGFloat y = 100.0f;
        
        _resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _resultImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_resultImageView];
    }
    return _resultImageView;
}

-(UILabel *)resultTitleLabel
{
    if (!_resultTitleLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _resultImageView.frame.origin.y + _resultImageView.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 18.0f;
        
        _resultTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _resultTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _resultTitleLabel.textAlignment = NSTextAlignmentCenter;
        _resultTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.view addSubview:_resultTitleLabel];
    }
    return _resultTitleLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _resultTitleLabel.frame.origin.y + _resultTitleLabel.frame.size.height + 14.5f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 13.5f;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_detailLabel];
    }
    return _detailLabel;
}

-(UIButton *)konwBtn
{
    if (!_konwBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _detailLabel.frame.origin.y + _detailLabel.frame.size.height + 50.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _konwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _konwBtn.frame = CGRectMake(x, y, width, height);
        [_konwBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_konwBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_konwBtn addTarget:self action:@selector(konwAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_konwBtn];
    }
    return _konwBtn;
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
