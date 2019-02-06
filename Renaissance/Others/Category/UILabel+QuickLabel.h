//
//  UILabel+QuickLabel.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (QuickLabel)

//+ (instancetype)quickLabelWithParentView:(nullable UIView *)parentView; 

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr parentView:(nullable UIView *)parentView;
+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor parentView:(UIView *)parentView;
+ (instancetype)quickLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor parentView:(UIView *)parentView;

@end

NS_ASSUME_NONNULL_END
