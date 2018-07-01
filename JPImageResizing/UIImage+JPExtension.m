//
//  UIImage+JPExtension.m
//  Infinitee2.0
//
//  Created by guanning on 2017/1/25.
//  Copyright © 2017年 Infinitee. All rights reserved.
//

#import "UIImage+JPExtension.h"

@implementation UIImage (JPExtension)

- (UIImage *)jp_uiResizeImageWithSize:(CGSize)size {
    return [self jp_uiResizeImageWithSize:size scale:0];
}

- (UIImage *)jp_cgResizeImageWithSize:(CGSize)size {
    return [self jp_cgResizeImageWithSize:size scale:0];
}

- (UIImage *)jp_ioResizeImageWithSize:(CGSize)size {
    return [self jp_ioResizeImageWithSize:size scale:0];
}

- (UIImage *)jp_uiResizeImageWithSize:(CGSize)size scale:(CGFloat)scale {
    @autoreleasepool {
        if (scale <= 0) scale = [UIScreen mainScreen].scale;
        
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return resizedImage;
    }
}

- (UIImage *)jp_cgResizeImageWithSize:(CGSize)size scale:(CGFloat)scale {
    CGImageRef cgImage = self.CGImage;
    if (!cgImage) return nil;
    
    if (scale <= 0) scale = [UIScreen mainScreen].scale;
    size.width *= scale;
    size.height *= scale;
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(cgImage);
    
    CGContextRef context = CGBitmapContextCreate(nil, (size_t)size.width, (size_t)size.height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), cgImage);
    
    CGImageRef resizedCGImage = CGBitmapContextCreateImage(context);
    
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:scale orientation:self.imageOrientation];
    
    CGContextRelease(context);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

- (UIImage *)jp_ioResizeImageWithSize:(CGSize)size scale:(CGFloat)scale {
    NSData *data = UIImagePNGRepresentation(self);
    if (!data) return nil;
    
    if (scale <= 0) scale = [UIScreen mainScreen].scale;
    
    CGFloat maxPixelSize = MAX(size.width, size.height) * scale;
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    // 因为kCGImageSourceCreateThumbnailFromImageAlways会一直创建缩略图，有可能会造成内存浪费，所以使用kCGImageSourceCreateThumbnailFromImageIfAbsent
    NSDictionary *options = @{(id)kCGImageSourceCreateThumbnailWithTransform : @(YES),
                              (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                              (id)kCGImageSourceThumbnailMaxPixelSize : @(maxPixelSize)};
    
    CGImageRef resizedCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (CFDictionaryRef)options);
    
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:scale orientation:self.imageOrientation];
    
    CFRelease(imageSource);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

@end
