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

@implementation ChannelService {
    BOOL parsed;
}

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
        
        parsed = NO;
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

- (void)extractFavoIconOf:(NSString *)url {
    WS(weakSelf)
    [[HttpDigger sharedInstance].networkMgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress: %.2f", downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf parseHtmlData:responseObject ofUrl:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)parseHtmlData:(NSData *)htmlData ofUrl:(NSString *)url {
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
//    NSLog(@"headString: %@", headString);
    
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
    [[DBTool sharedInstance] updateLogoUrl:logoUrl favoiconUrl:faviconUrl ofChannelUrl:self.rssChannelUrl];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        [self.delegate parsingChannelWithState:ChannelParsingStateTotalSuccess];
    }
}

- (void)extractCoverPictureOf:(NSString *)link identifierMd5Value:(NSString *)identifierMd5Value {
    NSLog(@"extractCoverPictureOf: %@", link);
    
    WS(weakSelf)
    [[HttpDigger sharedInstance].networkMgr GET:link parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress: %.2f", downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf parseCoverPictureWithHtmlData:responseObject identifierMd5Value:identifierMd5Value];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)parseCoverPictureWithHtmlData:(NSData *)htmlData identifierMd5Value:(NSString *)identifierMd5Value {
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    NSRange rangeOfLeftBodyTag = [htmlString rangeOfString:@"<body"];
    if (rangeOfLeftBodyTag.location == NSNotFound) {
        return;
    }
    NSRange rangeOfRightBodyTag = [htmlString rangeOfString:@"/body>"];
    if (rangeOfRightBodyTag.location == NSNotFound) {
        return;
    }
    NSString *bodyString = [htmlString substringWithRange:NSMakeRange(rangeOfLeftBodyTag.location, rangeOfRightBodyTag.length + rangeOfRightBodyTag.location - rangeOfLeftBodyTag.location)];
    NSLog(@"bodyString: %@", bodyString);
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arrOfLinks = [hpple searchWithXPathQuery:@"//img"];
    if (arrOfLinks.count == 0) {
        return;
    }
    //    TFHppleElement *elmOfLink = arrOfLinks.firstObject;
    NSString *coverUrl;
    for (TFHppleElement *elmOfImg in arrOfLinks) {
        NSLog(@"imgimgimg: %@\n%@", elmOfImg.content, elmOfImg.attributes);
        NSString *class = elmOfImg.attributes[@"class"];
        if (!class) {
            continue;
        }
        
        if ([class containsString:@"thumbnail"]) {
            continue;
        }
        
        NSString *src = elmOfImg.attributes[@"src"];
        if (src.length == 0) {
            continue;
        }
        
        if ([class containsString:@"attachment-full"]) {
            coverUrl = src;
        }
    }
    [[DBTool sharedInstance] updateCoverUrl:coverUrl identifierMd5Value:identifierMd5Value];
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.delegate parsingChannelWithState:ChannelParsingStateStarted];
        });
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"MWFeedInfo: %@\n%@\n%@\n%@\n%@", info.title, info.link, info.url, info.summary, info.lastBuildDate);
    [[DBTool sharedInstance] saveToChannelTableWithData:info];
    WS(weakSelf)
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf extractFavoIconOf:info.link];
    }];
    [self.imageExtractionQueue addOperation:op];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf.delegate parsingChannelWithState:ChannelParsingStateOnTheWay];
        });
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
//    NSLog(@"_____________________________________");
//    NSLog(@"MWFeedItem: %@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@", item.title, item.identifier, item.link, item.date, item.updated, item.summary, item.author, item.enclosures, item.content);
    
    [[DBTool sharedInstance] saveToChannelItemTableWithData:item urlMd5Value:[GlobalTool md5String:self.rssChannelUrl]];
    
    WS(weakSelf)
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf extractCoverPictureOf:item.link identifierMd5Value:[GlobalTool md5String:item.identifier]];
    }];
    [self.imageExtractionQueue addOperation:op];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"parser finish: %@", parser);
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        [self.delegate parsingChannelWithState:ChannelParsingStatePartialSuccess];
    }
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(parsingChannelWithState:)]) {
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.delegate parsingChannelWithState:ChannelParsingStateFailed];
        });
    }
}

@end
