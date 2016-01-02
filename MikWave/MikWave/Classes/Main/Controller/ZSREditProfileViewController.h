//
//  ZSREditProfileViewController.h
//  
//
//  Created by hp on 16/1/2.
//
//

#import <UIKit/UIKit.h>

@protocol ZSREditProfileViewControllerDelegate <NSObject>

-(void)editProfileViewControllerDidSave;


@end

@interface ZSREditProfileViewController : UITableViewController

@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, weak) id<ZSREditProfileViewControllerDelegate> delegate;
@end
