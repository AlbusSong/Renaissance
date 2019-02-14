//
//  NSDate+Quick.m
//  Renaissance
//
//  Created by Albus on 2019/2/14.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "NSDate+Quick.h"

@implementation NSDate (Quick)

- (NSString *)timeStringByFormatter:(NSString *)formatter {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:formatter];
    return [f stringFromDate:self];
}

@end
