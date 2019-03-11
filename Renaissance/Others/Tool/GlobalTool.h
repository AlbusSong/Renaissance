//
//  GlobalTool.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTool : NSObject

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize;
+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeFitsWithSize:(CGSize)size attributeText:(NSAttributedString *)attributeText;

+ (NSString *)timeStringBy:(NSInteger)unixTimeStamp formatter:(NSString *)formatterStr;

+ (NSString *)md5String:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
