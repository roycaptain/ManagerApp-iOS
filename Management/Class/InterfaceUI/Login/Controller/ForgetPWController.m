//
//  ForgetPWController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ForgetPWController.h"
#import "TextInputView.h"

@interface ForgetPWController ()

@property(nonatomic,strong)UIImageView *logoImage; // Login 图标
@property(nonatomic,strong)UILabel *manageLabel; // 运营平台
@property(nonatomic,strong)TextInputView *userInput; // 用户名输入
@property(nonatomic,strong)TextInputView *identifierInput; // 验证码输入
@property(nonatomic,strong)TextInputView *passwordInput; // 密码输入
@property(nonatomic,strong)UIButton *sureBtn; // 确定按钮
@property(nonatomic,strong)UIButton *loginBtn; // 去登录按钮

@end

@implementation ForgetPWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginKeyboardWillShow:) name:UIKeyboardWillShowNotification object:NULL];
    // 键盘消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginKeyboardWillHide:) name:UIKeyboardWillHideNotification object:NULL];
    
    [self initUI];
}

#pragma mark - initUI
-(void)initUI
{
    [self logoImage];
    [self manageLabel];
    [self userInput];
    [self identifierInput];
    [self passwordInput];
    [self sureBtn];
    [self loginBtn];
}

#pragma mark - private method
// 点击其他地方键盘隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 获取验证码
-(void)identifyCodeAction
{
    NSLog(@"获取验证码");
}

// 去登录
-(void)loginAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - lazy load
// Logo图标
-(UIImageView *)logoImage
{
    if (!_logoImage) {
        CGFloat width = 100.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = 50.0f;
        
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _logoImage.backgroundColor = [UIColor redColor];
        [self.view addSubview:_logoImage];
    }
    return _logoImage;
}

// 运营平台
-(UILabel *)manageLabel
{
    if (!_manageLabel) {
        CGFloat width = 100.0f;
        CGFloat height = 17.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = _logoImage.frame.origin.y + _logoImage.frame.size.height + 20.0f;
        
        _manageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _manageLabel.text = @"运营平台";
        _manageLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _manageLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _manageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_manageLabel];
    }
    return _manageLabel;
}

// 用户名输入
-(TextInputView *)userInput
{
    if (!_userInput) {
        CGFloat x = 0.0f;
        CGFloat y = _manageLabel.frame.origin.y + _manageLabel.frame.size.height + 49.5f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _userInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_userInput setUnderLine];
        [_userInput setIconWithImageName:@"login_phone"];
        [_userInput setPlaceHolderText:@"请输入手机号"];
        [self.view addSubview:_userInput];
    }
    return _userInput;
}

// 验证码
-(TextInputView *)identifierInput
{
    if (!_identifierInput) {
        CGFloat x = 0.0f;
        CGFloat y = _userInput.frame.origin.y + _userInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _identifierInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_identifierInput setUnderLine];
        [_identifierInput setIconWithImageName:@"login_identifycode"];
        [_identifierInput setPlaceHolderText:@"请输入验证码"];
        [_identifierInput setIdntifyCodeBtn];
        [_identifierInput.identifyCodeBtn addTarget:self action:@selector(identifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_identifierInput];
    }
    return _identifierInput;
}

// 密码
-(TextInputView *)passwordInput
{
    if (!_passwordInput) {
        CGFloat x = 0.0f;
        CGFloat y = _identifierInput.frame.origin.y + _identifierInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _passwordInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_passwordInput setIconWithImageName:@"login_pw"];
        [_passwordInput setPlaceHolderText:@"请输入新密码"];
        [self.view addSubview:_passwordInput];
    }
    return _passwordInput;
}

// 确定按钮
-(UIButton *)sureBtn
{
    if (!_sureBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _passwordInput.frame.origin.y + _passwordInput.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(x, y, width, height);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [self.view addSubview:_sureBtn];
    }
    return _sureBtn;
}

// 去登录
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        CGFloat width = 100.0f;
        CGFloat height = 13.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = _sureBtn.frame.origin.y + _sureBtn.frame.size.height + 20.0f;
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(x, y, width, height);
        [_loginBtn setTitle:@"去登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"#3399FF"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

#pragma mark - NSNotificationCenter Keyboard
- (void)loginKeyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo]; // 获取键盘通知信息
    // 取得键盘的动画时间
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 获取键盘的 Rect
    CGSize keyboardSize = keyboardRect.size;
    CGFloat keyboardHeight = keyboardSize.height; // 键盘的高度
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        UIView *currentView;
        for (UIView *view in @[weakSelf.userInput.textField,weakSelf.passwordInput.textField,weakSelf.identifierInput.textField]) {
            if ([view isFirstResponder]) {
                currentView = [view superview];
            }
        }
        CGFloat viewToBottom = self.view.frame.size.height - CGRectGetMaxY(currentView.frame) - 10.0f;
        CGFloat offeet = viewToBottom - keyboardHeight;
        if (offeet < 0) {
            self.view.frame = CGRectMake(0.0f, offeet, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
        }
    }];
}

///键盘消失事件
- (void)loginKeyboardWillHide:(NSNotification *)notification
{
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:NULL];
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
