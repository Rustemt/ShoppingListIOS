//
//  DAHelper.h
//  TurnoverIPad
//
//  Created by LI LIN on 2013/05/23.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDKHeader.h>

#define kUserDefaultUserID @"jp.co.dreamarts.smart.TurnoverIPad"

@interface DAHelper : NSObject

+ (DAUser *)getCurrentUser;
+ (NSString *)getWeekday:(NSString *)date;
+ (NSDate *)stringToDate:(NSString *)date;
+ (NSDate *)addDay:(NSDate *)date day:(int)day;
+ (NSDate *)addMonth:(NSDate *)date month:(int)month;
+ (NSString *)getMonthString:(NSDate *)date;
+ (NSString *)getDayString:(NSDate *)date;
+ (int)getDayOfMonth:(NSDate *)date;

@end
