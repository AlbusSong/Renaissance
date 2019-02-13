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
    self.tableView.backgroundColor = self.view.backgroundColor;
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
//        NSLog(@"element: %@", element.tagName);;
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
    CGFloat result = 0.0;
    if (indexPath.section == 0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineSpacing:10];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.title attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]}];
        YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(ScreenW - 20, MAXFLOAT)];
        YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attri];
        result = textLayout.textBoundingSize.height;
    } else if (indexPath.section == 1) {
//        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.author attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(ScreenW - 20, MAXFLOAT)];
        YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attri];
        result = textLayout.textBoundingSize.height;
    } else if (indexPath.section == 2) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.date.description attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(ScreenW - 20, MAXFLOAT)];
        YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attri];
        result = textLayout.textBoundingSize.height;
    } else if (indexPath.section == 3) {
        result = 160;
    } else {
        NSArray *arrOfElements = [self.dataArr objectAtIndex:(indexPath.section - 4)];
        TFHppleElement *topElement = arrOfElements.firstObject;
        NSLog(@"topElement: %@\n%@", topElement.tagName, topElement.content);
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineSpacing:8];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:topElement.content attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:HexColor(@"303030"), NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        NSArray *childrenElements = topElement.children;
        for (int i = 0; i < childrenElements.count; i++) {
            TFHppleElement *element = [childrenElements objectAtIndex:i];
            NSLog(@"element: %@", element);
            if ([element.tagName isEqualToString:@"img"]) {
                NSDictionary *theAttributes = element.attributes;
//                NSLog(@"^^^^^^^^^^^^^^^^^: %@", theAttributes);
                CGFloat widthOfImg = [theAttributes[@"width"] floatValue];
                CGFloat heightOfImg = [theAttributes[@"height"] floatValue];
                return heightOfImg * (ScreenW - 20) / widthOfImg;
            } else if ([element.tagName isEqualToString:@"a"]) {
                NSLog(@"#############: %@", element);
                NSRange rangeOfA = [topElement.content rangeOfString:element.content];
                if (rangeOfA.location != NSNotFound) {
                    NSMutableAttributedString *attriOfA = [[NSMutableAttributedString alloc] initWithString:element.content attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor greenColor], NSFontAttributeName:[UIFont systemFontOfSize:15], NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
                    [attri replaceCharactersInRange:rangeOfA withAttributedString:attriOfA];
                }
            }
        }
        
        txtForSizeFitting.attributedText = attri;
        CGSize sizeForFitting = CGSizeZero;
        if ([topElement.tagName isEqualToString:@"p"]) {
            sizeForFitting = CGSizeMake(ScreenW - 10*2, MAXFLOAT);
            result = [txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 10*2, MAXFLOAT)].height;
        } else if ([topElement.tagName isEqualToString:@"blockquote"]) {
            sizeForFitting = CGSizeMake(ScreenW - 10 - 20, MAXFLOAT);
            result = [txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 10 - 20, MAXFLOAT)].height;
        }
        YYTextContainer* container = [YYTextContainer containerWithSize:sizeForFitting];
        YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attri];
        result = textLayout.textBoundingSize.height;
    }
    
    return ceilf(result);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageDetailCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSMutableParagraphStyle *paragraphOfTitle = [[NSMutableParagraphStyle alloc] init];
        [paragraphOfTitle setLineSpacing:10];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.title attributes:@{NSParagraphStyleAttributeName:paragraphOfTitle, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]}];
        [cell resetSubviewsWithAttributeString:attri];
        [cell resetTextInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    } else if (indexPath.section == 1) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.author attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [cell resetSubviewsWithAttributeString:attri];
    } else if (indexPath.section == 2) {
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:self.data.date.description attributes:@{NSForegroundColorAttributeName:HexColor(@"909090"), NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [cell resetSubviewsWithAttributeString:attri];
        [cell resetTextInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    } else if (indexPath.section == 3) {
        [cell resetSubviewsWithImageUrl:self.data.coverUrl];
    } else {
        NSArray *arrOfElements = [self.dataArr objectAtIndex:(indexPath.section - 4)];
        TFHppleElement *topElement = arrOfElements.firstObject;
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineSpacing:8];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:topElement.content attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:HexColor(@"303030"), NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
//        NSLog(@"topElement: %@\n%@", topElement.tagName, topElement.content);
        NSArray *childrenElements = topElement.children;
        NSRange rangeOfLink = NSMakeRange(-1, -1);
        NSMutableAttributedString *attriOfLink;
//        NSLog(@"rangerange: %li, %li", range.location, range.length);
        for (int i = 0; i < childrenElements.count; i++) {
            TFHppleElement *element = [childrenElements objectAtIndex:i];
//            NSLog(@"element: %@", element);
            if ([element.tagName isEqualToString:@"img"]) {
                NSDictionary *theAttributes = element.attributes;
                [cell resetSubviewsWithImageUrl:theAttributes[@"src"]];
                return cell;
            } else if ([element.tagName isEqualToString:@"a"]) {
                NSRange rangeOfA = [topElement.content rangeOfString:element.content];
                if (rangeOfA.location != NSNotFound) {
                    attriOfLink = [[NSMutableAttributedString alloc] initWithString:element.content attributes:@{NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:HexColor(@"36428f"), NSFontAttributeName:[UIFont systemFontOfSize:15], NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
                    rangeOfLink = rangeOfA;
                }
            }
        }
        
        if ([topElement.tagName isEqualToString:@"p"]) {
            [attri addAttribute:NSForegroundColorAttributeName value:HexColor(@"303030") range:NSMakeRange(0, topElement.content.length)];
            if (attriOfLink && rangeOfLink.location >= 0) {
                [attri replaceCharactersInRange:rangeOfLink withAttributedString:attriOfLink];
            }
            [cell resetSubviewsWithAttributeString:attri];
            [cell resetTextInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        } else if ([topElement.tagName isEqualToString:@"blockquote"]) {
            [attri addAttribute:NSForegroundColorAttributeName value:HexColor(@"606060") range:NSMakeRange(0, topElement.content.length)];
            if (attriOfLink && rangeOfLink.location >= 0) {
                [attri replaceCharactersInRange:rangeOfLink withAttributedString:attriOfLink];
            }
            [cell resetSubviewsWithAttributeString:attri];
            [cell resetTextInsets:UIEdgeInsetsMake(0, 20, 0, 10)];
            [cell showVerticalGrayLine];
        }
    }
    
    return cell;
}

@end
