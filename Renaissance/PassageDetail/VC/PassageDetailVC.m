//
//  PassageDetailVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailVC.h"

@interface PassageDetailVC ()

@end

@implementation PassageDetailVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Renaissance";
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannel)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
