//
//  HudTool.m
//  Renaissance
//
//  Created by Albus on 2019/2/15.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "HudTool.h"

static HudTool *instance;

@interface HudTool ()

@property (nonatomic, strong) SVProgressHUD *theHud;

@end

@implementation HudTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
