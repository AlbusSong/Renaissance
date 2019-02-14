//
//  ChannelManageVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ChannelManageVC.h"
#import "AddChannelVC.h"
#import "PassageListVC.h"
#import "ChannelCell.h"

@interface ChannelManageVC () <ChannelServiceDelegate>

@end

@implementation ChannelManageVC {
    UILabel *txtOfNoData;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Renaissance";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannel)];
        
        [DBTool sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshSelfData];
    
    txtOfNoData = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:24] textColor:HexColor(@"B0B0B0") parentView:self.tableView];
    txtOfNoData.textAlignment = NSTextAlignmentCenter;
    txtOfNoData.text = @"No Channel.\nTry to add a RSS Channel.";
    txtOfNoData.frame = CGRectMake(0, 0, ScreenW, self.view.frame.size.height - Height_NavBar);
    
    [self.tableView registerClass:[ChannelCell class] forCellReuseIdentifier:@"ChannelCellIdentifier"];
}

- (void)refreshSelfData {
    self.arrOfData = [[DBTool sharedInstance] getAllAvailableChannels];
}

#pragma mark action

- (void)addChannel {
    AddChannelVC *vcToAddChannel = [[AddChannelVC alloc] init];
    WS(weakSelf)
    vcToAddChannel.completionHandler = ^(BOOL success) {
        if (success) {
            [ChannelService sharedInstance].delegate = self;
            [weakSelf refreshSelfData];
            [weakSelf.tableView reloadData];
        }
    };
    ASNavigationController *nav = [[ASNavigationController alloc] initWithRootViewController:vcToAddChannel];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark ChannelServic®eDelegate

- (void)parsingChannelWithState:(ChannelParsingState)state {
    if (state == ChannelParsingStateTotalSuccess) {
        [self refreshSelfData];
        [self.tableView reloadData];
        
        [ChannelService sharedInstance].delegate = nil;
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.arrOfData.count;
    if (count > 0) {
        txtOfNoData.hidden = YES;
    } else {
        txtOfNoData.hidden = NO;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCellIdentifier" forIndexPath:indexPath];
    [cell resetSubviewsWithData:[self.arrOfData objectAtIndex:indexPath.item]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PassageListVC *vcOfPassageList = [[PassageListVC alloc] initWithChannelData:[self.arrOfData objectAtIndex:indexPath.item]];
    [self pushVC:vcOfPassageList];
}

@end
