//
//  ChannelService.m
//  Renaissance
//
//  Created by Albus on 2019/2/11.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ChannelService.h"
#import "TFHpple.h"

static ChannelService *instance = nil;

@interface ChannelService () <MWFeedParserDelegate>

@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, copy) NSString *rssChannelUrl;
//@property (nonatomic, strong) dispatch_queue_t imageExtractionQueue;
@property (nonatomic, strong) NSOperationQueue *imageExtractionQueue;

@end

@implementation ChannelService

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    if (instance) {
        return instance;
    }
    
    self = [super init];
    if (self) {
        // TODO
//        self.imageExtractionQueue = dispatch_queue_create("com.albus.imageExtractionQueue", DISPATCH_QUEUE_CONCURRENT);
        self.imageExtractionQueue = [[NSOperationQueue alloc] init];
        self.imageExtractionQueue.maxConcurrentOperationCount = 3;
    }
    return self;
}

- (void)startToParseRSSChannel:(NSString *)channelUrl {
    self.rssChannelUrl = channelUrl;
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:channelUrl]];
    self.feedParser.delegate = self;
    self.feedParser.feedParseType = ParseTypeFull;
    self.feedParser.connectionType = ConnectionTypeAsynchronously;
    [self.feedParser parse];
}

#pragma mark action

- (void)extractFavoIconOf:(NSString *)url forChannel:(NSString *)channel {
    WS(weakSelf)
    [[HttpDigger sharedInstance].networkMgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress: %.2f", downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf parseHtmlData:responseObject ofUrl:url forChannel:channel];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)parseHtmlData:(NSData *)htmlData ofUrl:(NSString *)url forChannel:(NSString *)channel {
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    NSRange rangeOfLeftHeadTag = [htmlString rangeOfString:@"<head"];
    if (rangeOfLeftHeadTag.location == NSNotFound) {
        return;
    }
    NSRange rangeOfRightHeadTag = [htmlString rangeOfString:@"/head>"];
    if (rangeOfRightHeadTag.location == NSNotFound) {
        return;
    }
    NSString *headString = [htmlString substringWithRange:NSMakeRange(rangeOfLeftHeadTag.location, rangeOfRightHeadTag.length + rangeOfRightHeadTag.location - rangeOfLeftHeadTag.location)];
    NSLog(@"headString: %@", headString);
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:[headString dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arrOfLinks = [hpple searchWithXPathQuery:@"//link"];
    if (arrOfLinks.count == 0) {
        return;
    }
//    TFHppleElement *elmOfLink = arrOfLinks.firstObject;
    NSString *faviconUrl;
    NSString *logoUrl;
    for (TFHppleElement *elmOfLink in arrOfLinks) {
        NSLog(@"linklinklink: %@\n%@", elmOfLink.content, elmOfLink.attributes);
        NSString *type = elmOfLink.attributes[@"type"];
        if (type) {
            if ([type containsString:@"css"] ||
                [type containsString:@"xml"] ||
                [type containsString:@"html"] ||
                [type containsString:@"text"] ||
                [type containsString:@"application"] ||
                [type containsString:@"stylesheet"]) {
                continue;
            }
        }
        
        NSString *rel = elmOfLink.attributes[@"rel"];
        NSString *href = elmOfLink.attributes[@"href"];
        if (href.length == 0) {
            continue;
        }
        
        if ([rel containsString:@"alternate"]) {
            continue;
        } else if ([rel isEqualToString:@"icon"]) {
            logoUrl = href;
        } else if ([rel isEqualToString:@"shortcut icon"]) {
            faviconUrl = [NSString stringWithFormat:@"%@%@", url, href];
        }
    }
    
    if (faviconUrl.length == 0) {
        faviconUrl = logoUrl;
    }
    [[DBTool sharedInstance] updateLogoUrl:logoUrl favoiconUrl:faviconUrl ofChannelUrl:channel];
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        [self.delegate parsingChannelWithState:ChannelParsingStateStarted];
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"MWFeedInfo: %@\n%@\n%@\n%@\n%@", info.title, info.link, info.url, info.summary, info.lastBuildDate);
    [[DBTool sharedInstance] saveToChannelTableWithData:info];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[DBTool sharedInstance] updateLogoUrl:@"https://www.theamericanconservative.com/wp-content/themes/Starkers/images/touch-icon-192.png" ofChannelUrl:info.url.absoluteString];
//    });
    WS(weakSelf)
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf extractFavoIconOf:info.link forChannel:info.url.absoluteString];
    }];
    [self.imageExtractionQueue addOperation:op];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        [self.delegate parsingChannelWithState:ChannelParsingStateOnTheWay];
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
//    NSLog(@"_____________________________________");
//    NSLog(@"MWFeedItem: %@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@", item.title, item.identifier, item.link, item.date, item.updated, item.summary, item.author, item.enclosures, item.content);
    
    [[DBTool sharedInstance] saveToChannelItemTableWithData:item urlMd5Value:[GlobalTool md5String:self.rssChannelUrl]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[DBTool sharedInstance] updateCoverUrl:@"https://www.theamericanconservative.com/wp-content/uploads/2018/07/trump-bolton-pompeo.jpg" identifierMd5Value:[GlobalTool md5String:item.identifier]];
//    });
    
//    WS(weakSelf)
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        [weakSelf extractFavoIconOf:item.link];
//    }];
//    [self.imageExtractionQueue addOperation:op];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"parser finish: %@", parser);
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    
}

@end
