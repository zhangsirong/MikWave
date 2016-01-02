//
//  ZSRMeViewController.m
//  
//
//  Created by hp on 16/1/1.
//
//

#import "ZSRMeViewController.h"
#import "AppDelegate.h"
@interface ZSRMeViewController ()
- (IBAction)logoutBtnClick:(id)sender;

@end

@implementation ZSRMeViewController

- (IBAction)logoutBtnClick:(id)sender {
    
    //直接调用 appdelegate的注销方法
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    [app xmppUserlogout];
    [[ZSRXMPPTool sharedZSRXMPPTool] xmppUserlogout];
}
@end
