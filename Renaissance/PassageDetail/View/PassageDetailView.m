//
//  PassageDetailView.m
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailView.h"

@interface PassageDetailView ()

@property (nonatomic, strong) ChannelItem *data;

@end

@implementation PassageDetailView

- (instancetype)initWithChannelItemData:(ChannelItem *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
}

@end
