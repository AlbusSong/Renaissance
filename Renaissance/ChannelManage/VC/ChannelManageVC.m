//
//  ChannelManageVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ChannelManageVC.h"
#import "ChannelCell.h"

@interface ChannelManageVC ()

@end

@implementation ChannelManageVC {
    UILabel *txtOfNoData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Renaissance";
    
    txtOfNoData = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:24] textColor:HexColor(@"B0B0B0") parentView:self.tableView];
    txtOfNoData.textAlignment = NSTextAlignmentCenter;
    txtOfNoData.text = @"No Channel.\nTry to add a RSS Channel.";
    txtOfNoData.frame = CGRectMake(0, 0, ScreenW, self.view.frame.size.height - Height_NavBar);
    
    [self.tableView registerClass:[ChannelCell class] forCellReuseIdentifier:@"ChannelCellIdentifier"];
    self.tableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view);
    self.tableView.sd_layout.bottomEqualToView(self.view).topSpaceToView(self.view, Height_NavBar);
}

#pragma mark UITableViewDelegate, UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//    return self.dataArr.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCellIdentifier" forIndexPath:indexPath];
//
//    return cell;
//}

@end
