//
//  ChannelItem.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWFeedItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelItem : MWFeedItem

@property (nonatomic, copy) NSString *identifierMd5Value;

@property (nonatomic, copy) NSString *urlMd5Value;

@property (nonatomic, copy) NSString *coverUrl;

@property (nonatomic) int isRead;

@property (nonatomic) int isCollected;

@property (nonatomic) NSInteger createTime;

@end

NS_ASSUME_NONNULL_END
