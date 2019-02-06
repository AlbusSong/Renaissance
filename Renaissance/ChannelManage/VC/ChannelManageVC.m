//
//  ChannelManageVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ChannelManageVC.h"

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
    txtOfNoData.frame = CGRectMake(0, 0, ScreenW, self.view.frame.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
