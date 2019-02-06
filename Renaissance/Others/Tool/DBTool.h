//
//  DBTool.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MWFeedInfo;
@class MWFeedItem;

NS_ASSUME_NONNULL_BEGIN

@interface DBTool : NSObject

+ (instancetype)sharedInstance;

- (void)saveToChannelTableWithData:(MWFeedInfo *)feedInfo;
- (void)updateLogoUrl:(NSString *)logoUrl ofChannelUrl:(NSString *)channelUrl;
- (void)updateLogoUrl:(nullable NSString *)logoUrl favoiconUrl:(nullable NSString *)favoiconUrl ofChannelUrl:(NSString *)channelUrl;
- (NSMutableArray *)getAllAvailableChannels;

- (void)saveToChannelItemTableWithData:(MWFeedItem *)feedItem urlMd5Value:(NSString *)urlMd5Value;
- (void)updateCoverUrl:(nullable NSString *)coverUrl identifierMd5Value:(NSString *)identifierMd5Value;
- (NSMutableArray *)getChannelItemsUnderFeedUrl:(NSString *)feedUrl;

@end

NS_ASSUME_NONNULL_END
