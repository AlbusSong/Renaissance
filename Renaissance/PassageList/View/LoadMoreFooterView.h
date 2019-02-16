//
//  LoadMoreFooterView.h
//  Renaissance
//
//  Created by Albus on 2019/2/15.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoadMoreFooterViewDelegate <NSObject>

- (void)tryToLoadMore;

@end

@interface LoadMoreFooterView : UIView

@property (nonatomic, weak) id <LoadMoreFooterViewDelegate> delegate;

- (void)setNeedToLoadMoreInfo:(NSString *)info;
- (void)setNeedToLoadMoreInfo:(NSString *)info textColor:(UIColor *)color;
- (void)setNoMoreInfo:(NSString *)info;
- (void)setNoMoreInfo:(NSString *)info textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
