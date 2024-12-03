#import "CoreWrapper.h"
#include "include/core/SkCanvas.h"
#include "include/core/SkPaint.h"
#include "include/core/SkSurface.h"
#include "include/core/SkRect.h"
#include "include/core/SkImage.h"
#include "include/core/SkData.h"
#include "include/core/SkStream.h"
#include "include/core/SkTypeface.h"
#include "include/core/SkFont.h"
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
    
    
    paint.setColor(SK_ColorBLACK);
    canvas.drawSimpleText("hello你好", 11, SkTextEncoding::kUTF8, 20, 120, SkFont(SkTypeface::MakeFromName("PingFang SC", SkFontStyle()), 32), paint);
    canvas.drawString("🤔🙋🏻‍♀️🍀🤔", 20, 220, SkFont(SkTypeface::MakeFromName("Apple Color Emoji", SkFontStyle()), 32), paint);
    
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
