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

// ユーザのファイル保存場所を取得
+ (NSString *) fullPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newFileName = [fileName stringByReplacingOccurrencesOfString:@":" withString:@""];
    return [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], newFileName];
}

// 画像サイズに合わせて、UIImageViewのサイズを調整する。ただ、一定の枠内で収まるようにする。
+ (void) changeImageViewSize:(UIView *)imgView originalImageSize:(CGSize)imageSize frame:(CGRect)frame
{
    float imgHeight;
    float imgWidth;
    float shiftImgX;
    float shiftImgY;
    
    if (frame.size.width / imageSize.width >= frame.size.height / imageSize.height) {
        imgHeight = frame.size.height;
        imgWidth  = frame.size.height * imageSize.width / imageSize.height;
        shiftImgX = abs(frame.size.width - imgWidth) / 2.0f + frame.origin.x;
        shiftImgY = frame.origin.y;
    } else {
        imgHeight = frame.size.width * imageSize.height / imageSize.width;
        imgWidth  = frame.size.width;
        shiftImgX = frame.origin.x;
        shiftImgY = abs(frame.size.height - imgHeight) / 2.0f + frame.origin.y;
    }
    
    // 描画時の画像変形を防ぐため、高さを幅を整数にする
    imgView.frame = CGRectMake(ceilf(shiftImgX), ceilf(shiftImgY), ceilf(imgWidth), ceilf(imgHeight));
    _printf(@"frame x:%f, y:%f, width:%f, height:%f", imgView.frame.origin.x, imgView.frame.origin.y,
            imgView.frame.size.width, imgView.frame.size.height);
}

// 画像のリサイズ
//   originalImage : オリジナル画像
//   frameSize     : 画像を入れるフレームのサイズ
//   imageSize     : 変換後の画像のサイズ
+ (UIImage *) resizeImage:(UIImage *)originalImage frameSize:(CGSize)frameSize imageSize:(CGSize)imageSize
{
    [UIView commitAnimations];
    
    // グラフィックスコンテキストを作る
    UIGraphicsBeginImageContext(frameSize);
    
    // 画像を縮小して描画する
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = imageSize;
    [originalImage drawInRect:rect];
    
    // 描画した画像を取得する
    UIImage *shrinkedImage;
    shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return shrinkedImage;
}

// 画像に合わせて調整した、画像を表示するImageViewのサイズを取得
// 縦の画像の場合、立て一杯で横幅を調整
+ (CGSize) shrinkedImageSize:(UIImage *)image ownerView:(UIView *)imageView
{
    _printf(@"width:%f, height:%f", image.size.width, image.size.height);
    
    CGSize ctx = imageView.frame.size;
    CGSize img = image.size;
    
    if (img.width >= img.height) {
        return CGSizeMake(ctx.width,    ctx.width * img.height / img.width);
    }
    
    return CGSizeMake(ctx.height * img.width / img.height, ctx.height);
}

@end
