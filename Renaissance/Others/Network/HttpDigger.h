//
//  HttpDigger.h
//  Renaissance
//
//  Created by Albus on 2019/2/12.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpDigger : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *networkMgr;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
