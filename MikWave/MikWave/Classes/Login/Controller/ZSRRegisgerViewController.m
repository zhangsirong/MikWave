//
//  ZSRRegisgerViewController.m
//  
//
//  Created by hp on 16/1/1.
//
//

#import "ZSRRegisgerViewController.h"
#import "AppDelegate.h"

@interface ZSRRegisgerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@end

@implementation ZSRRegisgerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"注册";
    
    // 判断当前设备的类型 改变左右两边约束的距离
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        self.leftConstraint.constant = 10;
        self.rightConstraint.constant = 10;
    }
    
    // 设置TextFeild的背景
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    [self.registerBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
}

- (IBAction)registerBtnClick {
    
    // 判断用户输入的是否为手机号码
    if (![self.userField isTelphoneNum]) {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        return;
    }

    // 1.把用户注册的数据保存单例
    ZSRUserInfo *userInfo = [ZSRUserInfo sharedZSRUserInfo];
    userInfo.registerUser = self.userField.text;
    userInfo.registerPwd = self.pwdField.text;
    
    
    // 2.调用ZSRXMPPTool的xmppUserRegister
    
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    app.registerOperation = YES;
    [ZSRXMPPTool sharedZSRXMPPTool].registerOperation = YES;

    // 提示
    
    [MBProgressHUD showMessage:@"正在注册中....." toView:self.view];
    
    __weak typeof(self) selfVc = self;
//    [app xmppUserRegister:^(XMPPResultType type) {
    [[ZSRXMPPTool sharedZSRXMPPTool] xmppUserRegister:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];

    
    
}
/**
 *  处理注册的结果
 */
-(void)handleResultType:(XMPPResultType)type{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTypeNetErr:
                [MBProgressHUD showError:@"网络不稳定" toView:self.view];
                break;
            case XMPPResultTypeRegisterSuccess:
                [MBProgressHUD showError:@"注册成功" toView:self.view];
//                [NSThread sleepForTimeInterval:1];
                // 回到上个控制器
                [self dismissViewControllerAnimated:YES completion:nil];
                
                if ([self.delegate respondsToSelector:@selector(regisgerViewControllerDidFinishRegister)]) {
                    [self.delegate regisgerViewControllerDidFinishRegister];
                }
                break;
                
            case XMPPResultTypeRegisterFailure:
                [MBProgressHUD showError:@"注册失败,用户名重复" toView:self.view];
                break;
            default:
                break;
        }
    });
    
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textChange {
    
    NSLog(@"xxx");
    // 设置注册按钮的可能状态
    BOOL enabled = (self.userField.text.length != 0 && self.pwdField.text.length != 0);
    self.registerBtn.enabled = enabled;
}
@end
