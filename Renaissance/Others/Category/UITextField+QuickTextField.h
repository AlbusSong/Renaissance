//
//  UITextField+QuickTextField.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextField (QuickTextField)

+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr;
+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor placeholder:(NSString *)placeholder;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment placeholder:(nullable NSString *)placeholder placeholderFont:(UIFont *)placeholderFont placeholderColor:(UIColor *)placeholderColor;

@end

NS_ASSUME_NONNULL_END
