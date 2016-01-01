//
//  ZSRUserInfo.h
//  
//
//  Created by hp on 16/1/1.
//
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface ZSRUserInfo : NSObject
singleton_interface(ZSRUserInfo);

@property (nonatomic, copy) NSString *user;//用户名
@property (nonatomic, copy) NSString *pwd;//密码

/**
 *  登录的状态 YES 登录过/NO 注销
 */
@property (nonatomic, assign) BOOL  loginStatus;

/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox;
@end
