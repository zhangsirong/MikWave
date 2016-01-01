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
@end

@implementation ZSRLoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置用户名为上次登录的用户名
    
    //从沙盒获取用户名
    NSString *user = [ZSRUserInfo sharedZSRUserInfo].user;
    self.userLabel.text = user;
}


@end
