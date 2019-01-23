//
//  NewPhoneController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "NewPhoneController.h"
#import "TextInputView.h"
#import "ResultController.h"

@interface NewPhoneController ()

@property(nonatomic,strong)TextInputView *phoneInput;
@property(nonatomic,strong)TextInputView *identifyInput;
@property(nonatomic,strong)UIButton *doneBtn;

@end

@implementation NewPhoneController

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
    [self identifyInput];
    [self doneBtn];
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

// 完成
-(void)doneAction
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    ResultController *resultVC = [mineSB instantiateViewControllerWithIdentifier:@"ResultController"];
    resultVC.result = NO;
    [self.navigationController pushViewController:resultVC animated:YES];
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
        [_phoneInput setPlaceHolderText:@"请输入新手机号码"];
        [self.view addSubview:_phoneInput];
    }
    return _phoneInput;
}

// 验证码
-(TextInputView *)identifyInput
{
    if (!_identifyInput) {
        CGFloat x = 0.0f;
        CGFloat y = _phoneInput.frame.origin.y + _phoneInput.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _identifyInput = [[TextInputView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_identifyInput setIconWithImageName:@"login_identifycode"];
        [_identifyInput setPlaceHolderText:@"请输入验证码"];
        [_identifyInput setIdntifyCodeBtn];
        [_identifyInput.identifyCodeBtn addTarget:self action:@selector(identifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_identifyInput];
    }
    return _identifyInput;
}

-(UIButton *)doneBtn
{
    if (!_doneBtn) {
        CGFloat x = 15.0f;
        CGFloat y = _identifyInput.frame.origin.y + _identifyInput.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 49.0f;
        
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.frame = CGRectMake(x, y, width, height);
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_doneBtn];
    }
    return _doneBtn;
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
