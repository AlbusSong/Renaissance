//
//  UIView+ActivityIndicatorView.m
//  Renaissance
//
//  Created by Albus on 2019/2/16.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "UIView+ActivityIndicatorView.h"

static char activityView;

@implementation UIView (ActivityIndicatorView)

- (UIActivityIndicatorView *)viewOfActivity {
    return objc_getAssociatedObject(self, &activityView);
}

- (void)setViewOfActivity:(UIActivityIndicatorView *)viewOfActivity {
    objc_setAssociatedObject(self, &activityView, viewOfActivity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showIndicatorViewWithItsStyle:(UIActivityIndicatorViewStyle)style {
    [self startActivityViewWithItsStyle:style];
    [self.viewOfActivity startAnimating];
}

- (void)showIndicatorView {
    [self showIndicatorViewWithItsStyle:UIActivityIndicatorViewStyleGray];
}

- (void)hideIndicatorView {
    [self.viewOfActivity stopAnimating];
    [self.viewOfActivity removeFromSuperview];
    self.viewOfActivity = nil;
}

- (void)startActivityViewWithItsStyle:(UIActivityIndicatorViewStyle)style {
    self.viewOfActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [self.viewOfActivity hidesWhenStopped];
    [self addSubview:self.viewOfActivity];
    self.viewOfActivity.sd_layout.centerXEqualToView(self).centerYEqualToView(self);
}

- (void)startActivityView {
    [self startActivityViewWithItsStyle:UIActivityIndicatorViewStyleGray];
}

@end
