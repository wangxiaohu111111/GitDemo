//
//  DateUtil.h
//  DrawLib
//
//  Created by wangxiaohu on 14-12-3.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSString *)changeNSDataToNSString:(NSString *)dateFormart withDate:(NSDate *) data;


+(NSDate *)changeNSStringToNSData:(NSString *)dateFormart withDate:(NSString *) data;


//2个时间的截止时间段
/**
 *  data 时间的1
 *  datajz 时间段2
 **/
+(double)changeNSStringToLong:(NSString *)dateFormart withDate:(NSString *) data jz:(NSDate *)datajz;

/**
 *  获取距离星期一的秒数
 *
 *  @param nowDate 时间
 *
 *  @return 秒数
 */
+(int)getWeeksDisWithDate:(NSDate *)nowDate;

@end
