//
//  XHObject.h
//  ReflectDemo
//
//  Created by wangxiaohu on 13-12-9.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHObject : NSObject


+(NSString *)changeDicToJson:(NSDictionary *)dic;
+(NSString *)changeNSObjectToJson:(NSObject *)object;
+(id)changeJsonToNSObject:(NSString *)json withClass:(Class)className;

+(NSMutableDictionary *)changeNSObjectToDictionary:(NSObject *)object;

@end
