//
//  UIImage+JPExtension.m
//  Infinitee2.0
//
//  Created by guanning on 2017/1/25.
//  Copyright © 2017年 Infinitee. All rights reserved.
//

#import "UIImage+JPExtension.h"

@implementation UIImage (JPExtension)

#pragma makr - ui

/** UI缩略（按比例缩略） */
- (UIImage *)jp_uiResizeImageWithScale:(CGFloat)scale {
    return [self jp_uiResizeImageWithLogicWidth:(self.size.width * scale)];
}

/** UI缩略（按逻辑宽度缩略） */
- (UIImage *)jp_uiResizeImageWithLogicWidth:(CGFloat)logicWidth {
    if (logicWidth >= self.size.width) return self;
    CGFloat w = logicWidth;
    CGFloat h = w * self.jp_hwRatio;
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, self.scale);
        [self drawInRect:CGRectMake(0, 0, w, h)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resizedImage;
    }
}

/** UI缩略（按像素宽度缩略） */
- (UIImage *)jp_uiResizeImageWithPixelWidth:(CGFloat)pixelWidth {
    return [self jp_uiResizeImageWithLogicWidth:(pixelWidth / self.scale)];
}

#pragma makr - cg

/** CG缩略（按比例缩略） */
- (UIImage *)jp_cgResizeImageWithScale:(CGFloat)scale {
    return [self jp_cgResizeImageWithLogicWidth:(self.size.width * scale)];
}

/** CG缩略（按逻辑宽度缩略） */
- (UIImage *)jp_cgResizeImageWithLogicWidth:(CGFloat)logicWidth {
    return [self jp_cgResizeImageWithPixelWidth:(logicWidth * self.scale)];
}

/** CG缩略（按像素宽度缩略） */
- (UIImage *)jp_cgResizeImageWithPixelWidth:(CGFloat)pixelWidth {
    if (pixelWidth >= (self.size.width * self.scale)) return self;
    CGFloat pixelHeight = pixelWidth * self.jp_hwRatio;
    
    CGImageRef cgImage = self.CGImage;
    if (!cgImage) return nil;
    size_t bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(cgImage);
    
    CGContextRef context = CGBitmapContextCreate(nil, (size_t)pixelWidth, (size_t)pixelHeight, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextDrawImage(context, CGRectMake(0, 0, pixelWidth, pixelHeight), cgImage);
    CGImageRef resizedCGImage = CGBitmapContextCreateImage(context);
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:self.scale orientation:self.imageOrientation];
    
    CGContextRelease(context);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

#pragma makr - io

/** IO缩略（按比例缩略） */
- (UIImage *)jp_ioResizeImageWithScale:(CGFloat)scale isPNGType:(BOOL)isPNGType {
    return [self jp_ioResizeImageWithLogicWidth:(self.size.width * scale) isPNGType:isPNGType];
}

/** IO缩略（按逻辑宽度缩略） */
- (UIImage *)jp_ioResizeImageWithLogicWidth:(CGFloat)logicWidth isPNGType:(BOOL)isPNGType {
    return [self jp_ioResizeImageWithPixelWidth:(logicWidth * self.scale) isPNGType:isPNGType];
}

/** IO缩略（按像素宽度缩略） */
- (UIImage *)jp_ioResizeImageWithPixelWidth:(CGFloat)pixelWidth isPNGType:(BOOL)isPNGType {
    if (pixelWidth >= (self.size.width * self.scale)) return self;
    
    NSData *data = isPNGType ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1);
    if (!data) return nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    CGFloat maxPixelValue = (self.jp_hwRatio > 1.0) ? (pixelWidth * self.jp_hwRatio) : pixelWidth;
    // 因为kCGImageSourceCreateThumbnailFromImageAlways会一直创建缩略图，造成内存浪费
    // 所以使用kCGImageSourceCreateThumbnailFromImageIfAbsent
    NSDictionary *options = @{(id)kCGImageSourceCreateThumbnailWithTransform : @(YES),
                              (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                              (id)kCGImageSourceThumbnailMaxPixelSize : @(maxPixelValue)};
    
    CGImageRef resizedCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (CFDictionaryRef)options);
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:self.scale orientation:self.imageOrientation];
    
    CFRelease(imageSource);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

#pragma makr - other

- (CGFloat)jp_whRatio {
    return (self.size.width / self.size.height);
}

- (CGFloat)jp_hwRatio {
    return (self.size.height / self.size.width);
}

- (BOOL)jp_writeToFile:(NSString *)path isPNGType:(BOOL)isPNGType {
    NSData *data = isPNGType ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1);
    if (data) {
        return [data writeToURL:[NSURL fileURLWithPath:path] atomically:YES];
    }
    return NO;
}

@end
