//
//  LoginController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "LoginController.h"
#import "TextInputView.h"
#import "ForgetPWController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"

@interface LoginController ()

@property(nonatomic,strong)UIImageView *logoImage; // Login 图标
@property(nonatomic,strong)UILabel *manageLabel; // 运营平台
@property(nonatomic,strong)TextInputView *userNameInput; // 用户名
@property(nonatomic,strong)TextInputView *passwordInput; // 密码
@property(nonatomic,strong)UIButton *loginBtn; // 登录按钮
@property(nonatomic,strong)UIButton *forgetBtn; // 忘记密码

@end

@implementation LoginController

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
    [self userNameInput];
    [self passwordInput];
    [self loginBtn];
//    [self forgetBtn]; // 忘记密码
}

#pragma mark - click action
// 点击登录
-(void)loginClickAction
{
    [self.view endEditing:YES];
    NSString *userName = _userNameInput.textField.text;
    NSString *password = _passwordInput.textField.text;
    
    if ([Tool isBlankString:userName]) { // 验证用户名
        [CustomAlertView showWithWarnMessage:@"请输入用户名"];
        return;
    }
    if ([Tool checkPasswordInput:password]) { // 验证密码
        [CustomAlertView showWithWarnMessage:@"请输入密码"];
        return;
    }
    
    //先将密码转换成base64
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *passwordBase = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    NSDictionary *bodyParam = @{@"userName" : userName,@"passWord" : passwordBase};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestPostWithURLString:URLInterfaceUserLogin WithHTTPHeaderFieldDictionary:NULL withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        NSString *code = [resultDictionary objectForKey:@"code"];
        NSString *msg = [resultDictionary objectForKey:@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        // 存储用户信息(手机号和访问令牌)
        NSString *accessToken = [[resultDictionary objectForKey:@"data"] objectForKey:@"access_token"];
        [[UserInfoManager shareInstance] saveUserInfoAccount:userName andAccessToken:accessToken];
        [weakSelf redirectTargetController];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - private method
// 点击其他地方键盘隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 点击忘记密码
-(void)forgetPWAction
{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    ForgetPWController *forgetPWVC = [loginSB instantiateViewControllerWithIdentifier:@"ForgetPWController"];
    [self presentViewController:forgetPWVC animated:YES completion:NULL];
}

// 登录成功后跳转到 TabBar主界面
-(void)redirectTargetController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
    appDelegate.window.rootViewController = mainTabBarController;
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
        _logoImage.image = [UIImage imageNamed:@"icon_logo"];
        _logoImage.contentMode = UIViewContentModeScaleAspectFill;
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
-(TextInputView *)userNameInput
{
    if (!_userNameInput) {
        CGFloat x = 0.0f;
        CGFloat y = _manageLabel.frame.origin.y + _manageLabel.frame.size.height + 49.5f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _userNameInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_userNameInput setUnderLine];
        [_userNameInput setIconWithImageName:@"login_user"];
        [_userNameInput setPlaceHolderText:@"请输入用户名"];
        [self.view addSubview:_userNameInput];
    }
    return _userNameInput;
}

// 密码输入
-(TextInputView *)passwordInput
{
    if (!_passwordInput) {
        CGFloat x = 0.0f;
        CGFloat y = _userNameInput.frame.origin.y + _userNameInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _passwordInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _passwordInput.textField.secureTextEntry = YES;
        [_passwordInput setIconWithImageName:@"login_pw"];
        [_passwordInput setPlaceHolderText:@"请输入密码"];
        [self.view addSubview:_passwordInput];
    }
    return _passwordInput;
}

// 登录按钮
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _passwordInput.frame.origin.y + _passwordInput.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(x, y, width, height);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

// 忘记密码
-(UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        CGFloat width = 100.0f;
        CGFloat height = 13.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = _loginBtn.frame.origin.y + _loginBtn.frame.size.height + 50.0f;
        
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.frame = CGRectMake(x, y, width, height);
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"#3399FF"] forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        [_forgetBtn addTarget:self action:@selector(forgetPWAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetBtn];
    }
    return _forgetBtn;
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
        for (UIView *view in @[weakSelf.userNameInput.textField,weakSelf.passwordInput.textField]) {
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
