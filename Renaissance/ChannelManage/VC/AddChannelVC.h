//
//  AddChannelVC.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASTableViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddChannelVC : ASTableViewVC

@property (nonatomic, copy) void (^completionHandler) (BOOL success);

@end

NS_ASSUME_NONNULL_END
