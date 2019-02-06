//
//  UITextField+QuickTextField.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "UITextField+QuickTextField.h"

@implementation UITextField (QuickTextField)

+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr {
    return [self quickTextFieldWithFont:[UIFont systemFontOfSize:fontSize] textColorHexStr:textColorHexStr];
}

+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr {
    return [self quickTextFieldWithFont:[UIFont systemFontOfSize:fontSize] textColorHexStr:textColorHexStr placeholderColorHexStr:placeholderColorHexStr];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr {
    return [self quickTextFieldWithFont:font textColor:HexColor(textColorHexStr) placeholderColor:HexColor(placeholderColorHexStr)];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr {
    return [self quickTextFieldWithFont:font textColor:HexColor(textColorHexStr)];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor {
    return [self quickTextFieldWithFont:font textColor:textColor alignment:NSTextAlignmentLeft placeholder:nil placeholderFont:font placeholderColor:placeholderColor];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [self quickTextFieldWithFont:font textColor:textColor alignment:NSTextAlignmentLeft];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor placeholder:(NSString *)placeholder {
    UITextField *tfd = [self quickTextFieldWithFont:font textColor:textColor placeholderColor:placeholderColor];
    tfd.placeholder = placeholder;
    return tfd;
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder {
    UITextField *tfd = [self quickTextFieldWithFont:font textColor:textColor alignment:NSTextAlignmentLeft];
    tfd.placeholder = placeholder;
    return tfd;
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment {
    return [self quickTextFieldWithFont:font textColor:textColor alignment:alignment placeholder:nil placeholderFont:font placeholderColor:textColor];
}

+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment placeholder:(nullable NSString *)placeholder placeholderFont:(UIFont *)placeholderFont placeholderColor:(UIColor *)placeholderColor {
    UITextField *tfd = [[self alloc] init];
    tfd.keyboardType = UIKeyboardTypeDefault;
    tfd.font = font;
    tfd.textColor = textColor;
    tfd.textAlignment = alignment;
    [tfd setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [tfd setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    if (placeholder.length > 0) {
        tfd.placeholder = placeholder;
    }
    
    return tfd;
}

@end
