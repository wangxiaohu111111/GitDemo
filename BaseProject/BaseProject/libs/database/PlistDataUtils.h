//
//  PlistDataUtils.h
//  DDYHProject
//
//  Created by wangxiaohu on 13-11-14.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistDataUtils : NSObject

+(void)setKeyWithValue:(NSDictionary *)value;

+(NSDictionary *)getAllNSDictionary;

+(NSDictionary *)getDictionaryWithKey:(NSString *)key;

@end
