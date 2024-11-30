#import "CoreWrapper.h"
#include "include/core/SkCanvas.h"
#include "include/core/SkPaint.h"
#include "include/core/SkSurface.h"
#include "include/core/SkRect.h"
#include "include/core/SkImage.h"
#include "include/core/SkData.h"
#include "include/core/SkStream.h"
#include "include/core/SkBitmap.h"
#include "include/encode/SkEncoder.h"
#include "include/encode/SkPngEncoder.h"
#include "include/core/SkStream.h"
#import <UIKit/UIKit.h>

@implementation CoreWrapper

+ (NSString*) concatenateMyStringWithCppString:(NSString*)myString {
    const char *utfString = [myString UTF8String];
    const char *textFromCppCore = concatenateMyStringWithCppStringC(utfString);
    NSString *objcString = [NSString stringWithUTF8String:textFromCppCore];
    
    SkPaint paint;
    paint.setColor(SK_ColorRED);
    paint.setStyle(SkPaint::kFill_Style);
    paint.setAntiAlias(true);      // 启用抗锯齿

    SkImageInfo info = SkImageInfo::MakeN32Premul(100, 100);
    sk_sp<SkSurface> surface = SkSurfaces::Raster(info);

    
    if (!surface) {
        std::cout << "Failed to create Skia surface." << std::endl;
        
        
        
        SkBitmap bitmap;
        bitmap.allocN32Pixels(800, 600);  // 800x600 image

        // Create a SkCanvas backed by the bitmap
        SkCanvas canvas(bitmap);
        
        SkPaint paint;
        paint.setColor(SK_ColorRED);
        paint.setAntiAlias(true);

        // Draw a rectangle to the bitmap
        canvas.drawRect(SkRect::MakeLTRB(100, 100, 500, 500), paint);
  
        
        uint32_t *a0 = bitmap.getAddr32(2, 3);
        uint32_t *a1 = bitmap.getAddr32(2, 4);
        uint32_t *a200 = bitmap.getAddr32(200, 200);
        uint32_t *a499 = bitmap.getAddr32(499, 499);
        uint32_t *a500 = bitmap.getAddr32(500, 500);
        uint32_t *a501 = bitmap.getAddr32(501, 501);
//        SkPixmap src;
//        bool success = bitmap.peekPixels(&src);
////        SkWStream stream;  // Create a memory stream to hold encoded data
//        SkDynamicMemoryWStream dst0;
//        SkPngEncoder::Encode(&dst0, src, SkPngEncoder::Options());
//        
//        sk_sp<SkData> data0 = dst0.detachAsData();
//        
//        data
        // Using stringWithFormat: to combine string and uint32_t
        NSString *combinedString = [NSString stringWithFormat:@"%u|%u|%u|%u|%u|%u", *a0, *a1, *a200, *a499, *a500, *a501];

        return combinedString;
    }
    // 获取画布
    SkCanvas* canvas = surface->getCanvas();

    // 清空画布
    canvas->clear(SK_ColorWHITE);
    
    
    // 创建绘图工具


    // 绘制矩形
    SkRect rect = SkRect::MakeXYWH(100, 100, 300, 200);
    canvas->drawRect(rect, paint);
    
    sk_sp<SkImage> image = surface->makeImageSnapshot();
    sk_sp<SkData> pngData = image->refEncodedData();

    return objcString;
}

+ (UIImage*) skBitmapToUIImage {
    SkBitmap bitmap;
    bitmap.allocN32Pixels(800, 600);  // 800x600 image
    size_t width = bitmap.width();
    size_t height = bitmap.height();
    
    // Create a SkCanvas backed by the bitmap
    SkCanvas canvas(bitmap);
    
    SkPaint paint;
    paint.setColor(SK_ColorRED);
    paint.setAntiAlias(true);

    // Draw a rectangle to the bitmap
    canvas.drawRect(SkRect::MakeLTRB(100, 100, 500, 500), paint);
    
    paint.setColor(SK_ColorYELLOW);
    canvas.drawRect(SkRect::MakeLTRB(120, 120, 150, 150), paint);
    
    size_t bytesPerRow = bitmap.rowBytes();

    // Create a CGDataProvider from SkBitmap pixel data
    CFDataRef data = CFDataCreate(NULL, (const UInt8*)bitmap.getPixels(), height * bytesPerRow);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast;  // Assuming RGBA format
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, colorSpace, bitmapInfo, provider, NULL, NO, kCGRenderingIntentDefault);


    // Convert CGImage to UIImage
    UIImage *image = [UIImage imageWithCGImage:cgImage];

    // Clean up
    CFRelease(data);
    CGImageRelease(cgImage);

    return image;
}

@end
