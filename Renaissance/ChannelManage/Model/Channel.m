//
//  Channel.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.unReadCount = 0;
    }
    return self;
}

- (NSInteger)unReadCount {
    if (_unReadCount < 0) {
        return 0;
    }
    return _unReadCount;
}

@end
