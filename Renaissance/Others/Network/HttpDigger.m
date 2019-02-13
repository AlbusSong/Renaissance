//
//  HttpDigger.m
//  Renaissance
//
//  Created by Albus on 2019/2/12.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "HttpDigger.h"

static HttpDigger *instance;

@interface HttpDigger ()

@end

@implementation HttpDigger

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

#pragma mark getter

- (AFHTTPSessionManager *)networkMgr {
    if (_networkMgr == nil) {
        AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer* requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setTimeoutInterval:20.0];
        [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        AFHTTPResponseSerializer* responceSerializer = [AFHTTPResponseSerializer serializer];
        responceSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        // ssl
//        AFSecurityPolicy* policy = [self customSecurityPolicy];
//        if(nil != policy)
//        {
//            [mgr setSecurityPolicy:policy];
//        }
        
        [mgr setResponseSerializer:responceSerializer];
        
        [mgr setRequestSerializer:requestSerializer];
        
        _networkMgr = mgr;
    }
    return _networkMgr;
}

@end
