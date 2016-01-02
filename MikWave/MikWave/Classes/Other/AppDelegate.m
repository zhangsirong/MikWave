//
//  AppDelegate.m
//  mikwave
//
//  Created by hp on 15/12/26.
//  Copyright (c) 2015年 hp. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"
#import "ZSRNavigationController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置导航栏背景
    [ZSRNavigationController setupNavTheme];
    
    // 从沙里加载用户的数据到单例
    [[ZSRUserInfo sharedZSRUserInfo] loadUserInfoFromSanbox];
    
    // 判断用户的登录状态，YES 直接来到主界面
    if([ZSRUserInfo sharedZSRUserInfo].loginStatus){
        UIStoryboard *storayobard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = storayobard.instantiateInitialViewController;
        
        // 自动登录服务
        [[ZSRXMPPTool sharedZSRXMPPTool] xmppUserLogin:nil];
    }

    return YES;
}


@end
