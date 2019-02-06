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

- (NSMutableArray *)getAllAvailableChannels {
    [self.database open];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet* selectResult = [self.database executeQuery:@"SELECT * FROM channel_tb WHERE isDeleted = 0 ORDER BY createTime;"];
    while ([selectResult next]) {
        Channel *data = [[Channel alloc] init];
        data.title = [selectResult stringForColumn:@"title"];
        data.link = [selectResult stringForColumn:@"link"];
        data.url = [selectResult stringForColumn:@"url"];
        data.summary = [selectResult stringForColumn:@"summary"];
        data.logoUrl = [selectResult stringForColumn:@"logoUrl"];
        data.favoiconUrl = [selectResult stringForColumn:@"favoiconUrl"];
        
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
    
    BOOL result = [self.database executeUpdate:@"INSERT INTO channel_tb (urlMd5Value, title, link, url, summary, lastBuildDate) VALUES (?, ?, ?, ?, ?, ?);", [GlobalTool md5String:feedInfo.url.absoluteString] ,feedInfo.title.length > 0 ? feedInfo.title : @"", feedInfo.link.length > 0 ? feedInfo.link : @"", feedInfo.url.absoluteString.length > 0 ? feedInfo.url.absoluteString : @"", feedInfo.summary.length > 0 ? feedInfo.summary : @"", feedInfo.lastBuildDate.length > 0 ? feedInfo.lastBuildDate : @""];
    if (result) {
        NSLog(@"cached successfully");
    } else {
        NSLog(@"failed to cache");
    }
}

- (void)initDatabase {
    if (self.database) {
        return;
    }
    
    NSString* documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"the document dir of sqlite: %@", documentDir);
    self.database = [[FMDatabase alloc] initWithPath:[NSString stringWithFormat:@"%@/renaissance.db", documentDir]];
    
    if (self.database) {
        [self initChannelTable];
    }
}

- (void)initChannelTable {
    if ([self.database open]) {
        BOOL result = [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS channel_tb (id INTEGER PRIMARY KEY AutoIncrement, urlMd5Value varchar UNIQUE, url varchar DEFAULT '', title varchar DEFAULT '', link varchar DEFAULT '', logoUrl varchar DEFAULT '', favoiconUrl varchar DEFAULT '', summary varchar DEFAULT '', lastBuildDate varchar DEFAULT '', cacheData blob, isDeleted SMALLINT DEFAULT 0, isCollected SMALLINT DEFAULT 0,  createTime TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')));"];
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
