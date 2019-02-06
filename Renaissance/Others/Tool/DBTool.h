//
//  DBTool.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MWFeedInfo;

NS_ASSUME_NONNULL_BEGIN

@interface DBTool : NSObject

+ (instancetype)sharedInstance;

- (void)saveToChannelTableWithData:(MWFeedInfo *)feedInfo;
- (void)updateLogoUrl:(NSString *)logoUrl ofChannelUrl:(NSString *)channelUrl title:(NSString *)title;
- (void)updateLogoUrl:(nullable NSString *)logoUrl favoiconUrl:(nullable NSString *)favoiconUrl ofChannelUrl:(NSString *)channelUrl title:(NSString *)title;
- (NSMutableArray *)getAllAvailableChannels;

@end

NS_ASSUME_NONNULL_END
