//
//  ZSRLoginViewController.m
//  
//
//  Created by hp on 16/1/1.
//
//

#import "ZSRLoginViewController.h"

@interface ZSRLoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation ZSRLoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置TextField和Btn的样式
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    
    [self.pwdField addLeftViewWithImage:@"Card_Lock"];
    
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    
    
    // 设置用户名为上次登录的用户名
    
    //从沙盒获取用户名
    NSString *user = [ZSRUserInfo sharedZSRUserInfo].user;
    self.userLabel.text = user;
}


- (IBAction)loginBtnClick:(id)sender {
    
    // 保存数据到单例
    
    ZSRUserInfo *userInfo = [ZSRUserInfo sharedZSRUserInfo];
    userInfo.user = self.userLabel.text;
    userInfo.pwd = self.pwdField.text;
    
    // 调用父类的登录
    [super login];
}
@end
