//
//  UILabel+QuickLabel.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "UILabel+QuickLabel.h"

@implementation UILabel (QuickLabel)

//+ (instancetype)quickLabelWithParentView:(nullable UIView *)parentView {
//    return [self quickLabelWithFontSize:15 textColor:HexColor(@"3d3d3d") parentView:parentView];
//}

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr parentView:(nullable UIView *)parentView {
    return [self quickLabelWithFont:[UIFont systemFontOfSize:fontSize] textColor:[UIColor colorWithHexString:textColorHexStr] parentView:parentView];
}

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView {
    return [self quickLabelWithFont:[UIFont systemFontOfSize:fontSize] textColor:textColor parentView:parentView];
}

+ (instancetype)quickLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView {
    UILabel *label = [[self alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    [parentView addSubview:label];
    
    return label;
}

@end
