//
//  ZSRUserInfo.m
//  
//
//  Created by hp on 16/1/1.
//
//

#import "ZSRUserInfo.h"

#define UserKey @"user"
#define LoginStatusKey @"LoginStatus"
#define PwdKey @"pwd"

static NSString *domain = @"rong.com";

@implementation ZSRUserInfo

singleton_implementation(ZSRUserInfo)

-(void)saveUserInfoToSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults synchronize];
    
}

-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
    self.pwd = [defaults objectForKey:PwdKey];
}

-(NSString *)jid{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}

@end
