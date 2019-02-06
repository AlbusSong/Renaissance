//
//  DBTool.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "DBTool.h"

static DBTool *instance = nil;

@interface DBTool ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation DBTool

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
        [self initDatabase];
    }
    return self;
}

#pragma mark channel_tb operation

- (NSMutableArray *)getAllAvailableChannels {
    [self.database open];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet* selectResult = [self.database executeQuery:@"SELECT * FROM channel_tb WHERE isDeleted = 0 ORDER BY createTime;"];
    while ([selectResult next]) {
        Channel *data = [[Channel alloc] init];
        data.urlMd5Value = [selectResult stringForColumn:@"urlMd5Value"];
        data.title = [selectResult stringForColumn:@"title"];
        data.link = [selectResult stringForColumn:@"link"];
        data.url = [NSURL URLWithString:[selectResult stringForColumn:@"url"]];
        data.summary = [selectResult stringForColumn:@"summary"];
        data.logoUrl = [selectResult stringForColumn:@"logoUrl"];
        data.favoiconUrl = [selectResult stringForColumn:@"favoiconUrl"];
        data.isDeleted = [[selectResult stringForColumn:@"isDeleted"] intValue];
        data.isCollected = [[selectResult stringForColumn:@"isCollected"] intValue];
        data.createTime = [[selectResult stringForColumn:@"createTime"] integerValue];
        data.lastBuildDate = [selectResult dateForColumn:@"lastBuildDate"];
        
        [result addObject:data];
    }
    
    return result;
}

- (void)updateLogoUrl:(NSString *)logoUrl ofChannelUrl:(NSString *)channelUrl {
    [self updateLogoUrl:logoUrl favoiconUrl:nil ofChannelUrl:channelUrl];
}

- (void)updateLogoUrl:(nullable NSString *)logoUrl favoiconUrl:(nullable NSString *)favoiconUrl ofChannelUrl:(NSString *)channelUrl {
    if (logoUrl.length == 0 && favoiconUrl.length == 0) {
        return;
    }
    
    [self.database open];
    BOOL result = [self.database executeUpdate:@"UPDATE channel_tb SET logoUrl = ?, favoiconUrl = ? WHERE urlMd5Value = ?;", logoUrl.length > 0 ? logoUrl : @"", favoiconUrl.length > 0 ? favoiconUrl : @"", [GlobalTool md5String:channelUrl]];
    
    if (result) {
        NSLog(@"updated successfully");
    } else {
        NSLog(@"failed to cache");
    }
}

- (void)saveToChannelTableWithData:(MWFeedInfo *)feedInfo {
    if (feedInfo == nil) {
        return;
    }
    
    [self.database open];
    
    NSLog(@"lastBuildDatelastBuildDatelastBuildDate: %li, %li", (NSInteger)[feedInfo.lastBuildDate timeIntervalSince1970], (NSInteger)[[NSDate date] timeIntervalSince1970]);
    BOOL result = [self.database executeUpdate:@"INSERT INTO channel_tb (urlMd5Value, title, link, url, summary, lastBuildDate) VALUES (?, ?, ?, ?, ?, ?);", [GlobalTool md5String:feedInfo.url.absoluteString], feedInfo.title.length > 0 ? feedInfo.title : @"", feedInfo.link.length > 0 ? feedInfo.link : @"", feedInfo.url.absoluteString.length > 0 ? feedInfo.url.absoluteString : @"", feedInfo.summary.length > 0 ? feedInfo.summary : @"", feedInfo.lastBuildDate ? @((NSInteger)[feedInfo.lastBuildDate timeIntervalSince1970]) : nil];
    if (result) {
        NSLog(@"cached successfully");
    } else {
        NSLog(@"failed to cache");
    }
}

#pragma mark channel_item_tb operation

- (NSMutableArray *)getChannelItemsUnderFeedUrl:(NSString *)feedUrl {
    [self.database open];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet* selectResult = [self.database executeQuery:@"SELECT * FROM channel_item_tb WHERE urlMd5Value = ? ORDER BY createTime;", [GlobalTool md5String:feedUrl]];
    while ([selectResult next]) {
        ChannelItem *data = [[ChannelItem alloc] init];
        data.urlMd5Value = [selectResult stringForColumn:@"urlMd5Value"];
        data.isRead = [[selectResult stringForColumn:@"isRead"] intValue];
        data.title = [selectResult stringForColumn:@"title"];
        data.link = [selectResult stringForColumn:@"link"];
        data.summary = [selectResult stringForColumn:@"summary"];
        data.coverUrl = [selectResult stringForColumn:@"coverUrl"];
        data.isCollected = [[selectResult stringForColumn:@"isCollected"] intValue];
        data.createTime = [[selectResult stringForColumn:@"createTime"] integerValue];
        data.date = [selectResult dateForColumn:@"date"];
        data.updated = [selectResult dateForColumn:@"updated"];
        data.author = [selectResult stringForColumn:@"author"];
        data.content = [selectResult stringForColumn:@"content"];
        NSData *dataOfEnclosures = [selectResult dataForColumn:@"enclosures"];
        if (dataOfEnclosures) {
            data.enclosures = [NSKeyedUnarchiver unarchiveObjectWithData:dataOfEnclosures];
        }
        
        [result addObject:data];
    }
    
    return result;
}

- (void)updateCoverUrl:(nullable NSString *)coverUrl identifierMd5Value:(NSString *)identifierMd5Value {
    if (coverUrl.length == 0) {
        return;
    }
    
    [self.database open];
    BOOL result = [self.database executeUpdate:@"UPDATE channel_item_tb SET coverUrl = ? WHERE identifierMd5Value = ?;", coverUrl.length > 0 ? coverUrl : @"", identifierMd5Value];
    
    if (result) {
        NSLog(@"updated successfully");
    } else {
        NSLog(@"failed to cache");
    }
}

- (void)saveToChannelItemTableWithData:(MWFeedItem *)feedItem urlMd5Value:(NSString *)urlMd5Value {
    if (feedItem == nil) {
        return;
    }
    
    BOOL result = [self.database executeUpdate:@"INSERT INTO channel_item_tb (identifierMd5Value, urlMd5Value, identifier, title, link, summary, date, updated, author, content, enclosures) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", [GlobalTool md5String:feedItem.identifier], urlMd5Value, feedItem.identifier.length > 0 ? feedItem.identifier : @"", feedItem.title.length > 0 ? feedItem.title : @"", feedItem.link.length > 0 ? feedItem.link : @"", feedItem.summary.length > 0 ? feedItem.summary : @"", @((NSInteger)[feedItem.date timeIntervalSince1970]), feedItem.updated ? @((NSInteger)[feedItem.updated timeIntervalSince1970]) : nil, feedItem.author.length > 0 ? feedItem.author : @"", feedItem.content.length > 0 ? feedItem.content : @"", feedItem.enclosures ? [NSKeyedArchiver archivedDataWithRootObject:feedItem.enclosures] : nil];
    if (result) {
        NSLog(@"cached successfully");
    } else {
        NSLog(@"failed to cache");
    }
}

#pragma mark init operation

- (void)initDatabase {
    if (self.database) {
        return;
    }
    
    NSString* documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"the document dir of sqlite: %@", documentDir);
    self.database = [[FMDatabase alloc] initWithPath:[NSString stringWithFormat:@"%@/renaissance.db", documentDir]];
    
    if (self.database) {
        [self initChannelTable];
        [self initChannelItemTable];
    }
}

- (void)initChannelItemTable {
    if ([self.database open]) {
        BOOL result = [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS channel_item_tb (id INTEGER PRIMARY KEY AutoIncrement, identifierMd5Value varchar UNIQUE, urlMd5Value varchar DEFAULT '', identifier varchar DEFAULT '', title varchar DEFAULT '', link varchar DEFAULT '', coverUrl varchar DEFAULT '', summary varchar DEFAULT '', date integer, updated integer, author varchar DEFAULT '', content text DEFAULT '', enclosures blob, cacheData blob, isRead SMALLINT DEFAULT 0, isCollected SMALLINT DEFAULT 0, createTime TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')));"];
        if (result) {
            NSLog(@"create channel_item_tb successfully");
        }
        else
        {
            NSLog(@"falied to create channel_item_tb");
        }
        
        //    [self.database close];
    } else {
        NSLog(@"failed to open database");
    }
}

- (void)initChannelTable {
    if ([self.database open]) {
        BOOL result = [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS channel_tb (id INTEGER PRIMARY KEY AutoIncrement, urlMd5Value varchar UNIQUE, url varchar DEFAULT '', title varchar DEFAULT '', link varchar DEFAULT '', logoUrl varchar DEFAULT '', favoiconUrl varchar DEFAULT '', summary varchar DEFAULT '', lastBuildDate integer, cacheData blob, isDeleted SMALLINT DEFAULT 0, isCollected SMALLINT DEFAULT 0,  createTime TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')));"];
        if (result) {
            NSLog(@"create channel_tb successfully");
        }
        else
        {
            NSLog(@"falied to create channel_tb");
        }
        
        //    [self.database close];
    } else {
        NSLog(@"failed to open database");
    }
}

@end
