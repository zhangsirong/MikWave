//
//  ZSRXMPPTool.h
//  
//
//  Created by hp on 16/1/2.
//
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
typedef enum {
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeNetErr,//网络不给力
    XMPPResultTypeRegisterSuccess,//注册成功
    XMPPResultTypeRegisterFailure//注册失败
}XMPPResultType;
typedef void (^XMPPResultBlock)(XMPPResultType type);// XMPP请求结果的block

@interface ZSRXMPPTool : NSObject
singleton_interface(ZSRXMPPTool);

@property (nonatomic, strong,readonly)XMPPStream *xmppStream;
@property (nonatomic, strong,readonly)XMPPvCardTempModule *vCard;//电子名片
@property (nonatomic, strong,readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
@property (nonatomic, strong,readonly)XMPPRoster *roster;//花名册模块
@property (nonatomic, strong,readonly)XMPPMessageArchivingCoreDataStorage *msgStorage;//聊天的数据存储

/**
 *  注册标识 YES 注册 / NO 登录
 */
@property (nonatomic, assign,getter=isRegisterOperation) BOOL  registerOperation;//注册操作

/**
 *  用户注销
 
 */
-(void)xmppUserlogout;

/**
 *  用户登录
 */
-(void)xmppUserLogin:(XMPPResultBlock)resultBlock;

/**
 *  用户注册
 */
-(void)xmppUserRegister:(XMPPResultBlock)resultBlock;

@end

