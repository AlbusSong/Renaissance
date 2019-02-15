//
//  ASNavigationController+SVProgressHud.m
//  Renaissance
//
//  Created by Albus on 2019/2/15.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASNavigationController+SVProgressHud.h"

@implementation ASNavigationController (SVProgressHud)

- (void)setSVProgressHudStyle {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setErrorImage:nil];
    [SVProgressHUD setInfoImage:nil];
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(UIRectEdgeRight, UIRectEdgeBottom)];
    [SVProgressHUD setAnimationDelay:2.0];
    [SVProgressHUD setHapticsEnabled:YES];
}

@end
