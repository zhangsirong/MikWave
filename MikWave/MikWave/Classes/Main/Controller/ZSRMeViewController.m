//
//  ZSRMeViewController.m
//  
//
//  Created by hp on 16/1/1.
//
//

#import "ZSRMeViewController.h"
#import "XMPPvCardTemp.h"
@interface ZSRMeViewController ()
- (IBAction)logoutBtnClick:(id)sender;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

/**
 *  微信号
 */
@property (weak, nonatomic) IBOutlet UILabel *weixinNumLabel;

@end

@implementation ZSRMeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 显示当前用户个人信息
    
    // 如何使用CoreData获取数据
    // 1.上下文【关联到数据】
    
    // 2.FetchRequest
    
    // 3.设置过滤和排序
    
    // 4.执行请求获取数据
    
    //xmpp提供了一个方法，直接获取个人信息
    XMPPvCardTemp *myVCard =[ZSRXMPPTool sharedZSRXMPPTool].vCard.myvCardTemp;
    
    // 设置头像
    if(myVCard.photo){
        self.headerView.image = [UIImage imageWithData:myVCard.photo];
    }
    
    // 设置昵称
    self.nickNameLabel.text = myVCard.nickname;
    
    // 设置微信号[用户名]
    
    NSString *user = [ZSRUserInfo sharedZSRUserInfo].user;
    self.weixinNumLabel.text = [NSString stringWithFormat:@"微信号:%@",user];
    
}

- (IBAction)logoutBtnClick:(id)sender {
    
    //直接调用 appdelegate的注销方法
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    [app xmppUserlogout];
    [[ZSRXMPPTool sharedZSRXMPPTool] xmppUserlogout];
}
@end
