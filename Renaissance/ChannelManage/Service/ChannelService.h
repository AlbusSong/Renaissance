//
//  ChannelService.h
//  Renaissance
//
//  Created by Albus on 2019/2/11.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ChannelParsingState) {
    ChannelParsingStateStarted = 0,
    ChannelParsingStateOnTheWay,
    ChannelParsingStatePartialSuccess,
    ChannelParsingStateTotalSuccess,
    ChannelParsingStateFailed,
};

@protocol ChannelServiceDelegate <NSObject>

- (void)parsingChannelWithState:(ChannelParsingState)state;

@end

@interface ChannelService : NSObject

@property (nonatomic, weak) id <ChannelServiceDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)startToParseRSSChannel:(NSString *)channelUrl;

@end

NS_ASSUME_NONNULL_END
