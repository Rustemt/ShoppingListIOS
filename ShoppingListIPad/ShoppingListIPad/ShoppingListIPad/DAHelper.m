//
//  DAHelper.m
//  TurnoverIPad
//
//  Created by LI LIN on 2013/05/23.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAHelper.h"

@implementation DAHelper

+ (DAUser *)getCurrentUser
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultUserID];
}

// 日期相关
// 获取星期
+ (NSString *)getWeekday:(NSString *)date
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy/MM/dd"];
    NSDate *theDate = [dateformat dateFromString:date];
    
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"E"];
    return [weekday stringFromDate:theDate];
}

// 字符串 to 日期对象
+ (NSDate *)stringToDate:(NSString *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    return [df dateFromString:date];
}

// 日期加法：加日
+ (NSDate *)addDay:(NSDate *)date day:(int)day
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = day;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    return [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
}

// 日期加法：加月
+ (NSDate *)addMonth:(NSDate *)date month:(int)month
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.month = month;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    return [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
}

// 获取月字符串
+ (NSString *)getMonthString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    return [dateFormatter stringFromDate:date];
}

// 获取日字符串
+ (NSString *)getDayString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    return [dateFormatter stringFromDate:date];
}

// 获取某月的日数
+ (int)getDayOfMonth:(NSDate *)date
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange daysRange = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    return daysRange.length;
}

@end
