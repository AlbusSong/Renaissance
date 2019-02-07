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
#import "TFHpple.h"
//#import <IGHTMLQuery.h>

@interface PassageDetailVC ()

@property (nonatomic, strong) ChannelItem *data;
@property (nonatomic, copy) NSString *content;

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
        self.content = [self.data.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self parseData];
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

- (void)parseData {
//    NSLog(@"firstNode: %@", self.data.link);
//    NSString *testStr = @" <blockquote> <p>Trump and other Republicans are using divisions over late-term abortion to their political advantage. They have seized on the Democratic legislation to argue that Democrats are extreme and out of touch with American public opinion on this issue. Trump’s comments on abortion in the State of the Union received loud applause from Republican members of Congress. Ultimately, this may signal how the party will approach abortion in the long windup to the 2020 election: by using extreme cases as a powerful wedge issue.</p></blockquote>";
//    TFHpple *hpple = [TFHpple hppleWithXMLData:[testStr dataUsingEncoding:NSUTF8StringEncoding]];
//    NSArray *arrOfElmOfP = [hpple searchWithXPathQuery:@"//blockquote"];
//    TFHppleElement *elmOfP = arrOfElmOfP.firstObject;
//    NSLog(@"the arrOfElmOfP: %@", arrOfElmOfP);
//    for (TFHppleElement *child in elmOfP.children) {
//        NSLog(@"the child: %@", child);
//    }
//    return;
    
    NSArray *tags = @[@"<p", @"<blockquote"];
    NSArray *closeTags = @[@"/p>", @"/blockquote>"];
    NSInteger index = 0;
    while (self.content.length > 0 && index < 100) {
        index++;
        
        NSInteger tagLocation = -1;
        NSString *presentTag;
        NSString *closeTag;
        for (NSString *tag in tags) {
            NSRange range = [self.content rangeOfString:tag];
            BOOL found = (range.location != NSNotFound);
            if (found) {
                if (tagLocation < 0) {
                    tagLocation = range.location;
                    presentTag = tag;
                    closeTag = [closeTags objectAtIndex:[tags indexOfObject:tag]];
                } else {
                    if (tagLocation > range.location) {
                        tagLocation = range.location;
                        presentTag = tag;
                        closeTag = [closeTags objectAtIndex:[tags indexOfObject:tag]];
                    }
                }
            }
        }
        NSLog(@"tagLocation: %li, %@, %@", tagLocation, presentTag, closeTag);
        if (tagLocation < 0) {
            continue;
        }
        NSRange rangeOfCloseTag = [self.content rangeOfString:closeTag];
        if (rangeOfCloseTag.location == NSNotFound) {
            continue;
        }
        
        NSString *leftContent = [self.content substringToIndex:(rangeOfCloseTag.location + rangeOfCloseTag.length)];
        self.content = [[self.content substringFromIndex:(rangeOfCloseTag.location + rangeOfCloseTag.length)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        TFHpple *hpple = [TFHpple hppleWithXMLData:[leftContent dataUsingEncoding:NSUTF8StringEncoding]];
        NSArray *arrOfElements = [hpple searchWithXPathQuery:[NSString stringWithFormat:@"//%@", [presentTag substringFromIndex:1]]];
        if (arrOfElements.count > 0) {
            [self.dataArr addObject:arrOfElements];
        }
        NSLog(@"arrOfElements: %@", arrOfElements);
        NSLog(@"leftContent: %@", leftContent);
//        NSLog(@"self.content: %@", self.content);
    }
    
    if ([self.tableView numberOfSections] == 4) {
        [self.tableView reloadData];
    }
    
    NSArray *arrOfElements = [self.dataArr firstObject];
    for (TFHppleElement *element in arrOfElements) {
        NSLog(@"element: %@", element);;
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + 1 + self.dataArr.count;
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
    } else if (indexPath.section == 3) {
        
    } else {
        
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
