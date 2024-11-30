#import "CoreWrapper.h"

@implementation CoreWrapper

+ (NSString*) concatenateMyStringWithCppString:(NSString*)myString {
    const char *utfString = [myString UTF8String];
    const char *textFromCppCore = concatenateMyStringWithCppStringC(utfString);
    NSString *objcString = [NSString stringWithUTF8String:textFromCppCore];
    return objcString;
}

@end
