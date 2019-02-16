//
//  LoadMoreFooterView.m
//  Renaissance
//
//  Created by Albus on 2019/2/15.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "LoadMoreFooterView.h"

@interface LoadMoreFooterView ()

@property (nonatomic) BOOL loading;
@property (nonatomic) CGFloat showDelay;

@end

@implementation LoadMoreFooterView {
    UILabel *txtOfStatus;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClicked:)]];
        self.loading = NO;
        self.showDelay = 0.5;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"303030") parentView:self];
    txtOfStatus.textAlignment = NSTextAlignmentCenter;
    txtOfStatus.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
}

- (void)setNeedToLoadMore {
    [self setNeedToLoadMoreInfo:@"Click to load more"];
}

- (void)setNeedToLoadMoreInfo:(NSString *)info {
    [self setNeedToLoadMoreInfo:info textColor:HexColor(@"303030")];
}

- (void)setNeedToLoadMoreInfo:(NSString *)info textColor:(UIColor *)color {
    self.userInteractionEnabled = YES;
    self.loading = NO;
    txtOfStatus.hidden = NO;
    txtOfStatus.text = info;
    txtOfStatus.textColor = color;
    [self hideIndicatorView];
}

- (void)setNoMore {
    [self setNoMoreInfo:@"No more"];
}

- (void)setNoMoreInfo:(NSString *)info {
    [self setNoMoreInfo:info textColor:HexColor(@"909090")];
}

- (void)setNoMoreInfo:(NSString *)info textColor:(UIColor *)color {
    self.userInteractionEnabled = NO;
    self.loading = NO;
    txtOfStatus.hidden = NO;
    txtOfStatus.text = info;
    txtOfStatus.textColor = color;
    [self hideIndicatorView];
}

#pragma mark gesture

- (void)onClicked:(UITapGestureRecognizer *)sender {
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.showDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.loading) {
            [weakSelf showIndicatorView];
        }
    });
    self.userInteractionEnabled = NO;
    self.loading = YES;
    txtOfStatus.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tryToLoadMore)]) {
        [self.delegate tryToLoadMore];
    }
}

- (void)setActivityIndicatorViewShowDelay:(CGFloat)delay {
    if (delay < 0) {
        return;
    }
    
    self.showDelay = delay;
}

@end
