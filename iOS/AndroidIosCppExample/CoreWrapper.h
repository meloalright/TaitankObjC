#import <Foundation/Foundation.h>
#import "Core.h"
#import <UIKit/UIKit.h>

@interface CoreWrapper : NSObject

+ (NSString*) concatenateMyStringWithCppString:(NSString*)myString;
+ (UIImage*) skBitmapToUIImage;
@end
