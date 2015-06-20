//
//  PlistDataUtils.m
//  DDYHProject
//
//  Created by wangxiaohu on 13-11-14.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

/**
 
 
 NSMutableDictionary * allDic=[[NSMutableDictionary alloc] init];
 
 NSMutableDictionary * dic=[[NSMutableDictionary alloc] init];
 [dic setObject:@"王小虎1" forKey:@"username"];
 [dic setObject:@"1234561" forKey:@"password"];
 [dic setObject:@"IOS工程师1" forKey:@"job"];
 
 [allDic setObject:dic forKey:@"userInfo"];
 [PlistDataUtils setKeyWithValue:allDic];
 
 
 NSDictionary * userInfos=  [[PlistDataUtils getAllNSDictionary] objectForKey:@"userInfo"];
 if (userInfos!=nil) {
 NSString *username= [userInfos objectForKey:@"username"];
 NSString *password=[userInfos objectForKey:@"password"];
 NSString *job=[userInfos objectForKey:@"job"];
 NSLog(@"username=%@,password=%@,job=%@",username,password,job);
 }
 BaseDatabaseHelper *dbh=[[BaseDatabaseHelper alloc] init];
 BOOL ex=[dbh dataBaseFileIsExit];
 NSLog(@"ex=%d",ex);
 
 BOOL ex1=[dbh dataBaseFileIsExit];
 NSLog(@"ex1=%d",ex1);


 
 **/

#define filePath @"plist_data.plist"

#import "PlistDataUtils.h"

@implementation PlistDataUtils

+(NSString *)getPlistPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:filePath];
    return plistPath;
}

+(void)setKeyWithValue:(NSDictionary *)value{
    NSString *plistPath = [PlistDataUtils getPlistPath];
    [value writeToFile:plistPath atomically:YES];
}

+(NSDictionary *)getAllNSDictionary{
    NSString *plistPath = [PlistDataUtils getPlistPath];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return dic2;
}

+(NSDictionary *)getDictionaryWithKey:(NSString *)key{
    NSString *plistPath = [PlistDataUtils getPlistPath];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [dic2 objectForKey:key];
}

/** Delete a file **/
+(BOOL)deleteSingleFile{
    NSError *err = nil;
    NSString * plistPath=[PlistDataUtils getPlistPath];
    if (nil == plistPath) {
        return NO;
    }
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    
    if (![appFileManager fileExistsAtPath:plistPath]) {
        return YES;
    }
    if (![appFileManager isDeletableFileAtPath:plistPath]) {
        return NO;
    }
    return [appFileManager removeItemAtPath:plistPath error:&err];
}

@end

