//
//  DateUtil.m
//  DrawLib
//
//  Created by wangxiaohu on 14-12-3.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "DateUtil.h"
#import "DateUtils.h"

@implementation DateUtil


+(NSString *)changeNSDataToNSString:(NSString *)dateFormart withDate:(NSDate *) data{
    
    NSDateFormatter * dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:dateFormart];
    NSString * currentDateStr = [dateFormatter1 stringFromDate:data];
    
    return currentDateStr;
}


+(NSDate *)changeNSStringToNSData:(NSString *)dateFormart withDate:(NSString *) data{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormart];
    NSDate * date= [dateFormatter dateFromString:data];
    
    return date;
}

+(double)changeNSStringToLong:(NSString *)dateFormart withDate:(NSString *) data jz:(NSDate *)datajz{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormart];
    NSDate * date= [dateFormatter dateFromString:data];
    
    NSTimeInterval dur=[date timeIntervalSinceDate:datajz];
    
    return dur;
}


+(int)getWeeksDisWithDate:(NSDate *)nowDate{
    //获取日期
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:nowDate];
    int week = [comps weekday];
    
    NSString * date=[NSString stringWithFormat:@"%@ 00:00:00",[DateUtils getDateWithFormart:nowDate withFormart:TIME_FORMART_YYYY_MM_DD]];
    NSDate * newDate=[DateUtils changeStringToDate:date withFormart:TIME_FORMART_YYYY_MM_DD_HH_MM_SS];
    
    NSTimeInterval dur=[nowDate timeIntervalSinceDate:newDate];
    if (week==0) {
        dur=dur+5*24*60*60;
    }else{
        dur=dur+(week-2)*24*60*60;
    }
    
    return dur;
}

@end
