//
//  DateHelper.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/24/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+(NSDateFormatter *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    return formatter;
}

+(NSDateFormatter *)dateFormatWithDayMonthYear{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d";
    formatter.dateStyle = NSDateFormatterShortStyle;
    
    return formatter;
}

+(NSDateFormatter *)dateFormatHourSeconds{
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    formatter.dateFormat = @"HH:mm";
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    return formatter;
}

@end
