//
//  UIView+Candy.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "UIView+Candy.h"

@implementation UIView (Candy)

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end
