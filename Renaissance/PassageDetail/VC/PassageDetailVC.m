//
//  PassageDetailVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailVC.h"
#import "PassageDetailLabel.h"
#import "PassageDetailView.h"
#import "PassageDetailCell.h"

@interface PassageDetailVC ()

@property (nonatomic, strong) ChannelItem *data;

@end

@implementation PassageDetailVC {
    UILabel *txtForSizeFitting;
}

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
    
//    PassageDetailView *viewOfPassageDetail = [[PassageDetailView alloc] initWithChannelItemData:self.data];
//    viewOfPassageDetail.frame = CGRectMake(0, Height_NavBar, ScreenW, ScreenH - Height_NavBar);
//    [self.view addSubview:viewOfPassageDetail];
    
//    PassageDetailLabel *txtOfPassageDetail = [[PassageDetailLabel alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenW, ScreenH - Height_NavBar) channelItemData:self.data];
//    [self.view addSubview:txtOfPassageDetail];
    txtForSizeFitting = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:20] textColor:HexColor(@"ffffff") parentView:nil];
    [self.tableView registerClass:[PassageDetailCell class] forCellReuseIdentifier:@"PassageDetailCellIdentifier"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0 ? 10 : 0.01);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineSpacing:10];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.title attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]}];
        txtForSizeFitting.attributedText = attri;
        return [txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 20, MAXFLOAT)].height;
    } else if (indexPath.section == 1) {
//        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.author attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        txtForSizeFitting.attributedText = attri;
        return [txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 20, MAXFLOAT)].height;
    } else if (indexPath.section == 2) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.date.description attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        txtForSizeFitting.attributedText = attri;
        return [txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 20, MAXFLOAT)].height;
    }
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageDetailCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSMutableParagraphStyle *paragraphOfTitle = [[NSMutableParagraphStyle alloc] init];
        [paragraphOfTitle setLineSpacing:10];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.title attributes:@{NSParagraphStyleAttributeName:paragraphOfTitle, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]}];
        [cell resetSubviewsWithAttributeString:attri];
        [cell resetInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    } else if (indexPath.section == 1) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.author attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [cell resetSubviewsWithAttributeString:attri];
    } else if (indexPath.section == 2) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.date.description attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [cell resetSubviewsWithAttributeString:attri];
    }
    
    return cell;
}

@end
