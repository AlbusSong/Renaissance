//
//  ASNavigationController.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASNavigationController.h"

@interface ASNavigationController ()

@end

@implementation ASNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self customNavigationBar];
    self.navigationBar.tintColor = HexColor(@"404040");
}

- (void)customNavigationBar{
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#F1F1F1"]];
    NSInteger leftCapWidth = backgroundImage.size.width * 0.5f;
    NSInteger topCapHeight = backgroundImage.size.height * 0.5f;
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#3D3D3D"],};
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#CCD5DC"]]];
    self.navigationBar.tintColor = HexColor(@"000000");
}

@end
