//
//  XHObject.m
//  ReflectDemo
//
//  Created by wangxiaohu on 13-12-9.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

#import "XHObject.h"
#import <objc/runtime.h>

@implementation XHObject


-(id)init{
    id myself=[super init];
    if (myself) {
    }
    return  myself;
}

+(NSString *)changeDicToJson:(NSDictionary *)dic{
    
    NSData *nsData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
    return  json;
}

+(NSString *)changeNSObjectToJson:(NSObject *)object{
    
    NSMutableDictionary *dic=[XHObject changeNSObjectToDictionary:object];
    NSData *nsData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
    
    return json;
}


+(NSString *)returnHH:(NSString *)json{
    
    
    NSString *lTmp = [NSString stringWithFormat:@"%c",'\n'];
    json = [json stringByReplacingOccurrencesOfString:lTmp withString:@""];
    
    return json;
}

+(NSMutableDictionary *)changeNSObjectToDictionary:(NSObject *)object{
    
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
    
    unsigned int propertyCount;
    objc_property_t *propertys=class_copyPropertyList([object class], &propertyCount);
    if (propertyCount>0) {
        for (int i=0; i<propertyCount; i++) {
            objc_property_t property=propertys[i];
            NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            id propertyValue=[object valueForKey:propertyName];
            
            if (propertyValue==nil) {
                continue;
            }
            if ([propertyValue isKindOfClass:[NSArray class]]) {
                NSMutableArray *arrayDictionary=[[NSMutableArray alloc] init];
                for (id childVO in propertyValue) {
                    NSMutableDictionary *dictionary=[self changeNSObjectToDictionary:childVO];
                    [arrayDictionary addObject:dictionary];
                    continue;
                }
                [dictionary setObject:arrayDictionary forKey:propertyName];
                continue;
            }else if([propertyValue isKindOfClass:[XHObject class]]){
                [dictionary setObject:[self changeNSObjectToDictionary:propertyValue] forKey:propertyName];
                continue;
            }else if([propertyValue isKindOfClass:[NSDate class]]){
                NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                NSString *dateString = [formatter stringFromDate:propertyValue];
                [dictionary setObject:dateString forKey:propertyName];
                continue;
            }
            [dictionary setObject:propertyValue forKey:propertyName];
        }
        
    }else{
        dictionary=(NSMutableDictionary *)object;
    }
    
    return  dictionary;
}

+(id)changeJsonToNSObject:(NSString *)json withClass:(Class)className{
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingMutableLeaves error:nil];
    
    return [XHObject changeJsonToNSObjectWithDic:data withClass:className];
}

+(id)changeJsonToNSObjectWithDic:(NSDictionary *)dic withClass:(Class)className{
    
    id obj=[[className alloc] init];
    
    unsigned int propertyCount;
    objc_property_t *propertys=class_copyPropertyList([obj class], &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property=propertys[i];
        NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        unsigned int outCount;
        objc_property_attribute_t *attributeList= property_copyAttributeList(property, &outCount);
        NSString *propertyType=[[[NSString alloc] initWithCString:attributeList[0].value encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"@" withString:@""];
        if (![propertyType isEqualToString:@"i"]&&![propertyType isEqualToString:@"f"]&&![propertyType isEqualToString:@"d"]) {
            propertyType=[propertyType substringWithRange:NSMakeRange(1,propertyType.length-2)];
        }
        id propertyValue=[dic objectForKey:propertyName];

        if([propertyType isEqualToString:@"MyNSMutableArray"]||[propertyType isEqualToString:@"NSMutableArray"]||[propertyType isEqualToString:@"NSArray"]){
            NSMutableArray *array=[[NSMutableArray alloc] init];
            NSString *className=[[propertyName substringWithRange:NSMakeRange(0, propertyName.length)] capitalizedString];
            for (id child in propertyValue) {
                id objx=[self changeJsonToNSObjectWithDic:child withClass:NSClassFromString(className)];
                [array addObject:objx];
            }
            [obj setValue:array forKey:propertyName];
        }else if([propertyType isEqualToString:@"NSMutableDictionary"]||[propertyType isEqualToString:@"NSDictionary"]){
            [obj setValue:propertyValue forKey:propertyName];
        }else if([[[NSClassFromString(propertyType) alloc]init] isKindOfClass:[XHObject class]]){
            Class myClass1=NSClassFromString(propertyType);
            id myObjc=[self changeJsonToNSObjectWithDic:propertyValue withClass:myClass1];
            [obj setValue:myObjc forKey:propertyName];
        }else{
            @try {
                if ([propertyValue isKindOfClass:[NSNull class]]) {
                    [obj setValue:@"" forKey:propertyName];
                }else{
                    [obj setValue:propertyValue forKey:propertyName];
                }
            }
            @catch (NSException *exception) {
                NSLog(@"exception=%@",exception);
            }
            @finally {
                
            }
        }
        
    }
    return obj;
}

@end
