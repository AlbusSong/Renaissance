//
//  Channel.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Channel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *favoiconUrl;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *lastBuildDate;
@property (nonatomic) int isDeleted;
@property (nonatomic) int isCollected;
@property (nonatomic) NSInteger createTime;

@end

NS_ASSUME_NONNULL_END
