//
//  ViewController.m
//  mikwave
//
//  Created by hp on 15/12/26.
//  Copyright (c) 2015年 hp. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 做注销
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app logout];
    
}


@end
