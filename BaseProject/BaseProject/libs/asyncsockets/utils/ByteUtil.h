//
//  ByteUtil.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByteUtil : NSObject



+(NSData *)intToByte:(int)param;
+(int)bytesToInt:(NSData *)parame;

+(NSData *)nsStringToNSData:(NSString *)msg;
+(NSString *)nsDataToNSString:(NSData *)data;


@end
