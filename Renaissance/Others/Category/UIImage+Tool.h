//
//  UIImage+Tool.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tool)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect isHorizontalDirection:(BOOL)isHorizontal;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
+ (UIImage *)getThumbnailImage:(NSString *)videoURL;
+ (UIImage *)getVideoThumbnailWithUrl:(NSURL*)videoUrl  second:(CGFloat)second;
+ (UIImage *)getNewImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
