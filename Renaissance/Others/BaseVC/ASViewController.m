//
//  ASViewController.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASViewController.h"

@interface ASViewController ()

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)pushVC:(UIViewController *)nextVC {
    [self pushVC:nextVC animated:YES];
}

- (void)pushVC:(UIViewController *)nextVC animated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController pushViewController:nextVC animated:animated];
    }
}

- (void)back {
    [self backAnimated:YES];
}

- (void)backAnimated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

@end
