//
//  ZSRInputView.m
//  
//
//  Created by hp on 16/1/2.
//
//

#import "ZSRInputView.h"

@implementation ZSRInputView

+(instancetype)inputView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZSRInputView" owner:nil options:nil] lastObject];
}

@end
