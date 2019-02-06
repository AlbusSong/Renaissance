//
//  AddChannelVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "AddChannelVC.h"

@interface AddChannelVC () <MWFeedParserDelegate>

@property (nonatomic, strong) MWFeedParser *feedParser;

@end

@implementation AddChannelVC {
    UILabel *txtOfHint;
    UITextField *tfd;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Add a Channel";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveChannel)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    txtOfHint = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"909090") parentView:nil];
    txtOfHint.text = @"Input a url, then it will be automatically anylisized. For example: https://www.theamericanconservative.com/feed";
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddChannelCellIdentifier"];
}

#pragma mark action

- (void)saveChannel {
    if (tfd.isFirstResponder) {
        [tfd resignFirstResponder];
    }
    
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:@"https://www.theamericanconservative.com/feed"]];
    self.feedParser.delegate = self;
    self.feedParser.feedParseType = ParseTypeFull;
    self.feedParser.connectionType = ConnectionTypeAsynchronously;
    [self.feedParser parse];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel {
    if (tfd.isFirstResponder) {
        [tfd resignFirstResponder];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"MWFeedInfo: %@\n%@\n%@\n%@\n%@", info.title, info.link, info.url, info.summary, info.lastBuildDate);
    [[DBTool sharedInstance] saveToChannelTableWithData:info];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DBTool sharedInstance] updateLogoUrl:@"https://www.theamericanconservative.com/wp-content/themes/Starkers/images/touch-icon-192.png" ofChannelUrl:info.url.absoluteString title:info.title];
    });
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"MWFeedItem: %@", item);
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    
}

#pragma mark textFieldDidChange

- (void)textFieldDidChange:(UITextField *)theTextField {
    NSLog(@"theTextField: %@", theTextField.text);
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 64;
    } else {
        return [txtOfHint sizeThatFits:CGSizeMake(ScreenW - 10*2, MAXFLOAT)].height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddChannelCellIdentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView removeAllSubviews];
    
    if (indexPath.row == 0) {
        UIView *viewForBorder = [[UIView alloc] init];
        viewForBorder.layer.masksToBounds = YES;
        viewForBorder.layer.borderColor = HexColor(@"909090").CGColor;
        viewForBorder.layer.borderWidth = 1;
        [cell.contentView addSubview:viewForBorder];
        viewForBorder.sd_layout.leftSpaceToView(cell.contentView, 10).rightSpaceToView(cell.contentView, 10).topSpaceToView(cell.contentView, 10).bottomSpaceToView(cell.contentView, 10);
        
        if (tfd == nil) {
            tfd = [UITextField quickTextFieldWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"404040") alignment:NSTextAlignmentLeft placeholder:@"https://" placeholderFont:[UIFont systemFontOfSize:15] placeholderColor:HexColor(@"909090")];
            [tfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        }
        [cell.contentView addSubview:tfd];
        tfd.sd_layout.leftSpaceToView(cell.contentView, 15).rightSpaceToView(cell.contentView, 15).topSpaceToView(cell.contentView, 10).bottomSpaceToView(cell.contentView, 10);
        
    } else {
        [cell.contentView addSubview:txtOfHint];
        txtOfHint.sd_layout.leftSpaceToView(cell.contentView, 10).rightSpaceToView(cell.contentView, 10).topSpaceToView(cell.contentView, 0).bottomSpaceToView(cell.contentView, 0);
    }
    
    return cell;
}

@end