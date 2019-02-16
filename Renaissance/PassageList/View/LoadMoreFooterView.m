//
//  LoadMoreFooterView.m
//  Renaissance
//
//  Created by Albus on 2019/2/15.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "LoadMoreFooterView.h"

@implementation LoadMoreFooterView {
    UILabel *txtOfStatus;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClicked:)]];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"303030") parentView:self];
    txtOfStatus.textAlignment = NSTextAlignmentCenter;
    txtOfStatus.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
}

- (void)setNeedToLoadMoreInfo:(NSString *)info {
    [self setNeedToLoadMoreInfo:info textColor:HexColor(@"303030")];
}

- (void)setNeedToLoadMoreInfo:(NSString *)info textColor:(UIColor *)color {
    self.userInteractionEnabled = YES;
    txtOfStatus.hidden = NO;
    txtOfStatus.text = info;
    txtOfStatus.textColor = color;
    [self hideIndicatorView];
}

- (void)setNoMoreInfo:(NSString *)info {
    [self setNoMoreInfo:info textColor:HexColor(@"909090")];
}

- (void)setNoMoreInfo:(NSString *)info textColor:(UIColor *)color {
    self.userInteractionEnabled = NO;
    txtOfStatus.hidden = NO;
    txtOfStatus.text = info;
    txtOfStatus.textColor = color;
    [self hideIndicatorView];
}

#pragma mark gesture

- (void)onClicked:(UITapGestureRecognizer *)sender {
    [self showIndicatorView];
    self.userInteractionEnabled = NO;
    txtOfStatus.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tryToLoadMore)]) {
        [self.delegate tryToLoadMore];
    }
}

@end
