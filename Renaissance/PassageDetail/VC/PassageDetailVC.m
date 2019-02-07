//
//  PassageDetailVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailVC.h"
#import "PassageDetailView.h"

@interface PassageDetailVC ()

@property (nonatomic, strong) ChannelItem *data;

@end

@implementation PassageDetailVC

- (instancetype)initWithChannelItemData:(ChannelItem *)data {
    self = [super init];
    if (self) {
        self.title = @"Renaissance";
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannel)];
        
        self.data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PassageDetailView *viewOfPassageDetail = [[PassageDetailView alloc] init];
    viewOfPassageDetail.frame = CGRectMake(0, Height_NavBar, ScreenW, ScreenH - Height_NavBar);
    [self.view addSubview:viewOfPassageDetail];
}

@end
