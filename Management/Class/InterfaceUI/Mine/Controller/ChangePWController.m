//
//  ChangePWController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChangePWController.h"
#import "TextTitleField.h"

@interface ChangePWController ()

@property(nonatomic,strong)TextTitleField *oldPWInput;
@property(nonatomic,strong)TextTitleField *newPWInput;
@property(nonatomic,strong)TextTitleField *confirmInput;
@property(nonatomic,strong)UIButton *saveBtn;

@end

@implementation ChangePWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"修改密码"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self oldPWInput];
    [self newPWInput];
    [self confirmInput];
    [self saveBtn];
}

#pragma mark - private method
// 点击其他地方键盘隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)saveAction
{
    [self.view endEditing:YES];
    
    NSString *oldPWString = _oldPWInput.textField.text;
    NSString *newPWString = _newPWInput.textField.text;
    NSString *confirmString = _confirmInput.textField.text;
    if ([Tool isBlankString:oldPWString]) {
        [CustomAlertView showWithWarnMessage:@"请输入当前密码"];
        return;
    }
    if ([Tool isBlankString:newPWString]) {
        [CustomAlertView showWithWarnMessage:@"请输入新密码"];
        return;
    }
    if ([Tool checkPasswordInput:confirmString]) {
        [CustomAlertView showWithWarnMessage:@"请再次输入新密码"];
        return;
    }
    if (![newPWString isEqualToString:confirmString]) {
        [CustomAlertView showWithWarnMessage:@"输入的两次密码不一样"];
        return;
    }
    
    NSDictionary *bodyParam = @{@"oldPassWord" : oldPWString, @"newPassWord" : newPWString};
    [self startNetworkRequest:bodyParam];
}

-(void)startNetworkRequest:(NSDictionary *)bodyParam
{
    // 获取用户个人信息
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestPUTWithURLString:URLInterfaceChangePW WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        [CustomAlertView showWithSuccessMessage:OperationSuccess];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(TextTitleField *)oldPWInput
{
    if (!_oldPWInput) {
        CGFloat x = 0.0f;
        CGFloat y = 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _oldPWInput = [[TextTitleField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_oldPWInput setUnderLine];
        [_oldPWInput setTitleWithText:@"旧密码"];
        [_oldPWInput setPlaceHolderText:@"请输入当前密码"];
        [_oldPWInput setTextFieldSecureTextEntry];
        [self.view addSubview:_oldPWInput];
    }
    return _oldPWInput;
}

-(TextTitleField *)newPWInput
{
    if (!_newPWInput) {
        CGFloat x = 0.0f;
        CGFloat y = _oldPWInput.frame.origin.y + _oldPWInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _newPWInput = [[TextTitleField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_newPWInput setUnderLine];
        [_newPWInput setTitleWithText:@"新密码"];
        [_newPWInput setPlaceHolderText:@"请输入新密码"];
        [_newPWInput setTextFieldSecureTextEntry];
        [self.view addSubview:_newPWInput];
    }
    return _newPWInput;
}

-(TextTitleField *)confirmInput
{
    if (!_confirmInput) {
        CGFloat x = 0.0f;
        CGFloat y = _newPWInput.frame.origin.y + _newPWInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _confirmInput = [[TextTitleField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_confirmInput setTitleWithText:@"确认密码"];
        [_confirmInput setPlaceHolderText:@"请再次输入新密码"];
        [_confirmInput setTextFieldSecureTextEntry];
        [self.view addSubview:_confirmInput];
    }
    return _confirmInput;
}

-(UIButton *)saveBtn
{
    if (!_saveBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _confirmInput.frame.origin.y + _confirmInput.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(x, y, width, height);
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveBtn];
    }
    return _saveBtn;
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
