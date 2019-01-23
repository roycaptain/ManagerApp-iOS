//
//  ChangePhoneController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChangePhoneController.h"
#import "TextInputView.h"
#import "NewPhoneController.h"

@interface ChangePhoneController ()

@property(nonatomic,strong)TextInputView *phoneInput; // 手机号输入
@property(nonatomic,strong)TextInputView *passwordInput; // 密码输入
@property(nonatomic,strong)UIButton *nextBtn; // 下一步按钮

@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"更换手机号"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self phoneInput];
    [self passwordInput];
    [self nextBtn];
}

#pragma mark - private method
// 点击其他地方键盘隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)nextAction
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NewPhoneController *newPhoneVC = [mineSB instantiateViewControllerWithIdentifier:@"NewPhoneController"];
    [self.navigationController pushViewController:newPhoneVC animated:YES];
}

#pragma mark - lazy load
-(TextInputView *)phoneInput
{
    if (!_phoneInput) {
        CGFloat x = 0.0f;
        CGFloat y = 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _phoneInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_phoneInput setUnderLine];
        [_phoneInput setIconWithImageName:@"login_phone"];
        [_phoneInput setPlaceHolderText:@"请输入当前手机号"];
        [self.view addSubview:_phoneInput];
    }
    return _phoneInput;
}

-(TextInputView *)passwordInput
{
    if (!_passwordInput) {
        CGFloat x = 0.0f;
        CGFloat y = _phoneInput.frame.origin.y + _phoneInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _passwordInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_passwordInput setIconWithImageName:@"login_pw"];
        [_passwordInput setPlaceHolderText:@"请输入登录密码"];
        [self.view addSubview:_passwordInput];
    }
    return _passwordInput;
}

-(UIButton *)nextBtn
{
    if (!_nextBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _passwordInput.frame.origin.y + _passwordInput.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(x, y, width, height);
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
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
