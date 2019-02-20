//
//  Channel.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MWFeedParser.h>
#import <MWFeedInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface Channel : MWFeedInfo

@property (nonatomic, copy) NSString *urlMd5Value;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *favoiconUrl;
@property (nonatomic) int isDeleted;
@property (nonatomic) int isCollected;
@property (nonatomic) NSInteger updateTime;
@property (nonatomic) NSInteger createTime;

@end

NS_ASSUME_NONNULL_END
