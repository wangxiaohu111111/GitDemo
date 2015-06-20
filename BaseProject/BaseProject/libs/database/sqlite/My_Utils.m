//
//  Utils.m
//  FlipView
//
//  Created by wangxiaohu on 13-8-31.
//
//

#import "My_Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation My_Utils

+(char *)stringToChar:(NSString *)msg{
    const char *ptr = [msg UTF8String];
    return (char *)ptr;
}
+(NSString *)charToNSString:(char*) charx{
    if (charx==NULL) {
        return @"";
    }
    NSString *encrypted = [[NSString alloc] initWithCString:(const char*)charx encoding:NSUTF8StringEncoding];
    return encrypted;
}

@end
