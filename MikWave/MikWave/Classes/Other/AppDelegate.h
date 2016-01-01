//
//  AppDelegate.h
//  mikwave
//
//  Created by hp on 15/12/26.
//  Copyright (c) 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeNetErr//网络不给力
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);// XMPP请求结果的block
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

/**
 *  用户注销
 
 */
-(void)xmppUserlogout;

/**
 *  用户登录
 */
-(void)xmppUserLogin:(XMPPResultBlock)resultBlock;
@end

