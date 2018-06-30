//
//  UIImage+JPExtension.h
//  Infinitee2.0
//
//  Created by guanning on 2017/1/25.
//  Copyright © 2017年 Infinitee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JPExtension)

// 参考：https://github.com/woshiccm/ImageResizing（五种压缩图片技术）
// 参考：https://www.jianshu.com/p/ba45f5539e4e（imageIO压缩图片）
- (UIImage *)jp_uiResizeImageWithSize:(CGSize)size;
- (UIImage *)jp_cgResizeImageWithSize:(CGSize)size;
- (UIImage *)jp_ioResizeImageWithSize:(CGSize)size;
- (UIImage *)jp_uiResizeImageWithSize:(CGSize)size scale:(CGFloat)scale;
- (UIImage *)jp_cgResizeImageWithSize:(CGSize)size scale:(CGFloat)scale;
- (UIImage *)jp_ioResizeImageWithSize:(CGSize)size scale:(CGFloat)scale;

@end
