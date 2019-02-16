//
//  UIView+ActivityIndicatorView.h
//  Renaissance
//
//  Created by Albus on 2019/2/16.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ActivityIndicatorView)

- (void)showIndicatorViewWithItsStyle:(UIActivityIndicatorViewStyle)style;

- (void)showIndicatorView;

- (void)hideIndicatorView;

@end

NS_ASSUME_NONNULL_END
