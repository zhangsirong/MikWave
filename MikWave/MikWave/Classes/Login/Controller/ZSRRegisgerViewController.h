//
//  ZSRRegisgerViewController.h
//  
//
//  Created by hp on 16/1/1.
//
//

#import <UIKit/UIKit.h>
@protocol ZSRRegisgerViewControllerDelegate <NSObject>

/**
 *  完成注册
 */
-(void)regisgerViewControllerDidFinishRegister;

@end
@interface ZSRRegisgerViewController : UIViewController
@property (nonatomic, weak) id<ZSRRegisgerViewControllerDelegate> delegate;
@end
